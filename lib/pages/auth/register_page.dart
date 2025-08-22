import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/common_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  @override
  State createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
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
            commonInput(labelText: "再次输入密码"),
            SizedBox(height: 20.h),
            whiteBorderButton(title: "注册", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
