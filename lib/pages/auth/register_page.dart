import 'package:flutter/material.dart';
import 'package:flutter_demo/common_ui/common_style.dart';
import 'package:flutter_demo/pages/auth/auth_vm.dart';
import 'package:flutter_demo/route/RouteUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  State createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  AuthViewModel viewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();
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
          child: Consumer<AuthViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonInput(
                    labelText: "用户名",
                    onChanged: ((value) {
                      viewModel.registerInfo?.username = value;
                    }),
                  ),
                  SizedBox(height: 20.h),
                  commonInput(
                    labelText: "密码",
                    isObscureText: true,
                    onChanged: (value) {
                      viewModel.registerInfo?.password = value;
                    },
                  ),
                  SizedBox(height: 20.h),
                  commonInput(
                    labelText: "再次输入密码",
                    isObscureText: true,
                    onChanged: (value) {
                      viewModel.registerInfo?.confirmPassword = value;
                    },
                  ),
                  SizedBox(height: 20.h),
                  whiteBorderButton(
                    title: "注册",
                    onTap: () {
                      viewModel.register().then((onValue) {
                        if (onValue == true) {
                          showToast("注册成功");
                          RouteUtils.pop(context);
                        }
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
