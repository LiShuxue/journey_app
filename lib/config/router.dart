import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:journey_app/pages/home_page.dart';
import 'package:journey_app/pages/detail_page.dart';
import 'package:journey_app/pages/category_page.dart';
import 'package:journey_app/pages/category_list_page.dart';
import 'package:journey_app/pages/discover_page.dart';
import 'package:journey_app/pages/about_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey, // 根级别的导航
  initialLocation: '/home',
  debugLogDiagnostics: true,
  routes: [
    // 整个应用的导航shell
    ShellRoute(
      navigatorKey: _shellNavigatorKey, // shell级别的导航
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
          routes: [
            GoRoute(
              name: 'homedetail',
              path: 'detail/:id',
              // 可以在导航时在根级别导航，覆盖shell级别
              parentNavigatorKey: _rootNavigatorKey,
              builder: (BuildContext context, GoRouterState state) {
                return DetailPage(
                  id: state.pathParameters['id'] ?? '',
                  from: state.uri.queryParameters['from'] ?? '',
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/category',
          builder: (BuildContext context, GoRouterState state) {
            return const CategoryPage();
          },
          routes: [
            GoRoute(
              path: 'list',
              builder: (BuildContext context, GoRouterState state) {
                return const CategoryListPage();
              },
            ),
            GoRoute(
              name: 'categorylistdetail',
              path: 'detail/:id',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (BuildContext context, GoRouterState state) {
                return DetailPage(
                  id: state.pathParameters['id'] ?? '',
                  from: state.uri.queryParameters['from'] ?? '',
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/discover',
          builder: (BuildContext context, GoRouterState state) {
            return const DiscoverPage();
          },
        ),
        GoRoute(
          path: '/about',
          builder: (BuildContext context, GoRouterState state) {
            return const AboutPage();
          },
        ),
      ],
    ),
  ],
);

// shell 级别的导航的骨架
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.child, super.key});

  // body的内容
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 底部按钮超过3个需要设置这个
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.source),
            label: '分类',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: '发现',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: '关于',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int index) => _onItemTapped(index, context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/category')) {
      return 1;
    }
    if (location.startsWith('/discover')) {
      return 2;
    }
    if (location.startsWith('/about')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/category');
        break;
      case 2:
        GoRouter.of(context).go('/discover');
        break;
      case 3:
        GoRouter.of(context).go('/about');
        break;
    }
  }
}
