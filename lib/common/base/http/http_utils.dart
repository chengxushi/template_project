import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:template_project/widget/dialog/dialog_loading.dart';

import 'http_callback.dart';
import 'http_manager.dart';

/// @description Http工具类
/// @Created by yifang
/// @Date   2021/11/17
/// @email  a12162266@163.com

Future<HttpCallback> httpRequest({
  required Future<Response> httpRequest,
  bool showLoadingDialog = false,
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

Future<void> dioGet(String url, {
  // 请求参数
  Map<String, dynamic>? params,
  Options? options,
  // 成功回调
  required OnHttpSuccessFunction onSuccess,
  // 失败回调
  required OnHttpFailFunction onError,
  OnNetWorkErrorFunction? onNetWorkErrorCallback,
  OnCompleteFunction? onCompleteCallback,
  // 是否显示加载等待弹框
  bool showLoadingDialog = false,
  // 取消请求的标志
  String? tag,
}) async {
  await httpRequest(
    httpRequest: HttpManager.instance.get(url: url, params: params, option: options, tag: tag),
    onHttpSuccessCallback: onSuccess,
    onHttpFailCallback: onError,
    onNetWorkErrorCallback: onNetWorkErrorCallback,
    onCompleteCallback: onCompleteCallback,
    showLoadingDialog: showLoadingDialog,
  );
}

Future<void> dioPost(String url, {
  // 请求参数
  Map<String, dynamic>? params,
  Options? options,
  // 成功回调
  required OnHttpSuccessFunction onSuccess,
  // 失败回调
  required OnHttpFailFunction onError,
  OnNetWorkErrorFunction? onNetWorkErrorCallback,
  OnCompleteFunction? onCompleteCallback,
  // 是否显示加载等待弹框
  bool showLoadingDialog = false,
  // 取消请求的标志
  String? tag,
}) async {
  await httpRequest(
    httpRequest: HttpManager.instance.post(url: url, params: params, option: options, tag: tag),
    onHttpSuccessCallback: onSuccess,
    onHttpFailCallback: onError,
    onNetWorkErrorCallback: onNetWorkErrorCallback,
    onCompleteCallback: onCompleteCallback,
    showLoadingDialog: showLoadingDialog,
  );
}

Future<void> dioDelete(String url, {
  // 请求参数
  Map<String, dynamic>? params,
  Options? options,
  // 成功回调
  required OnHttpSuccessFunction onSuccess,
  // 失败回调
  required OnHttpFailFunction onError,
  OnNetWorkErrorFunction? onNetWorkErrorCallback,
  OnCompleteFunction? onCompleteCallback,
  // 是否显示加载等待弹框
  bool showLoadingDialog = false,
  // 取消请求的标志
  String? tag,
}) async {
  await httpRequest(
    httpRequest: HttpManager.instance.delete(url: url, params: params, option: options, tag: tag),
    onHttpSuccessCallback: onSuccess,
    onHttpFailCallback: onError,
    onNetWorkErrorCallback: onNetWorkErrorCallback,
    onCompleteCallback: onCompleteCallback,
    showLoadingDialog: showLoadingDialog,
  );
}

Future<void> dioPut(String url, {
  // 请求参数
  Map<String, dynamic>? params,
  Options? options,
  // 成功回调
  required OnHttpSuccessFunction onSuccess,
  // 失败回调
  required OnHttpFailFunction onError,
  OnNetWorkErrorFunction? onNetWorkErrorCallback,
  OnCompleteFunction? onCompleteCallback,
  // 是否显示加载等待弹框
  bool showLoadingDialog = false,
  // 取消请求的标志
  String? tag,
}) async {
  await httpRequest(
    httpRequest: HttpManager.instance.put(url: url, params: params, option: options, tag: tag),
    onHttpSuccessCallback: onSuccess,
    onHttpFailCallback: onError,
    onNetWorkErrorCallback: onNetWorkErrorCallback,
    onCompleteCallback: onCompleteCallback,
    showLoadingDialog: showLoadingDialog,
  );
}