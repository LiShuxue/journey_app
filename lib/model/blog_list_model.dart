import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:dio/dio.dart';

import 'package:journey_app/utils/dio_config.dart';

class BlogListModel extends ChangeNotifier {
  // 全局状态博客列表
  List<dynamic> _blogList = [];
  bool isLoading = true;

  // 外部获取博客列表，返回一个不可修改的
  get blogList => UnmodifiableListView(_blogList);

  // 按类别聚合
  List<Map<String, dynamic>> get categoryList {
    Map<String, List<dynamic>> categoryMap = {};

    for (var blog in _blogList) {
      String category = blog['category'];
      if (categoryMap.containsKey(category)) {
        categoryMap[category]!.add(blog);
      } else {
        categoryMap[category] = [blog];
      }
    }

    Map<String, String> categoryUrlMap = {
      'Flutter': 'https://cdn.lishuxue.site/blog/image/Flutter/flutter.png',
    };

    List<Map<String, dynamic>> result = [];
    categoryMap.forEach((category, list) {
      result.add({
        'title': category,
        'list': UnmodifiableListView(list),
        'url':
            'https://cdn.lishuxue.site/blog/image/${category}/categoryImage.png',
      });
    });

    return result;
  }

  // 最新10篇文章newBlogList
  get newBlogList {
    // 首先创建博客列表的副本
    List<dynamic> copiedList = List.from(_blogList);
    // 然后按照发布时间对副本进行排序
    copiedList.sort((a, b) => b['publishTime'].compareTo(a['publishTime']));
    // 返回最新的10篇文章
    return copiedList.take(10).toList();
  }

  // 更新博客列表
  getBlogList() async {
    Response response = await dio.get('/blog-api/blog/list');
    List<dynamic> list = response.data['blogList'];

    _blogList = list;
    isLoading = false;
    // 通知widget更新
    notifyListeners();
  }

  addLike(article) async {
    try {
      await dio.post('/blog-api/blog/like', data: {
        'id': article['_id'],
        'isLiked': true,
      });

      // 本地文章加一或者减一,todo: 减一
      int index = _blogList.indexWhere((item) => item['_id'] == article['_id']);
      if (index != -1) {
        // 创建一个新的文章对象，复制原有的属性
        Map<String, dynamic> newArticle = Map.from(article);
        // 修改新文章对象的'like'属性值
        newArticle['like'] = article['like'] + 1;
        // 替换原来的文章对象
        _blogList[index] = newArticle;
        notifyListeners();
      }
    } on DioException catch (e) {}
  }
}
