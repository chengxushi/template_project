/// @description  拦截器列表
/// @Created by huang
/// @Date   2021/4/1
/// @email  a12162266@163.com

import 'dart:convert';

import 'package:d_logger/d_logger.dart';
import 'package:dio/dio.dart';

///信息打印拦截器
class TGLogIntercept extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final Map<String, dynamic> map = {};
    map['url'] = options.uri.toString();
    if(options.queryParameters.isNotEmpty){
      map['请求方式-${options.method.toLowerCase()}'] = options.queryParameters.toString();
    }
    if(options.data != null){
      map['请求方式-${options.method.toLowerCase()}'] = options.data.toString();
    }
    if(options.headers.isNotEmpty){
      map['headers'] = options.headers;
    }
    Log.d('请求数据 👀', tag: 'DioUtils:',);
    Log.d(json.encode(map), tag: 'DioUtils:', isJson: true, hasLine: true);
    super.onRequest(options, handler);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d('响应数据 🎃', tag: 'DioUtils:',);
    // Log.d('code = ${response.statusCode}', tag: 'HttpUtil->interceptors');
    if(response.extra.isNotEmpty){
      Log.d('extra = ${response.extra}', tag: 'DioUtils:');
      // Log.d('extra = ${response.extra}', tag: 'HttpUtil->interceptors');
    }
    Log.d('请求url: ${response.realUri.toString()}', tag: 'DioUtils:',);
    Log.d(response.data, tag: 'DioUtils:', isJson: true, hasLine: true);
    // Log.d('data = ${response.data}', tag: 'HttpUtil->interceptors');
    super.onResponse(response, handler);
  }
  
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.d('异常报错 🤡', tag: 'DioUtils:',);
    Log.e(err, tag: 'DioUtils:', hasLine: true);
    super.onError(err, handler);
  }
}