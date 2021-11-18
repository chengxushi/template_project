import '../http/http_callback.dart';
import '../viewable/base_viewable.dart';
import 'base_presenter_backup.dart';

/// @description
/// @Created by yifang
/// @Date   2021/10/15
/// @email  a12162266@163.com

abstract class BaseNetPresenter<V extends BaseViewable> extends BasePresenter<V>{

  BaseNetPresenter(V viewable) : super(viewable) {
    httpCallBack = HttpCallback(
      onHttpSuccessCallback: (dynamic resultData, String? msg) {
        if(resultData != null) {
          viewable.onDataSetChange(resultData, msg ?? '');
        } else {
          setEmptyStatus(msg ?? '');
        }
      },
      onHttpFailCallback: (int code, String msg, [dynamic data]) {
        setErrorStatus(code, msg, data);
      },
      onNetWorkErrorCallback: (String msg) {
        setNetworkErrorStatus(msg);
      },
      onCompleteCallback: () {
        onLoadComplete();
      }
    );
  }

  /// 刷新/加载数据
  @override
  void onLoadData() {
    if(firstLoad) {
      firstLoad = false;
      setLoadingStatus();
    }
    onCallHttpRequest(onLoadDataHttpRequest(), httpCallBack);
  }

}