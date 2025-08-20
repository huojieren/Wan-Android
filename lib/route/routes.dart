import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/pages/web_view_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return pageRoute(HomePage(), settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(WebViewPage(title: "跳转信息"), settings: settings);
    }
    return pageRoute(
      Scaffold(
        body: SafeArea(
          child: Center(child: Text("can't find route path ${settings.name}")),
        ),
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
  static const String home = "/";
  static const String webViewPage = "/web_view_page";
}
