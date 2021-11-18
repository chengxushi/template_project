/// @description 页面状态
/// @Created by yifang
/// @Date   2021/10/13
/// @email  a12162266@163.com

/// 页面状态类型
enum ViewStatus {
  /// 成功
  succeed,
  /// 加载中
  loading,
  /// 无数据
  empty,
  /// 错误
  error,
  /// 未授权/未登录
  unAuthorized,
}

/// 错误类型
enum ErrorType {
  defaultError,
  networkError,
}

class ViewStatusError {
  ViewStatusError(this.errorType, {this.message = ''}) {
    errorType ??= ErrorType.defaultError;
  }

  ErrorType errorType;
  String message;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  bool get isNetworkError => errorType == ErrorType.networkError;

  @override
  String toString() {
    return 'ViewStateError{errorType: $errorType, message: $message}';
  }
}