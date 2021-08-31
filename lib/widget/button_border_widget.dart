import 'package:flutter/material.dart';
import '../common/info/app_color.dart';

/// @description  有边框的圆角按钮
/// @Created by yifang
/// @Date   4/7/21
/// @email  a12162266@163.com

class ButtonBorderWidget extends StatelessWidget {
  
  const ButtonBorderWidget({
    Key key,
    @required this.onTop,
    this.text = '确定',
    this.textColor = Colors.white,
    this.textSize = 14,
    this.margin,
    this.borderColor = AppColor.themeColor,
    this.borderWidth = 1,
    this.borderRadius = 999,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.width,
    this.height,
  }) : super(key: key);
  
  final GestureTapCallback onTop;
  final String text;
  final Color textColor;
  final double textSize;
  final EdgeInsetsGeometry margin;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double height;
  final double width;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTop,
      child: Container(
        padding: padding,
        margin: margin,
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(text, style: TextStyle(fontSize: textSize, color: textColor),),
      ),
    );
  }
}