/// @description 接口, 页面与presenter之间的接口
/// @Created by yifang
/// @Date   2021/10/13
/// @email  a12162266@163.com

abstract class BaseViewable {

  /// 返回绑定的Presenter, 在page页面必须重写这个方法
  dynamic returnBindingPresenter();

  /// 刷新状态
  /// [refreshing] 是否刷新
  void onRefreshing(bool refreshing);

  /// 空数据状态
  void onEmptyStatus(String msg);

  /// 加载中状态
  void onLoadingStatus();

  /// 错误状态
  void onErrorStatus(int code, String msg, dynamic data);

  /// 网络异常状态
  void onNetworkErrorStatus(String msg);

  /// 数据回调，如果是列表页并且data不是直接列表数据而是先包裹一层或几层需要自己刨开拿到列表的请参考BaseListWidget的该方法逻辑再重写该方法
  void onDataSetChange(dynamic data, String msg);

  void onLoadComplete();
}