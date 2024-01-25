import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:journey_app/pages/category_list_page.dart';
import 'package:journey_app/model/blog_list_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final blogListModel = Provider.of<BlogListModel>(context, listen: true);

    return Scaffold(
      body: ListView.builder(
        itemCount: blogListModel.categoryList.length + 1, // 加1 是因为第一项是特殊的
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                Container(
                  height: 60,
                  alignment: Alignment.center, // 设置子元素上下左右居中
                  padding: const EdgeInsets.only(left: 16),
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 0.5, color: Colors.grey[600]!), // 设置底部边框的宽度和颜色
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft, // 文本左对齐
                    child: Text(
                      '知识要靠一点一滴的积累',
                      style: TextStyle(
                          fontSize: 20, // 设置字体大小为20
                          fontWeight: FontWeight.bold, // 设置字体为粗体
                          color: Colors.grey[600]),
                    ),
                  ),
                ),
              ],
            );
          } else {
            final category = blogListModel.categoryList[index - 1];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryListPage(title: category['title']),
                    ));
              },
              child: Column(
                children: [
                  ListTile(
                    leading: SizedBox(
                      width: 100,
                      height: 50,
                      child: Image.network(
                        category['url'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${category['title']}'),
                      ],
                    ),
                    subtitle: Text('共${category['list'].length}篇文章'),
                  ),
                  const Divider(
                    height: 4,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
