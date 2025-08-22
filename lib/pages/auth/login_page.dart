import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/common_style.dart';
import 'package:flutter_demo/pages/auth/auth_vm.dart';
import 'package:flutter_demo/pages/auth/register_page.dart';
import 'package:flutter_demo/pages/tab_page.dart';
import 'package:flutter_demo/route/RouteUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  AuthViewModel viewModel = AuthViewModel();
  TextEditingController? usernameController;
  TextEditingController? pwdController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    pwdController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonInput(labelText: "用户名", controller: usernameController),
              SizedBox(height: 20.h),
              commonInput(labelText: "密码", controller: pwdController, isObscureText: true),
              SizedBox(height: 20.h),
              whiteBorderButton(
                title: "登录",
                onTap: () {
                  viewModel.setLoginInfo(
                    username: usernameController?.text,
                    password: pwdController?.text,
                  );
                  viewModel.login().then((value) {
                    if (value == true) {
                      showToast("登录成功");
                      RouteUtils.pushAndRemoveUntil(context, TabPage());
                    }
                  });
                },
              ),
              SizedBox(height: 5.h),
              registerButton("注册", () {
                RouteUtils.push(context, RegisterPage());
              }),
            ],
          ),
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
