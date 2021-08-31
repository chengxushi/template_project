// @description 圆形加载等待框
// @Created by yifang
// @Date   4/8/21
// @email  a12162266@163.com

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../circular_progress_indicator.dart';

CancelFunc showDialogLoading() {
  final CancelFunc cancelFunc = BotToast.showCustomLoading(
    toastBuilder: (_) => Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedRotationBox(
            child: GradientCircularProgressIndicator(
              radius: 20,
              colors: [Colors.grey[500], Colors.grey[300], Colors.grey[50],],
              value: 0.8,
              backgroundColor: Colors.transparent,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Text(
              '加载中...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    ),
    ignoreContentClick: true,
    backgroundColor: Colors.transparent,
    backButtonBehavior: BackButtonBehavior.ignore
  );
  return cancelFunc;
}
