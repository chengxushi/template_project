// @description 
// @Created by yifang
// @Date   7/1/21
// @email  a12162266@163.com

import 'package:flutter/material.dart';

enum ImageShape {
  circle, //圆形
  rectangle, //圆角矩形
  none, //无
}

class LoadingImage extends StatelessWidget {
  const LoadingImage({
    Key key,
    @required this.url,
    this.defaultImage = 'icon_head.png',
    this.errorImage = 'icon_head.png',
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.cacheHeight,
    this.cacheWidth,
    this.imageShape = ImageShape.none,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  final String url;
  final String defaultImage;
  final String errorImage;
  final double height;
  final double width;
  final int cacheHeight;
  final int cacheWidth;
  final BoxFit fit;
  final ImageShape imageShape;
  final BorderRadius borderRadius;
  
  @override
  Widget build(BuildContext context) {
    Widget w = FadeInImage.assetNetwork(
      placeholder: 'assets/images/$defaultImage',
      image: url ?? '',
      imageErrorBuilder: (_, __, ___,) {
        return Image.asset(
          'assets/images/$errorImage',
          height: height,
          width: width,
          fit: BoxFit.cover,
        );
      },
      height: height,
      width: width,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 100),
      fadeOutDuration: const Duration(milliseconds: 100),
    );
    switch(imageShape) {
      case ImageShape.circle:
        w = ClipOval(child: w);
        break;
      case ImageShape.rectangle:
        w = ClipRRect(child: w, borderRadius: borderRadius);
        break;
      default:
        break;
    }
    return w;
  }
}