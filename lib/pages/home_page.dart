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
  final _scrollController = ScrollController();
  List _articles = [];
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

      setState(() {
        _articles = list;
        _isLoading = false;
      });
    } on DioException catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // 滚动
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: _articles.length + 1, // 加1是因为第一项是swiper
              itemBuilder: (context, index) {
                if (index == 0) {
                  // 第一项是swiper
                  return Column(
                    children: [
                      SizedBox(
                        height: 150, // 设置Swiper的高度
                        child: Swiper(
                          autoplay: true,
                          pagination: const SwiperPagination(),
                          itemCount: 3,
                          itemHeight: 150,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.grey,
                              child: Center(
                                child: Text("$index"),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10), // 添加10像素的垂直空间
                    ],
                  );
                } else if (index < _articles.length) {
                  final article = _articles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(id: article['_id'], from: 'home'),
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
                              article['image']['url'], // 替换为您的图片URL
                              fit: BoxFit.cover, // 根据需要设置图片适应方式
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
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
