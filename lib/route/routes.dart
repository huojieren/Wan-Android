import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/auth/login_page.dart';
import 'package:flutter_demo/pages/auth/register_page.dart';
import 'package:flutter_demo/pages/tab_page.dart';
import 'package:flutter_demo/pages/web_view_page.dart';

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
}
