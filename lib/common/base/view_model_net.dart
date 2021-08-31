// @description 
// @Created by yifang
// @Date   8/9/21
// @email  a12162266@163.com

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'view_state.dart';
import 'view_state_model.dart';

abstract class ViewModelNet<T> extends ViewStateModel {
  ViewModelNet() : super(viewState: ViewState.loading);
  ///页面数据
  T model;
  
  ///初始化数据
  @mustCallSuper
  Future<void> initData() async {
    await loadData();
  }

  ///加载数据
  Future<void> loadData();
  
  ///显示Toast
  void showToast({String message}) {
    if (viewStateError != null || message != null) {
      message ??= viewStateError.message;
      BotToast.showText(text: message);
    }
  }
}

abstract class ViewModelNet2<T, S> extends ViewModelNet<T> {
  S model2;
}