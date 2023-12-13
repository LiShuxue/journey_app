import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({required this.id, required this.from, super.key});

  // 路径参数：获取id
  final String id;

  // query参数：显示是哪里进来的detail
  final String from;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Details for $from, id: $id'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
