import 'package:flutter/material.dart';

import 'package:journey_app/config/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Journey App',
      theme: ThemeData(
        useMaterial3: true, // 启用Material 3
      ),
      routerConfig: router, // 路由配置
    );
  }
}
