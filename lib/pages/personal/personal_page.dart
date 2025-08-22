import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/auth/login_page.dart';
import 'package:flutter_demo/route/RouteUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State createState() {
    return _PersonalPageState();
  }
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(() {
              RouteUtils.push(context, LoginPage());
            }),
            _settingsItem("我的收藏", () {}),
            _settingsItem("检查更新", () {}),
            _settingsItem("关于我们", () {}),
          ],
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
          GestureDetector(
            onTap: onItemTap,
            child: Text(
              "未登录",
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
            ),
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
