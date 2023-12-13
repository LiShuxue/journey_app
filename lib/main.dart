import 'package:flutter/material.dart';

import 'package:journey_app/pages/home_page.dart';
import 'package:journey_app/pages/category_page.dart';
import 'package:journey_app/pages/discover_page.dart';
import 'package:journey_app/pages/about_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journey',
      theme: ThemeData(
        useMaterial3: true, // 启用Material 3
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 内部状态，指定底部导航栏的active
  int _currentIndex = 0;

  // PageView的controller，可以控制PageView的滚动、跳转到指定页面以及监听页面切换事件等
  final _pageController = PageController();

  // PageView的几个子页面，可以左右滑动切换
  final _pages = [
    const HomePage(),
    const CategoryPage(),
    const DiscoverPage(),
    const AboutPage(),
  ];

  // 当底部导航栏点击时
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      // 切换页面。下列代码需要放在setState中
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journey'),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 底部按钮超过3个需要设置这个
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
        currentIndex: _currentIndex,
        onTap: (int index) => _onItemTapped(index),
      ),
    );
  }
}
