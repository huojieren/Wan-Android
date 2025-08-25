import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_android/common_ui/navigation/navigation_bar_widget.dart';
import 'package:wan_android/pages/home/home_page.dart';
import 'package:wan_android/pages/hot_key/hot_key_page.dart';
import 'package:wan_android/pages/knowledge/knowledge_page.dart';
import 'package:wan_android/pages/personal/personal_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State createState() {
    return _TabPageState();
  }
}

class _TabPageState extends State<TabPage> {
  late List<Widget> pages;
  late List<String> labels;
  late List<Widget> unselectIcons;
  late List<Widget> activeIcons;

  void initData() {
    pages = [HomePage(), HotKeyPage(), KnowledgePage(), PersonalPage()];
    labels = ["首页", "热点", "体系", "我的"];
    unselectIcons = [
      Image.asset("assets/images/icon_home_grey.png", width: 32.r, height: 32.r),
      Image.asset("assets/images/icon_hot_key_grey.png", width: 32.r, height: 32.r),
      Image.asset("assets/images/icon_knowledge_grey.png", width: 32.r, height: 32.r),
      Image.asset("assets/images/icon_personal_grey.png", width: 32.r, height: 32.r),
    ];
    activeIcons = [
      Image.asset("assets/images/icon_home_selected.png", width: 32.r, height: 32.r),
      Image.asset("assets/images/icon_hot_key_selected.png", width: 32.r, height: 32.r),
      Image.asset("assets/images/icon_knowledge_selected.png", width: 32.r, height: 32.r),
      Image.asset("assets/images/icon_personal_selected.png", width: 32.r, height: 32.r),
    ];
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return NavigationBarWidget(
      pages: pages,
      labels: labels,
      unselectIcons: unselectIcons,
      activeIcons: activeIcons,
      currentIndex: 0,
      onTapChanged: (index) {},
    );
  }
}
