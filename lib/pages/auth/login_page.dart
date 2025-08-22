import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/common_style.dart';
import 'package:flutter_demo/pages/auth/register_page.dart';
import 'package:flutter_demo/route/RouteUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String? input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            commonInput(labelText: "用户名"),
            SizedBox(height: 20.h),
            commonInput(labelText: "密码"),
            SizedBox(height: 20.h),
            whiteBorderButton(title: "登录", onTap: () {}),
            SizedBox(height: 5.h),
            registerButton("注册", () {
              RouteUtils.push(context, RegisterPage());
            }),
          ],
        ),
      ),
    );
  }

  Widget registerButton(String title, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: () {
        RouteUtils.push(context, RegisterPage());
      },
      child: Container(
        alignment: Alignment.center,
        width: 100.w,
        height: 45.h,
        child: Text(
          title,
          style: TextStyle(fontSize: 15.sp, color: Colors.white),
        ),
      ),
    );
  }
}
