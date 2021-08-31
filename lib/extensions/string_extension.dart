// @description string的扩展方法
// @Created by yifang
// @Date   7/5/21
// @email  a12162266@163.com

extension StringExtension on String {
  ///修复dart的字符串bug
  ///如果字符串是汉字加一长串数字, 后面的一长串数字默认是一个整体
  ///这个扩展方法解决了这个问题
  String get notBreak => replaceAll('', '\u{200B}');
}