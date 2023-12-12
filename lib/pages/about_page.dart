import 'package:flutter/material.dart';

import '../common/base_page.dart';

class AboutPage extends BasePage {
  const AboutPage({required super.title, super.key});

  @override
  createState() => _AboutPageState();
}

class _AboutPageState extends BasePageState {
  _AboutPageState() : super(3);

  @override
  Widget body() {
    return const Center(child: Text('关于'));
  }
}
