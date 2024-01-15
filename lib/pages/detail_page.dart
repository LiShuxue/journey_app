import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:journey_app/utils/dio_config.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({required this.id, super.key});

  // 参数：获取id
  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // 博客详情
  dynamic _blogDetail;

  Future<dynamic> getDetailById(String id) async {
    Response response = await dio.get('/blog-api/blog/detail?id=$id');
    dynamic data = response.data['blog'];
    setState(() {
      _blogDetail = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetailById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    if (_blogDetail == null) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Detail'),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(_blogDetail['title']),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(_blogDetail['image']['url'])),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 10, right: 10, bottom: 15),
              child: MarkdownBody(data: _blogDetail['markdownContent']),
            ),
          ],
        ),
      );
    }
  }
}
