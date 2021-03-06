// GENERATED CODE - DO NOT MODIFY MANUALLY
// **************************************************************************
// Auto generated by https://github.com/fluttercandies/ff_annotation_route
// **************************************************************************

import 'package:template_project/model/test_model.dart';

const List<String> routeNames = <String>[
  '/',
  '/TestVmPage',
  'testPage',
];

class Routes {
  const Routes._();

  /// 'home'
  ///
  /// [name] : '/'
  ///
  /// [description] : 'home'
  static const String root = '/';

  /// '/TestVmPage'
  ///
  /// [name] : '/TestVmPage'
  static const String testVmPage = '/TestVmPage';

  /// '测试法法路由'
  ///
  /// [name] : 'testPage'
  ///
  /// [description] : '测试法法路由'
  ///
  /// [constructors] :
  ///
  /// TestPage : [List<int>? list, TestModel? testModel]
  static const _TestPage testPage = _TestPage();
}

class _TestPage {
  const _TestPage();

  String get name => 'testPage';

  Map<String, dynamic> d({List<int>? list, TestModel? testModel}) =>
      <String, dynamic>{
        'list': list,
        'testModel': testModel,
      };

  @override
  String toString() => name;
}
