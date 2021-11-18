import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// @description 网络请求类
/// @Created by yifang
/// @Date   2021/10/13
/// @email  a12162266@163.com

/// http 请求方法的枚举
enum HttpMethod {
  get,
  post,
  delete,
  put,
  path,
  head,
  upload,
  download,
}

class HttpManager {

  /// 连接超时时间, 单位是毫秒
  final int _connectTimeout = 20000;
  /// 接收超时时间, 单位是毫秒
  final int _receiveTimeout = 20000;

  /// 同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  final Map<String, CancelToken> _cancelTokens =  <String, CancelToken>{};

  static const _methodValues = {
    HttpMethod.get: 'get',
    HttpMethod.post: 'post',
    HttpMethod.delete: 'delete',
    HttpMethod.put: 'put',
    HttpMethod.path: 'path',
    HttpMethod.head: 'head',
    HttpMethod.upload: 'upload',
    HttpMethod.download: 'download',
  };

  Dio? _dio;
  // 无论是new还是_getInstance都是返回同一个实例
  factory HttpManager() => _getInstance();
  static HttpManager get instance => _getInstance();
  static HttpManager? _instance;

  /// 初始化
  HttpManager._internal() {
    _dio ??= Dio(BaseOptions(
      // 连接服务器超时时间，单位是毫秒
      connectTimeout: _connectTimeout,
      // 接收超时时间
      receiveTimeout: _receiveTimeout,
      headers: {},
    ));
  }

  static HttpManager _getInstance() {
    _instance ??= HttpManager._internal();
    return _instance!;
  }

  /// 设置 请求 通用配置
  void setOptions({BaseOptions? options, List<Interceptor>? interceptors}){
    if (options != null)
      _dio!.options = options;

    if (interceptors != null && interceptors.isNotEmpty) {
      _dio!.interceptors.addAll(interceptors);
    }
  }

  /// 加入拦截器，也可以通过 setOptions 来设置
  void addInterceptors(List<Interceptor> interceptors){
    if (interceptors.isNotEmpty) {
      _dio!.interceptors.addAll(interceptors);
    }
  }

  /// 加入统一请求头, 相同key存在则会替换
  void addHeader(Map<String, dynamic> headers){
    _dio!.options.headers.addEntries(headers.entries);
  }

  /// 移除请求头, 相同key存在则会替换
  void removeHeader(String headerKey){
    _dio!.options.headers.remove(headerKey);
  }

  /// 加入baseUrl，也可以通过 setOptions 来设置
  void setBaseUrl(String baseUrl){
    _dio!.options.baseUrl = baseUrl;
  }

  /// get 请求
  Future<Response<T?>> get<T>({required String url, Options? option, Map<String, dynamic>? params, String? tag}) {
    return requestHttp(url, option: option, method: HttpMethod.get, params: params, tag: tag);
  }

  /// post 请求
  Future<Response<T?>> post<T>({required String url, Options? option, Map<String, dynamic>? params, String? tag}) {
    return requestHttp(url, option: option, method: HttpMethod.post, params: params, tag: tag);
  }

  /// put 请求
  Future<Response<T?>> put<T>({required String url, Options? option, Map<String, dynamic>? params, String? tag}) {
    return requestHttp(url, option: option, method: HttpMethod.put, params: params, tag: tag);
  }

  /// delete 请求
  Future<Response<T?>> delete<T>({required String url, Options? option, Map<String, dynamic>? params, String? tag}) {
    return requestHttp(url, option: option, method: HttpMethod.delete, params: params, tag: tag);
  }

  /// path 请求
  Future<Response<T?>> path<T>({required String url, Options? option, Map<String, dynamic>? params, String? tag}) {
    return requestHttp(url, option: option, method: HttpMethod.path, params: params, tag: tag);
  }

  /// head 请求
  Future<Response<T?>> head<T>({required String url, Options? option, Map<String, dynamic>? params, String? tag}) {
    return requestHttp(url, option: option, method: HttpMethod.head, params: params, tag: tag);
  }

  /// 上传文件
  Future<Response<T?>> upload<T>({required String url, Options? option, FormData? data, Map<String, dynamic>? params, String? tag, ProgressCallback? onProgress}) {
    return requestHttp(url, option: option, method: HttpMethod.upload, data: data, params: params, tag: tag, onProgress: onProgress);
  }

  /// 下载文件
  Future<Response<T?>> download<T>({required String url, Options? option, String? savePath, FormData? data, Map<String, dynamic>? params, String? tag, ProgressCallback? onProgress}) {
    return requestHttp(url, option: option, savePath: savePath, method: HttpMethod.download, data: data, params: params, tag: tag, onProgress: onProgress);
  }

  /// Dio request 方法
  Future<Response<T?>> requestHttp<T>(
    String url, {
    HttpMethod method = HttpMethod.get, //请求类型
    Map<String, dynamic>? params, //get请求的请求参数
    FormData? data, //其他请求的请求参数
    Options? option,
    String? savePath,
    String? tag, //取消请求的标志
    ProgressCallback? onProgress,
  }) {
    CancelToken? cancelToken;
    if (tag != null) {
      cancelToken = _cancelTokens[tag] ?? CancelToken();
      _cancelTokens[tag] = cancelToken;
    }

    option ??= Options(method: _methodValues[method]);
    if (method == HttpMethod.upload) {
      option.method = _methodValues[HttpMethod.post];
    }

    /// 不同请求方法，不同的请求参数。按实际项目需求分，这里 get 是 queryParameters，其它用 data. FormData 也是 data
    /// 注意: 只有 post 方法支持发送 FormData.
    switch (method) {
      case HttpMethod.get:
        return _dio!.request(url, queryParameters: params, options: option, cancelToken: cancelToken);
      case HttpMethod.upload:
        return _dio!.request(url, onSendProgress: onProgress, data: data, queryParameters: params, options: option, cancelToken: cancelToken);
      case HttpMethod.download:
        return _dio!.download(url, savePath, onReceiveProgress: onProgress, data: data, queryParameters: params, cancelToken: cancelToken) as Future<Response<T?>>;
      default:
        return _dio!.request(url, data: params, options: option, cancelToken: cancelToken);
    }
  }

  ///取消网络请求
  void cancel(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag]!.isCancelled) {
        _cancelTokens[tag]!.cancel();
      }
      _cancelTokens.remove(tag);
    }
  }
}

Future<void> dioGet({required String url, Options? option, Map<String, dynamic>? params, String? tag}) async {
  try {
    final Response<String?> response = await HttpManager.instance.get(url: 'url');
    final Map<String, dynamic>? data = json.decode(response.data!);

  } on DioError catch(e) {

  }
}