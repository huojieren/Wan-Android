import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/navigation/navigation_bar_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationBarWidget extends StatefulWidget {
  NavigationBarWidget({
    super.key,
    required this.pages,
    required this.labels,
    required this.unselectIcons,
    required this.activeIcons,
    required this.onTapChanged,
    required this.currentIndex,
  }) {
    if (pages.length != labels.length ||
        pages.length != unselectIcons.length ||
        pages.length != activeIcons.length) {
      throw Exception("页面元素数量不一致");
    }
  }

  final List<Widget> pages;
  final List<String> labels;
  final List<Widget> unselectIcons;
  final List<Widget> activeIcons;
  final ValueChanged<int>? onTapChanged;
  int? currentIndex;

  @override
  State createState() {
    return _NavigationBarWidgetState();
  }
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  List<BottomNavigationBarItem> _barItemList() {
    return widget.pages.asMap().entries.map((entry) {
      return BottomNavigationBarItem(
        icon: widget.unselectIcons[entry.key],
        activeIcon: NavigationBarItem(
          builder: (context) {
            return widget.activeIcons[entry.key];
          },
        ),
        label: widget.labels[entry.key],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: widget.currentIndex ?? 0, children: widget.pages),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(
          context,
        ).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          items: _barItemList(),
          currentIndex: widget.currentIndex ?? 0,
          onTap: (index) {
            widget.currentIndex = index;
            widget.onTapChanged?.call(index);
            setState(() {});
          },
          // BottomNavigationBarType.fixed 的作用：底部导航栏的文字和图标会固定住，不会跟随滑动
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 14.sp),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp),
          // 为每个标签项设置背景色
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blueGrey,
        ),
      ),
    );
  }
}
