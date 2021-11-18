import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:template_project/widget/dialog/dialog_loading.dart';

import 'http_result_model.dart';
import 'http_status_constants.dart';

/// 请求成功回调
typedef OnHttpSuccessFunction = void Function(dynamic data, String? msg);
/// 请求失败回调
typedef OnHttpFailFunction = void Function(int code, String msg, [dynamic data]);
/// 请求异常回调
typedef OnNetWorkErrorFunction = void Function(String msg);
/// 请求, 无论什么结果都会走这个回调
typedef OnCompleteFunction = void Function();

class HttpCallback{
  OnHttpSuccessFunction? onHttpSuccessCallback;
  OnHttpFailFunction? onHttpFailCallback;
  OnNetWorkErrorFunction? onNetWorkErrorCallback;
  OnCompleteFunction? onCompleteCallback;

  HttpCallback({Future? future, this.onHttpSuccessCallback, this.onHttpFailCallback, this.onNetWorkErrorCallback, this.onCompleteCallback}) {
    if(future != null) {
      sendHttpRequest(future);
    }
  }

  /// 发送请求
  Future<void> sendHttpRequest(Future future) async {
    await future.then((value) {
      onResponse(value);
    }).catchError((e){
      onException(e);
    }).whenComplete(() {
      onComplete();
    });
  }

  /// 请求成功
  void onResponse(Response response){
    try {
      final HttpResultModel httpResult = HttpResultModel.fromJson(response.data);
      if (httpResult.code == HttpStatusConstants.code_success) {
        onHttpSuccess(httpResult.data, httpResult.msg);
      } else {
        onHttpFail(httpResult.code, httpResult.msg, httpResult.data);
      }
    }catch(e){
      //fromJson failed
      onHttpFail(HttpStatusConstants.code_error_serialization, 'data数据序列化异常');
    }
  }

  /// 请求失败
  void onException(e) {
    if(e is DioError) {
      final DioError dioError = e;
      switch (dioError.type) {
        case DioErrorType.cancel:
          break;
        case DioErrorType.receiveTimeout:
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
          onHttpFail(dioError.response!.statusCode!, handleError(dioError));
          break;
        case DioErrorType.other:
        case DioErrorType.response:
          //把它们归类为网络异常便于显示异常界面
          onNetWorkError(dioError.message);
          break;
      }
    } else {
      //未知异常
      onNetWorkError('未知异常: '+e.toString());
    }
  }

  String handleError(DioError dioError) {
    String errorDescription = '';
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorDescription = '对API服务器的请求已取消';
        break;
      case DioErrorType.connectTimeout:
        errorDescription = '与API服务器的连接超时';
        break;
      case DioErrorType.other:
        errorDescription = '由于网络连接，与API服务器的连接失败';
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = '与API服务器连接时接收超时';
        break;
      case DioErrorType.response:
        errorDescription = '收到无效的状态码: ${dioError.response!.statusCode}';
        break;
      case DioErrorType.sendTimeout:
        errorDescription = '与API服务器连接时发送超时';
        break;
    }
    return errorDescription;
  }

  /// 正常返回结果
  /// [result] 结果
  /// [msg] 附带消息
  void onHttpSuccess(dynamic result,String? msg){
    onHttpSuccessCallback?.call(result, msg);
  }

  /// 正常返回但[code]不是code_success
  /// [code] 约定的错误码
  /// [msg] 附带消息
  void onHttpFail(int code, String? msg, [dynamic result]){
    msg ??= '未知错误';
    onHttpFailCallback?.call(code, msg, result);
  }

  /// 非正常返回，通常是网络异常问题
  /// [msg] 异常描述
  void onNetWorkError(String msg){
    onNetWorkErrorCallback?.call(msg);
  }

  /// 请求完成
  void onComplete(){
    onCompleteCallback?.call();
  }
}

Future<HttpCallback> sendHttpRequest({
  required Future<Response> httpRequest,
  required bool showLoadingDialog,
  OnHttpSuccessFunction? onHttpSuccessCallback,
  OnHttpFailFunction? onHttpFailCallback,
  OnNetWorkErrorFunction? onNetWorkErrorCallback,
  OnCompleteFunction? onCompleteCallback,
}) async {
  CancelFunc? cancelFunc;
  if(showLoadingDialog) {
    cancelFunc = showDialogLoading();
  }
  final HttpCallback httpCallback = HttpCallback(
    onHttpSuccessCallback: onHttpSuccessCallback,
    onHttpFailCallback: onHttpFailCallback,
    onNetWorkErrorCallback: onNetWorkErrorCallback,
    onCompleteCallback: () {
      if(showLoadingDialog) {
        cancelFunc?.call();
        cancelFunc = null;
      }
      onCompleteCallback?.call();
    },
  );
  await httpCallback.sendHttpRequest(httpRequest);
  return httpCallback;
}
