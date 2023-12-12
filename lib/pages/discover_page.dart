import 'package:flutter/material.dart';

import '../common/base_page.dart';

class DiscoverPage extends BasePage {
  const DiscoverPage({required super.title, super.key});

  @override
  createState() => _DiscoverPageState();
}

class _DiscoverPageState extends BasePageState {
  _DiscoverPageState() : super(2);

  @override
  Widget body() {
    return const Center(child: Text('发现'));
  }
}
