/// @description 网络请求返回数据的统一解析, 可根据实际项目修改
/// @Created by yifang
/// @Date   2021/10/13
/// @email  a12162266@163.com

class HttpResultModel {
  HttpResultModel(this.status, this.code, this.msg, this.data);

  factory HttpResultModel.fromJson(Map<String, dynamic> json) {
    return HttpResultModel(
      json.containsKey('successCode')
          ? json['successCode'] as bool
          : json['status'] as bool,
      json.containsKey('code')
          ? json['code']
          : json['errorCode'],
      json['message'] as String,
      json['result'],
    );
  }

  bool status;

  ///服务端响应代号
  int code;

  /// 服务器响应消息:简单结果描述
  String msg;

  ///服务器响应数据
  dynamic data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errorCode'] = code;
    data['message'] = msg;
    data['data'] = data;
    return data;
  }
}