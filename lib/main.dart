import 'package:flutter/material.dart';

import 'package:journey_app/pages/home_page.dart';
import 'package:journey_app/pages/category_page.dart';
import 'package:journey_app/pages/discover_page.dart';
import 'package:journey_app/pages/about_page.dart';

import 'package:journey_app/utils/dio_config.dart';

void main() {
  dioConfig();
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
        // 根据蓝色用算法生成一个ColorScheme对象，其中包含了一组颜色。这些颜色可以自动用于应用程序中的一些组件，例如按钮，checkbox等，以保持一致的主题风格。
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // 顶部栏颜色
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade100,
        ),
        // 底部栏颜色
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue.shade100,
        ),
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

  // 当页面切换时，可能是点击导航栏切换的，也可能是左右滑动切换的
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
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
        onPageChanged: (int index) => _onPageChanged(index),
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
