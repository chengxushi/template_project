import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provider封装类
///
/// 方便数据初始化
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  const ProviderWidget({
    Key key,
    @required this.builder,
    @required this.viewModel,
    this.child,
    this.onModelReady,
    this.autoDispose = true,
  }) : super(key: key);

  final ValueWidgetBuilder<T> builder;
  final T viewModel;
  final Widget child;
  final Function(T model) onModelReady;
  final bool autoDispose;

  @override
  ProviderWidgetState<T> createState() => ProviderWidgetState<T>();
}

class ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;
    widget.onModelReady?.call(viewModel);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose == null){
      viewModel.dispose();
    }else if (widget.autoDispose) viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: viewModel,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  const ProviderWidget2({
    Key key,
    @required this.builder,
    @required this.model1,
    @required this.model2,
    this.child,
    this.onModelReady,
    this.autoDispose = true,
  }) : super(key: key);
  
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
  builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A model1, B model2) onModelReady;
  final bool autoDispose;

  @override
  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    widget.onModelReady?.call(model1, model2);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose == null){
      model1.dispose();
      model2.dispose();
    }else if (widget.autoDispose) {
      model1.dispose();
      model2.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>.value(value: model1),
          ChangeNotifierProvider<B>.value(value: model2),
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}

class ProviderWidget3<A extends ChangeNotifier, B extends ChangeNotifier, C extends ChangeNotifier>
    extends StatefulWidget {
  const ProviderWidget3({
    Key key,
    @required this.builder,
    @required this.model1,
    @required this.model2,
    @required this.model3,
    this.child,
    this.onModelReady,
    this.autoDispose = true,
  }) : super(key: key);
  
  final Widget Function(BuildContext context, A model1, B model2, C model3, Widget child)
  builder;
  final A model1;
  final B model2;
  final C model3;
  final Widget child;
  final Function(A model1, B model2, C model3) onModelReady;
  final bool autoDispose;

  @override
  _ProviderWidgetState3<A, B, C> createState() => _ProviderWidgetState3<A, B, C>();
}

class _ProviderWidgetState3<A extends ChangeNotifier, B extends ChangeNotifier, C extends ChangeNotifier>
    extends State<ProviderWidget3<A, B, C>> {
  A model1;
  B model2;
  C model3;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    model3 = widget.model3;
    widget.onModelReady?.call(model1, model2, model3);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose == null){
      model1.dispose();
      model2.dispose();
      model3.dispose();
    }else if (widget.autoDispose) {
      model1.dispose();
      model2.dispose();
      model3.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>.value(value: model1),
          ChangeNotifierProvider<B>.value(value: model2),
          ChangeNotifierProvider<C>.value(value: model3),
        ],
        child: Consumer3<A, B, C>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}
