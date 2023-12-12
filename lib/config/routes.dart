import 'package:go_router/go_router.dart';

import 'package:journey_app/pages/home_page.dart';
import 'package:journey_app/pages/category_page.dart';
import 'package:journey_app/pages/discover_page.dart';
import 'package:journey_app/pages/about_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(title: '主页'),
    ),
    GoRoute(
      path: '/category',
      builder: (context, state) => const CategoryPage(title: '分类'),
    ),
    GoRoute(
      path: '/discover',
      builder: (context, state) => const DiscoverPage(title: '发现'),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(title: '关于'),
    ),
  ],
);
