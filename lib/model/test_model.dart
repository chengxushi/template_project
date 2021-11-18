// @description 
// @Created by yifang
// @Date   2021/8/31
// @email  a12162266@163.com

class TestModel {
  
  TestModel(this.id, this.text);
  
  int id;
  String text;

  factory TestModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    String text = json['text'];
    return TestModel(id, text);
  }

}