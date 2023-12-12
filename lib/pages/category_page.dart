import 'package:flutter/material.dart';

import '../common/base_page.dart';

class CategoryPage extends BasePage {
  const CategoryPage({required super.title, super.key});

  @override
  createState() => _CategoryPageState();
}

class _CategoryPageState extends BasePageState {
  _CategoryPageState() : super(1);

  @override
  Widget body() {
    return const Center(child: Text('分类'));
  }
}
