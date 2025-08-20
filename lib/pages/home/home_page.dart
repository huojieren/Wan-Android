import 'package:flutter/material.dart';
import 'package:flutter_demo/datas/home_banner_data.dart';
import 'package:flutter_demo/pages/home/home_vm.dart';
import 'package:flutter_demo/route/RouteUtils.dart';
import 'package:flutter_demo/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<BannerItemData>? bannerList;

  @override
  void initState() {
    super.initState();
    initBannerData();
  }

  void initBannerData() async {
    bannerList = await HomeViewModel.getBanner();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _banner(),
              ListView.builder(
                itemBuilder: (context, index) {
                  return _listItemView();
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return SizedBox(
      height: 150.h,
      width: double.infinity, // 无限撑满屏幕
      child: Swiper(
        // 不显示页面指示器（小圆点）
        indicatorLayout: PageIndicatorLayout.NONE,
        // 自动播放
        autoplay: true,
        // 指定指示器样式为默认样式
        pagination: const SwiperPagination(),
        // 指定控制按钮为默认样式
        control: const SwiperControl(),
        itemCount: bannerList?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            // margin: EdgeInsets.all(15.r),
            height: 150.h,
            width: double.infinity, // 无限撑满屏幕
            color: Colors.lightBlue,
            child: Image.network(
              bannerList?[index].imagePath ?? "",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _listItemView() {
    return GestureDetector(
      onTap: () {
        RouteUtils.pushForNamed(
          context,
          RoutePath.webViewPage,
          arguments: {"title": "value"},
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.r, bottom: 5.r, left: 10.r, right: 10.r),
        padding: EdgeInsets.only(
          top: 15.r,
          bottom: 10.r,
          left: 10.r,
          right: 10.r,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5.r),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(
                    "https://img1.pconline.com.cn/piclib/200902/09/batch/1/21870/1234188604019ydqb55uisk.jpg",
                    width: 30.r,
                    height: 30.r,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 5.w),
                Text("作者", style: TextStyle(color: Colors.black)),
                Expanded(child: SizedBox()),
                Text(
                  "2025年8月20日15:39:25",
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
                SizedBox(width: 5.w),
                Text(
                  "置顶",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              "标题",
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            Row(
              children: [
                Text(
                  "分类",
                  style: TextStyle(color: Colors.green, fontSize: 12.sp),
                ),
                Expanded(child: SizedBox()),
                Image.asset(
                  "assets/images/img_collect_grey.png",
                  width: 30.r,
                  height: 30.r,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
