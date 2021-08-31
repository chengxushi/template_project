// @description 
// @Created by yifang
// @Date   8/11/21
// @email  a12162266@163.com

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/common_appbar.dart';
import '../../widget/state_widget.dart';
import 'view_model_net.dart';
import 'view_state.dart';

abstract class ViewModelStateful extends StatefulWidget {
  const ViewModelStateful({Key key}):super(key:key);
  
  @override
  State<ViewModelStateful> createState() => createBaseState();
  
  State<StatefulWidget> createBaseState();
}

abstract class ViewModelStatefulState<T extends ViewModelStateful, V extends ViewModelNet> extends State<T> {
  V _viewModel;
  BuildContext _mContext;

  V get viewModel => _viewModel;
  BuildContext get mContext => _mContext;
  
  @override
  void initState() {
    super.initState();
    _viewModel = createViewModel();
    _viewModel.initData().whenComplete(() =>onCompleted());
  }
  
  @override
  void dispose() {
    _viewModel?.dispose();
    super.dispose();
  }
  
  ///创建ViewModel
  V createViewModel();
  
  ///initData加载数据完成时
  void onCompleted(){}

  // TODO(hjj): 不重写Appbar的时候, 这个是必须的, 重写setAppbar的时候, 这个方法又多余了起来.
  // TODO(hjj): 待优化.
  ///设置标题
  String setTitle();
  
  ///设置Appbar的actions
  List<Widget> setActions() => null;
  
  ///可以重写这个方法, 设置Appbar
  PreferredSizeWidget setAppbar() {
    return CommonAppbar(setTitle(), actions: setActions(),);
  }
  
  Color setBackgroundColor() => null;
  
  ///成功页面的组件
  Widget succeedWidget();
  
  ///加载等待组件
  Widget loadingWidget() {
    return const LoadWidget();
  }
  
  ///错误组件
  Widget errorWidget() {
    return GestureDetector(
      onTap: () => _viewModel.loadData(),
      child: TGErrorWidget(
        text: viewModel.viewStateError.message,
      ),
    );
  }
  
  ///空组件
  Widget emptyWidget() {
    return const EmptyWidget();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar(),
      backgroundColor: setBackgroundColor(),
      body: ChangeNotifierProvider<V>.value(
        value: _viewModel,
        child: Consumer<V>(
          builder: (context, viewModel, child) {
            _mContext = context;
            switch(viewModel.viewState){
              case ViewState.succeed:
                return succeedWidget();
              case ViewState.empty:
                return emptyWidget();
              case ViewState.loading:
                return loadingWidget();
              default:
                return errorWidget();
            }
          },
        ),
      ),
    );
  }
  
  void showToast(String message, {bool center = false}) {
    if(center) {
      BotToast.showText(text: message, align: Alignment.center);
    } else {
      BotToast.showText(text: message);
    }
  }
}