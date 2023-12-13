import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          // min 尽可能少的占用主轴方向的空间。当子组件没有占满主轴剩余空间时，Row或Column的实际大小等于所有子组件占用的主轴空间。
          // max 尽可能多的占用主轴方向的空间。如果子组件没有占满主轴剩余空间，那么剩余的空间会均匀分布在子组件之间。
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Category List Page'),
            TextButton(
              onPressed: () {
                context.pushNamed('categorylistdetail',
                    pathParameters: {'id': '2'},
                    queryParameters: {'from': 'categorylist'});
              },
              child: const Text('View Category List Details'),
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