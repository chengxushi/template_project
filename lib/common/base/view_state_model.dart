import 'package:flutter/material.dart';
import 'view_state.dart';

abstract class ViewStateModel with ChangeNotifier {
  /// 根据状态构造
  /// 子类可以在构造函数指定需要的页面状态
  ViewStateModel({ViewState? viewState}) {
    _viewState = viewState ?? ViewState.succeed;
  }

  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为succeed,可在viewModel的构造方法中指定;
  late ViewState _viewState;
  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }

  ViewStateError? _viewStateError;
  ViewStateError? get viewStateError => _viewStateError;

  String? get errorMessage => _viewStateError?.message;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  bool get loading => viewState == ViewState.loading;
  
  bool get succeed => viewState == ViewState.succeed;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  bool get unAuthorized => viewState == ViewState.unAuthorized;

  void setSucceed() {
    viewState = ViewState.succeed;
  }

  void setLoading() {
    viewState = ViewState.loading;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setError(String msg) {
    viewState = ViewState.error;
    _viewStateError = ViewStateError(ErrorType.defaultError, message: msg);
  }

  void setNetworkError(String msg) {
    viewState = ViewState.error;
    _viewStateError = ViewStateError(ErrorType.networkError, message: msg);
  }

  void setUnAuthorized() {
    viewState = ViewState.unAuthorized;
    onUnAuthorizedException();
  }

  /// 未授权的回调
  void onUnAuthorizedException() {}

  @override
  String toString() {
    return 'ViewStateModel{_viewState: $viewState, _viewStateError: $_viewStateError}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
