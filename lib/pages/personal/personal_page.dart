import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/pages/auth/login_page.dart';
import 'package:wan_android/pages/personal/personal_vm.dart';
import 'package:wan_android/route/RouteUtils.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State createState() {
    return _PersonalPageState();
  }
}

class _PersonalPageState extends State<PersonalPage> {
  PersonalViewModel viewModel = PersonalViewModel();

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
          child: Column(
            children: [
              _header(() {
                if (viewModel.shouldLogin) {
                  RouteUtils.push(context, LoginPage());
                }
              }),
              _settingsItem("我的收藏", () {}),
              _settingsItem("检查更新", () {}),
              _settingsItem("关于我们", () {}),
              Consumer<PersonalViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.shouldLogin) {
                    return SizedBox();
                  }
                  return _settingsItem("退出登录", () {
                    viewModel.logout((value) {
                      if (value) {
                        RouteUtils.pushAndRemoveUntil(context, LoginPage());
                      }
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(GestureTapCallback? onItemTap) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal,
      width: double.infinity,
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35.r),
            child: GestureDetector(
              onTap: onItemTap,
              child: Image.asset(
                "assets/images/logo.png",
                width: 70.r,
                height: 70.r,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Consumer<PersonalViewModel>(
            builder: (context, viewModel, child) {
              return GestureDetector(
                onTap: onItemTap,
                child: Text(
                  viewModel.userName ?? "",
                  style: TextStyle(fontSize: 13.sp, color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _settingsItem(String? title, GestureTapCallback? onItemTap) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5.r),
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? "",
              style: TextStyle(fontSize: 13.sp, color: Colors.black),
            ),
            Image.asset("assets/images/img_arrow_right.png", width: 20.r, height: 20.r),
          ],
        ),
      ),
    );
  }
}
