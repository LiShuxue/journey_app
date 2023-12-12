import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class BasePage extends StatefulWidget {
  // 设置页面的title
  final String title;

  const BasePage({required this.title, super.key});

  @override
  createState();
}

abstract class BasePageState extends State<BasePage> {
  // 当前页面的索引，设置导航栏的active状态
  final int _currentIndex;

  BasePageState(this._currentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 顶部栏
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade200,
        titleTextStyle: const TextStyle(color: Colors.black),
        title: Text(widget.title),
      ),
      // 内容部分，在具体的页面中实现
      body: body(),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // active 状态
        type: BottomNavigationBarType.fixed, // 底部按钮超过3个需要设置这个
        backgroundColor: Colors.lightBlue.shade200,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.source),
            label: '分类',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: '发现',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: '关于',
          ),
        ],
        onTap: (int index) {
          // 处理底部导航栏点击事件
          if (index == 0) {
            context.go('/');
          }
          if (index == 1) {
            context.go('/category');
          }
          if (index == 2) {
            context.go('/discover');
          }
          if (index == 3) {
            context.go('/about');
          }
        },
      ),
    );
  }

  Widget body();
}
