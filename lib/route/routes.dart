import 'package:flutter/material.dart';
import 'package:wan_android/pages/auth/login_page.dart';
import 'package:wan_android/pages/auth/register_page.dart';
import 'package:wan_android/pages/knowledge/detail/knowledg_detail_tab_page.dart';
import 'package:wan_android/pages/search/search_page.dart';
import 'package:wan_android/pages/tab_page.dart';
import 'package:wan_android/pages/web_view_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.tab:
        return pageRoute(TabPage(), settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(WebViewPage(title: "跳转信息"), settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(), settings: settings);
      case RoutePath.registerPage:
        return pageRoute(RegisterPage(), settings: settings);
      case RoutePath.detailKnowledgePage:
        return pageRoute(KnowledgeDetailsTabPage(), settings: settings);
      case RoutePath.searchPage:
        return pageRoute(SearchPage(), settings: settings);
    }
    return pageRoute(
      Scaffold(
        body: SafeArea(child: Center(child: Text("can't find route path ${settings.name}"))),
      ),
    );
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? maintainState,
    bool? allowSnapshotting,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
      fullscreenDialog: fullscreenDialog ?? false,
      maintainState: maintainState ?? true,
      allowSnapshotting: maintainState ?? true,
    );
  }
}

class RoutePath {
  static const String tab = "/";
  static const String webViewPage = "/web_view_page";
  static const String loginPage = "/login_page";
  static const String registerPage = "/register_page";
  static const String detailKnowledgePage = "/detail_knowledge_page";
  static const String searchPage = "/search_page";
}
