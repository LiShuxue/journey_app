import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:journey_app/pages/detail_page.dart';
import 'package:journey_app/utils/dio_config.dart';
import 'package:card_swiper/card_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 所有文章
  List _articles = [];
  // 最新的前10条
  List _latestArticles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  void _loadArticles() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Response response = await dio.get('/blog-api/blog/list');
      List<dynamic> list = response.data['blogList'];
      List<dynamic> latestArticles = list.sublist(0, 10);

      setState(() {
        _articles = list;
        _latestArticles = latestArticles;
        _isLoading = false;
      });
    } on DioException catch (e) {
      setState(() {
        _articles = [];
        _latestArticles = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // 自定义滚动
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              // 以sliver的形式组合多个滚动视图，slivers是一个Widget列表，每个Widget都必须是一个Sliver，比如SliverAppBar，SliverGrid，SliverList等。
              slivers: [
                // SliverToBoxAdapter是一个Sliver，它可以将一个普通的Box Widget（比如Container，Text，Image等）放在CustomScrollView中，实现自定义的滚动效果。
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150, // 设置Swiper的高度
                        child: Swiper(
                          autoplay: true,
                          pagination: const SwiperPagination(),
                          itemCount: _latestArticles.length,
                          itemHeight: 150,
                          itemBuilder: (context, index) {
                            final article = _latestArticles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        id: article['_id'], from: 'home'),
                                  ),
                                );
                              },
                              child: Image.network(
                                article['image']['url'], // 图片URL
                                // BoxFit.fill：图片会被拉伸以填充整个容器，可能会导致图片的宽高比发生变化，从而使图片看起来变形。
                                // BoxFit.cover：图片会按照其原始宽高比进行缩放，以便完全覆盖整个容器，可能会导致图片的一部分被裁剪掉，但不会发生变形。
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10), // 添加10像素的垂直空间
                    ],
                  ),
                ),
                // SliverList是一个Sliver，它可以在CustomScrollView中创建一个线性的滚动列表，每个子项都是一个Box Widget（比如Container，Text，Image等）。SliverList可以实现一些ListView不能实现的滚动效果，比如与其他Sliver组件（比如SliverAppBar，SliverGrid等）混合使用。
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < _articles.length) {
                        final article = _articles[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    id: article['_id'], from: 'home'),
                              ),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: SizedBox(
                                  width: 100, // 设置图片宽度
                                  height: 50, // 设置图片高度
                                  child: Image.network(
                                    article['image']['url'], // 图片URL
                                    // BoxFit.fill：图片会被拉伸以填充整个容器，可能会导致图片的宽高比发生变化，从而使图片看起来变形。
                                    // BoxFit.cover：图片会按照其原始宽高比进行缩放，以便完全覆盖整个容器，可能会导致图片的一部分被裁剪掉，但不会发生变形。
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: Text(article['title']),
                                subtitle: Text(article['subTitle']),
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      } else {
                        return const Column(
                          children: <Widget>[
                            Text('到底了~'),
                            SizedBox(height: 10),
                          ],
                        );
                      }
                    },
                    childCount: _articles.length + 1, // 加1 是因为最后一项是“到底了~”
                  ),
                ),
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
