import 'package:flutter/material.dart';
import 'package:journey_app/models/artitle_model.dart';
import 'package:journey_app/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  final List<Article> _articles =
      List.generate(10, (index) => Article(id: index, title: 'Article $index'));

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreArticles();
      }
    });
  }

  void _loadMoreArticles() {
    setState(() {
      _articles.addAll(List.generate(
          10,
          (index) => Article(
              id: _articles.length + index,
              title: 'Article ${_articles.length + index}')));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // 滚动
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _articles.length + 1, // 加1是因为第一项是swiper
        itemBuilder: (context, index) {
          if (index == 0) {
            // 第一项是swiper
            return const Column(
              children: [
                SizedBox(
                  height: 200, // 设置Swiper的高度
                  child: Text('滑块'),
                ),
                SizedBox(height: 10), // 添加10像素的垂直空间
              ],
            );
          } else if (index == _articles.length) {
            final article = _articles[index - 1];
            // 最后一项包含加载中
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(id: '${article.id}', from: 'home')),
                );
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.image), // 替换为文章图片
                    title: Text('Article Title ${index - 1}'),
                    subtitle: Text('Article Subtitle ${index - 1}'),
                  ),
                  const Divider(),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  const Text('加载中...'),
                ],
              ),
            );
          } else {
            // 其他项正常展示
            final article = _articles[index - 1]; // 获取文章
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(id: '${article.id}', from: 'home')),
                );
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.image), // 替换为文章图片
                    title: Text('Article Title ${index - 1}'),
                    subtitle: Text('Article Subtitle ${index - 1}'),
                  ),
                  const Divider(),
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
