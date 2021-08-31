// @description 
// @Created by yifang
// @Date   2021/8/31
// @email  a12162266@163.com

import 'package:flutter/material.dart';

import 'package:ff_annotation_route_core/ff_annotation_route_core.dart';
@FFArgumentImport()
import 'package:template_project/model/test_model.dart';

@FFRoute(
  name: 'testPage',
  description: '测试法法路由',
)
class TestPage extends StatelessWidget {
  
  const TestPage({this.list, this.testModel});
  
  final List<int> list;
  final TestModel testModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(testModel.text),
      ),
    );
  }
}