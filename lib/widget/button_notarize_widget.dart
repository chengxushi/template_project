// @description 带有背景色的圆角按钮
// @Created by yifang
// @Date   4/7/21
// @email  a12162266@163.com

import 'package:flutter/material.dart';
import '../common/info/app_color.dart';

class ButtonNotarizeWidget extends StatelessWidget {
  
  const ButtonNotarizeWidget({
    Key? key,
    required this.onTop,
    this.text = '确定',
    this.textColor = Colors.white,
    this.textSize = 14,
    this.backgroundColor = AppColor.themeColor,
    this.margin,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.borderWidth = 2,
    this.borderRadius = 999,
    this.width,
    this.height,
  }) : super(key: key);
  
  final GestureTapCallback onTop;
  final String text;
  final Color textColor;
  final double textSize;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double? height;
  final double? width;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTop,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: backgroundColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: Text(text, style: TextStyle(fontSize: textSize, color: textColor),),
      ),
    );
  }
}