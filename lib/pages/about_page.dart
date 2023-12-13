import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('about page');
    return const Scaffold(
      body: Center(
        child: Column(
          // min 尽可能少的占用主轴方向的空间。当子组件没有占满主轴剩余空间时，Row或Column的实际大小等于所有子组件占用的主轴空间。
          // max 尽可能多的占用主轴方向的空间。如果子组件没有占满主轴剩余空间，那么剩余的空间会均匀分布在子组件之间。
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('About Page'),
          ],
        ),
      ),
    );
  }
}
