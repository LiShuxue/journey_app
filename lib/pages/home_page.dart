import 'package:flutter/material.dart';

import '../common/base_page.dart';

class HomePage extends BasePage {
  const HomePage({required super.title, super.key});

  @override
  createState() => _HomePageState();
}

class _HomePageState extends BasePageState {
  _HomePageState() : super(0);

  @override
  Widget body() {
    return const Center(child: Text('主页'));
  }
}
