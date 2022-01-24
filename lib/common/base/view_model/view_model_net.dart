// @description 
// @Created by yifang
// @Date   8/9/21
// @email  a12162266@163.com

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../http/http_callback.dart';
import '../http/http_manager.dart';
import 'view_state.dart';
import 'view_state_model.dart';

abstract class ViewModelNet<M> extends ViewStateModel {
  ViewModelNet() : super(viewState: ViewState.loading);
  ///页面数据
  late M model;
  late HttpCallback httpCallBack;
  
  ///初始化数据
  @mustCallSuper
  Future<void> initData() async {
    httpCallBack = HttpCallback(
      onHttpSuccessCallback: httpSuccessCallback,
      onHttpFailCallback: httpFailCallback,
      onNetWorkErrorCallback: netWorkErrorCallback,
      onCompleteCallback: completeCallback,
    );
    await onRefresh(init: true);
  }

  /// 网络请求
  Future onLoadDataRequest();

  /// 刷新数据
  /// [init] 是否是第一次加载
  Future<void> onRefresh({bool init = false}) async {
    if(init) setLoading();
    httpCallBack.sendHttpRequest(onLoadDataRequest());
  }

  /// 请求成功
  void onSucceedStatus(dynamic resultData);

  void httpSuccessCallback(dynamic resultData, String? msg) {
    if(resultData != null) {
      onSucceedStatus(resultData);
      setSucceed();
    } else {
      setEmpty();
    }
  }

  void httpFailCallback(int code, String msg, [dynamic data]) {
    setError(msg);
  }

  void netWorkErrorCallback(String msg) {
    BotToast.showText(text: msg);
    setError(msg);
  }

  void completeCallback() {}
  
  ///显示Toast
  void showToast({String? message}) {
    if (viewStateError != null || message != null) {
      message ??= viewStateError!.message;
      BotToast.showText(text: message!);
    }
  }

  @override
  void dispose() {
    HttpManager.instance.cancel(getTagName());
    super.dispose();
  }

  String getTagName(){
    return runtimeType.toString();
  }
}

abstract class ViewModelNet2<M, S> extends ViewModelNet<M> {
  S? model2;
}