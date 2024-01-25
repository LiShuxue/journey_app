import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';

import 'package:journey_app/pages/category_list_page.dart';
import 'package:journey_app/pages/detail_page.dart';

import 'package:journey_app/model/blog_list_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    Provider.of<BlogListModel>(context, listen: false).getBlogList();
  }

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
    super.build(context);
    final blogListModel = Provider.of<BlogListModel>(context, listen: true);
    return Scaffold(
      // 自定义滚动
      body: blogListModel.isLoading
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
                          itemCount: blogListModel.newBlogList.length,
                          itemHeight: 150,
                          itemBuilder: (context, index) {
                            final article = blogListModel.newBlogList[index];
                            return GestureDetector(
                              onTap: () {
                                gotoDetailPage(article);
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
                    ],
                  ),
                ),
                // SliverList是一个Sliver，它可以在CustomScrollView中创建一个线性的滚动列表，每个子项都是一个Box Widget（比如Container，Text，Image等）。SliverList可以实现一些ListView不能实现的滚动效果，比如与其他Sliver组件（比如SliverAppBar，SliverGrid等）混合使用。
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < blogListModel.blogList.length) {
                        final article = blogListModel.blogList[index];
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
                                    // BoxFit.fill：图片会被拉伸以填充整个容器，可能会导致图片的宽高比发生变化，从而使图片看起来变形。
                                    // BoxFit.cover：图片会按照其原始宽高比进行缩放，以便完全覆盖整个容器，可能会导致图片的一部分被裁剪掉，但不会发生变形。
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
                                            const Icon(Icons.visibility,
                                                size: 14),
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
                                            const Icon(Icons.thumb_up,
                                                size: 14),
                                            const SizedBox(width: 4),
                                            Text('${article['like']}'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 25),

                                      // 文章分类
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryListPage(
                                                        title: article[
                                                            'category'])),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.category,
                                                size: 14),
                                            const SizedBox(width: 4),
                                            Text(article['category']),
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
                      } else {
                        return const Column(
                          children: [
                            SizedBox(height: 8),
                            Text('到底了~'),
                            SizedBox(height: 10),
                          ],
                        );
                      }
                    },
                    childCount:
                        blogListModel.blogList.length + 1, // 加1 是因为最后一项是“到底了~”
                  ),
                ),
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
