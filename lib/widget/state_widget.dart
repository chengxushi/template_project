// @description 
// @Created by yifang
// @Date   4/23/21
// @email  a12162266@163.com

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key key, this.text = '暂无数据'}) : super(key: key);
  
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bg_empty.png',
              height: 184,
              width: 184,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(text, style: const TextStyle(fontSize: 16, color: Color(0xFF999999),),),
            ),
          ],
        ),
      ),
    );
  }
}

class TGErrorWidget extends StatelessWidget {
  const TGErrorWidget({Key key, this.text = '加载失败', this.onTop, this.errorMessage = ''}) : super(key: key);
  
  final String text;
  final GestureTapCallback onTop;
  final String errorMessage;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTop,
              child: Image.asset(
                'assets/images/bg_error.png',
                height: 178,
                width: 178,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(text, style: const TextStyle(fontSize: 16, color: Color(0xFF999999),),),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadWidget extends StatelessWidget {
  const LoadWidget({Key key,}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Center(child: CupertinoActivityIndicator());
  }
}