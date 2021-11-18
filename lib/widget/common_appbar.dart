// @description 
// @Created by yifang
// @Date   4/19/21
// @email  a12162266@163.com

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget{
  const CommonAppbar(this.title, {Key? key, this.actions}) : super(key: key);
  
  final String title;
  final List<Widget>? actions;
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          child: const Icon(CupertinoIcons.back, color: Colors.black,),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}