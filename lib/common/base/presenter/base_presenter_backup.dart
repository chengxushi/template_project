import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';

import '../http/http_callback.dart';
import '../http/http_manager.dart';
import '../viewable/base_viewable.dart';
import 'view_status.dart';

/// @description
/// @Created by yifang
/// @Date   2021/10/13
/// @email  a12162266@163.com

abstract class BasePresenter<V extends BaseViewable>{

  BasePresenter(this.viewable);

  /// 与页面之间连接的接口
  V? viewable;

  /// 首次进入页面加载
  bool firstLoad = true;

  /// 页面状态
  ViewStatus? _viewStatus;
  ViewStatus? get viewStatus => _viewStatus;

  /// 错误类型
  ViewStatusError? _viewStatusError;
  ViewStatusError? get viewStatusError => _viewStatusError;

  String? get errorMessage => _viewStatusError?.message;

  bool get isSucceedStatus => viewStatus == ViewStatus.succeed;
  bool get isEmptyStatus => viewStatus == ViewStatus.empty;
  bool get isLoadingStatus => viewStatus == ViewStatus.loading;
  bool get isErrorStatus => viewStatus == ViewStatus.error;

  set viewStatus(ViewStatus? viewStatus) {
    _viewStatusError = null;
    _viewStatus = viewStatus;
  }

  void setSucceed() {
    viewStatus = ViewStatus.succeed;
  }

  void setEmptyStatus(String msg) {
    viewStatus = ViewStatus.empty;
    viewable!.onEmptyStatus(msg);
  }

  void setLoadingStatus() {
    viewStatus = ViewStatus.loading;
    viewable!.onLoadingStatus();
  }

  void setErrorStatus(int code, String msg, Object? data) {
    viewStatus = ViewStatus.error;
    _viewStatusError = ViewStatusError(ErrorType.defaultError, message: msg);
    viewable!.onErrorStatus(code, msg, data);
  }

  void setNetworkErrorStatus(String msg) {
    viewStatus = ViewStatus.error;
    _viewStatusError = ViewStatusError(ErrorType.networkError, message: msg);
    viewable!.onNetworkErrorStatus(msg);
  }

  void onLoadComplete(){
    viewable!.onLoadComplete();
  }

  ///显示Toast
  void showToast({String? message}) {
    if (_viewStatusError != null || message != null) {
      message ??= _viewStatusError!.message;
      BotToast.showText(text: message);
    }
  }

  void dispose() {
    viewable = null;
    HttpManager.instance.cancel(getTagName());
  }

  HttpCallback? httpCallBack;

  /// 网络请求
  Future onLoadDataHttpRequest();

  /// 刷新/加载数据
  void onLoadData();

  Future<void> onCallHttpRequest(Future future, [HttpCallback? httpCallback]) async {
    await future.then((value) {
      httpCallback?.onResponse(value);
    }).catchError((e){
      httpCallback?.onException(e);
    }).whenComplete(() {
      httpCallback?.onComplete();
    });
  }

  String getTagName(){
    return runtimeType.toString();
  }
}