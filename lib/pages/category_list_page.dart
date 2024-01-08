import 'package:flutter/material.dart';
import 'package:journey_app/pages/detail_page.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({required this.title, super.key});

  // 路径参数：获取title。在_State类中，你可以使用widget.title来获取传入的参数值。
  final String title;

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // min 尽可能少的占用主轴方向的空间。当子组件没有占满主轴剩余空间时，Row或Column的实际大小等于所有子组件占用的主轴空间。
          // max 尽可能多的占用主轴方向的空间。如果子组件没有占满主轴剩余空间，那么剩余的空间会均匀分布在子组件之间。
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Category List Page'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const DetailPage(id: '2', from: 'category-list')),
                );
              },
              child: const Text('Go to Category List Detail'),
            ),
          ],
        ),
      ),
    );
  }
}
