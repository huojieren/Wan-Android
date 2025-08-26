import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/pages/hot_key/hot_key_vm.dart';
import 'package:wan_android/pages/web_view_page.dart';
import 'package:wan_android/repository/data/common_website_data.dart';
import 'package:wan_android/repository/data/search_hot_key_data.dart';
import 'package:wan_android/utils/route_utils.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State createState() {
    return _HotKeyPageState();
  }
}

class _HotKeyPageState extends State<HotKeyPage> {
  HotKeyViewModel viewModel = HotKeyViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  Container(
                    height: 45.h,
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.5.r, color: Colors.grey),
                        bottom: BorderSide(width: 0.5.r, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "搜索热词",
                          style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        ),
                        Expanded(child: SizedBox()),
                        Image.asset("assets/images/icon_search.png", width: 30.r, height: 30.r),
                      ],
                    ),
                  ),
                  Consumer<HotKeyViewModel>(
                    builder: (context, viewModel, child) {
                      return _gridView(
                        false,
                        hotKeyList: viewModel.hotKeyList,
                        onItemTap: (link) {},
                      );
                    },
                  ),
                  Container(
                    height: 45.h,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.5.r, color: Colors.grey),
                        bottom: BorderSide(width: 0.5.r, color: Colors.grey),
                      ),
                    ),
                    child: Text(
                      "常用网站",
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ),
                  Consumer<HotKeyViewModel>(
                    builder: (context, viewModel, child) {
                      return _gridView(
                        true,
                        websiteList: viewModel.websiteList,
                        onItemTap: (link) {
                          RouteUtils.push(context, WebViewPage(title: "常用网站", link: link));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gridView(
    bool? isWebsite, {
    List<CommonWebsiteData>? websiteList,
    List<SearchHotKeyData>? hotKeyList,
    ValueChanged<String>? onItemTap,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.builder(
        // 禁止滑动
        physics: NeverScrollableScrollPhysics(),
        // 列表内容自适应
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // 主轴间隔
          mainAxisSpacing: 10.r,
          // 副轴间隔
          crossAxisSpacing: 10.r,
          // 副轴最大范围
          maxCrossAxisExtent: 120.w,
          // 宽高比
          childAspectRatio: 3,
        ),
        itemBuilder: (context, index) {
          if (isWebsite == true) {
            return _item(
              title: websiteList?[index].name,
              onItemTap: onItemTap,
              link: websiteList?[index].link,
            );
          } else {
            return _item(title: hotKeyList?[index].name, onItemTap: onItemTap);
          }
        },
        itemCount: isWebsite == true ? websiteList?.length ?? 0 : hotKeyList?.length ?? 0,
      ),
    );
  }

  Widget _item({String? title, ValueChanged<String>? onItemTap, String? link}) {
    return GestureDetector(
      onTap: () {
        if (link != null) {
          onItemTap?.call(link);
        } else {
          onItemTap?.call(title ?? "");
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5.r),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Text(title ?? ""),
      ),
    );
  }
}
