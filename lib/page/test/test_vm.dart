import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:template_project/common/base/http/http_manager.dart';
import 'package:template_project/common/base/view_model/view_model_net.dart';
import 'package:template_project/common/base/view_model/view_model_stateful.dart';
import 'package:template_project/model/test_model.dart';

import 'package:ff_annotation_route_core/ff_annotation_route_core.dart';

/// @description
/// @Created by yifang
/// @Date   2021/11/17
/// @email  a12162266@163.com

class TestVm extends ViewModelNet<TestModel> {

  @override
  Future<void> initData() async {
    super.initData();
  }

  @override
  Future onLoadDataRequest() {
    return Future.delayed(
        Duration(seconds: 2),
        () => Response(requestOptions: RequestOptions(path: 'path'), data: {
              'status': true,
              'code': 200,
              'message': 'success',
              'result': {'text': 'yifang', 'id': 100}
            }));
  }

  @override
  void onSucceedStatus(resultData) {
    model = TestModel.fromJson(resultData);
  }

}

@FFRoute(
  name: '/TestVmPage',
  description: '',
)
class TestVmPage extends StatefulWidget {
  @override
  _TestVmPageState createState() => _TestVmPageState();
}

class _TestVmPageState extends ViewModelStatefulState<TestVmPage, TestVm> {

  @override
  void initState() {
    super.initState();
  }

  @override
  TestVm createViewModel() {
    return TestVm();
  }

  @override
  String setTitle() {
    return '测试';
  }

  @override
  Widget succeedWidget() {
    return Text(viewModel.model.text);
  }
}