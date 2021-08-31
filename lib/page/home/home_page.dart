// @description 主页
// @Created by yifang
// @Date   2021/8/31
// @email  a12162266@163.com

import 'package:ff_annotation_route_core/ff_annotation_route_core.dart';
import 'package:flutter/material.dart';
import 'package:template_project/model/test_model.dart';
import 'package:template_project/route/template_project_routes.dart';

@FFRoute(name: '/', description: 'home')
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(
              context,
              Routes.testPage.name,
              arguments: Routes.testPage.d(
                list: [1],
                testModel: TestModel(2, '测试参数'),
              )
            );
          },
          child: Text('首页'),
        ),
      ),
    );
  }
}