import 'package:flutter/cupertino.dart';
import 'package:wan_android/constants.dart';
import 'package:wan_android/repository/api.dart';
import 'package:wan_android/repository/data/auth_data.dart';
import 'package:wan_android/utils/sp_utils.dart';

class AuthViewModel with ChangeNotifier {
  RegisterInfo? registerInfo = RegisterInfo();
  LoginInfo? loginInfo = LoginInfo();

  void setLoginInfo({String? username, String? password}) {
    if (username != null) {
      loginInfo?.username = username;
    }
    if (password != null) {
      loginInfo?.password = password;
    }
  }

  Future<bool?> register() async {
    return Api.instance.register(
      username: registerInfo?.username,
      password: registerInfo?.password,
      repassword: registerInfo?.confirmPassword,
    );
  }

  Future<bool?> login() async {
    AuthData authData = await Api.instance.login(
      username: loginInfo?.username,
      password: loginInfo?.password,
    );
    if (authData.username != null && authData.username?.isNotEmpty == true) {
      SpUtils.saveString(Constants.SP_Username, authData.username ?? "");
      return true;
    }
    return false;
  }
}

class RegisterInfo {
  String? username;
  String? password;
  String? confirmPassword;
}

class LoginInfo {
  String? username;
  String? password;
}
