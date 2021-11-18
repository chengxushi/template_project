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
  //刷新状态
  bool refreshing = false;
  //空数据状态
  bool statusEmpty = false;
  //加载中状态
  bool statusLoading = false;
  //错误状态
  bool statusError = false;
  //网络异常状态
  bool statusNetworkError = false;
  /// 首次进入页面加载
  bool firstLoad = true;

  /// 错误类型
  ViewStatusError? _viewStatusError;
  ViewStatusError? get viewStatusError => _viewStatusError;

  String? get errorMessage => _viewStatusError?.message;

  bool get isRefreshing => refreshing;
  bool get isStatusEmpty => statusEmpty;
  bool get isStatusLoading => statusLoading;
  bool get isStatusError => statusError;

  void setRefreshing(bool refreshing) {
    this.refreshing = refreshing;
    viewable!.onRefreshing(refreshing);
  }

  void setStatusEmpty(String msg) {
    statusEmpty = true;
    viewable!.onEmptyStatus(msg);
  }

  void setLoadingStatus() {
    statusLoading = true;
    viewable!.onLoadingStatus();
  }

  void setErrorStatus(int code, String msg, Object data) {
    statusError = true;
    _viewStatusError = ViewStatusError(ErrorType.defaultError, message: msg);
    viewable!.onErrorStatus(code, msg, data);
  }

  void setNetworkErrorStatus(String msg) {
    statusNetworkError = true;
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