import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:wan_android/pages/home/home_vm.dart';
import 'package:wan_android/repository/data/home_list_data.dart';
import 'package:wan_android/route/RouteUtils.dart';
import 'package:wan_android/route/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  RefreshController refreshController = RefreshController();

  void refreshOrLoad(bool loadMore) {
    viewModel.initListData(
      loadMore,
      callback: (loadMore) {
        if (loadMore) {
          refreshController.loadComplete();
        } else {
          refreshController.refreshCompleted();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.getBanner();
    viewModel.initListData(false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: SmartRefreshWidget(
            controller: refreshController,
            onLoading: () {
              refreshOrLoad(true);
            },
            onRefresh: () {
              viewModel.getBanner().then((value) {
                refreshOrLoad(false);
              });
            },
            child: SingleChildScrollView(
              child: Column(children: [_banner(), _homeListView()]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
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
            itemCount: viewModel.bannerList?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                // margin: EdgeInsets.all(15.r),
                height: 150.h,
                width: double.infinity, // 无限撑满屏幕
                color: Colors.lightBlue,
                child: Image.network(
                  viewModel.bannerList?[index]?.imagePath ?? "",
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _homeListView() {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return _listItemView(viewModel.listData?[index]);
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: viewModel.listData?.length ?? 0,
        );
      },
    );
  }

  Widget _listItemView(HomeListItemData? item) {
    String author;
    if (item?.author?.isNotEmpty == true) {
      author = item!.author ?? "";
    } else {
      author = item!.shareUser ?? "";
    }

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Text(author, style: TextStyle(color: Colors.black)),
                Expanded(child: SizedBox()),
                Text(
                  item.niceShareDate ?? "",
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
                SizedBox(width: 5.w),
                (item.type?.toInt() == 1)
                    ? Text(
                        "置顶",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              item.title ?? "",
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Text(
                  item.chapterName ?? "",
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
