import 'package:flutter/material.dart';
import 'package:journey_app/pages/category_list_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // 页面的状态
  int _counter = 0;

  // 自定义的修改状态的方法
  void _addCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('category page');
    return Scaffold(
      body: Center(
        child: Column(
          // min 尽可能少的占用主轴方向的空间。当子组件没有占满主轴剩余空间时，Row或Column的实际大小等于所有子组件占用的主轴空间。
          // max 尽可能多的占用主轴方向的空间。如果子组件没有占满主轴剩余空间，那么剩余的空间会均匀分布在子组件之间。
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Category Page'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoryListPage()),
                );
              },
              child: const Text('Go to Category List'),
            ),
            Text('$_counter'),
            ElevatedButton(
              onPressed: () => _addCounter(),
              child: const Text('更新状态'),
            ),
          ],
        ),
      ),
    );
  }
}
