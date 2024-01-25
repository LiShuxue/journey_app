import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:journey_app/model/blog_list_model.dart';
import 'package:journey_app/pages/detail_page.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({required this.title, super.key});

  // 参数：获取title。在_State类中，你可以使用widget.title来获取传入的参数值。
  final String title;

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  // 进详情页
  void gotoDetailPage(article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(id: article['_id']),
      ),
    );
  }

  // 文章点赞
  likeArticle(article) {
    Provider.of<BlogListModel>(context, listen: false).addLike(article);
  }

  @override
  Widget build(BuildContext context) {
    final blogListModel = Provider.of<BlogListModel>(context, listen: true);
    final target = blogListModel.categoryList
        .firstWhere((item) => item['title'] == widget.title,
            orElse: () => {
                  'title': '',
                  'list': [],
                  'url': '',
                });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: target['list'].length,
          itemBuilder: (context, index) {
            final article = target['list'][index];
            return Column(
              children: [
                ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      gotoDetailPage(article);
                    },
                    child: SizedBox(
                      width: 100, // 设置图片宽度
                      height: 70, // 设置图片高度
                      child: Image.network(
                        article['image']['url'], // 图片URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: GestureDetector(
                    onTap: () {
                      gotoDetailPage(article);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article['title']),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          gotoDetailPage(article);
                        },
                        child: Text(article['subTitle']),
                      ),
                      const SizedBox(height: 5), // 添加垂直间距

                      Row(
                        children: [
                          // 查看次数
                          GestureDetector(
                            onTap: () {
                              gotoDetailPage(article);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.visibility, size: 14),
                                const SizedBox(width: 4),
                                Text('${article['see']}'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 25),

                          // 点赞次数
                          GestureDetector(
                            onTap: () {
                              likeArticle(article);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.thumb_up, size: 14),
                                const SizedBox(width: 4),
                                Text('${article['like']}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 4,
                ),
              ],
            );
          }),
    );
  }
}
