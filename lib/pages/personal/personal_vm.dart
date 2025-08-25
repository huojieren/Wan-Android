import 'package:flutter/foundation.dart';
import 'package:wan_android/constants.dart';
import 'package:wan_android/repository/api.dart';
import 'package:wan_android/utils/sp_utils.dart';

class PersonalViewModel with ChangeNotifier {
  String? userName;
  bool shouldLogin = false;

  Future initData() async {
    SpUtils.getString(Constants.SP_Username).then((value) {
      if (value == null || value == "") {
        userName = "未登录";
        shouldLogin = true;
      } else {
        userName = value;
        shouldLogin = false;
      }
      notifyListeners();
    });
  }

  Future logout(ValueChanged<bool> callback) async {
    bool? result = await Api.instance.logout();
    if (result == true) {
      await SpUtils.removeAll();
      callback.call(true);
    } else {
      callback.call(false);
    }
  }
}
