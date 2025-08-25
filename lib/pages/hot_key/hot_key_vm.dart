import 'package:flutter/widgets.dart';
import 'package:wan_android/repository/api.dart';
import 'package:wan_android/repository/data/common_website_data.dart';
import 'package:wan_android/repository/data/search_hot_key_data.dart';

class HotKeyViewModel with ChangeNotifier {
  List<CommonWebsiteData>? websiteList;
  List<SearchHotKeyData>? hotKeyList;

  Future getWebsiteList() async {
    websiteList = await Api.instance.getWebsiteList();
    notifyListeners();
  }

  Future getSearchHotkeyList() async {
    hotKeyList = await Api.instance.getSearchHotkeyList();
    notifyListeners();
  }

  Future initData() async {
    getWebsiteList().then((value) {
      getSearchHotkeyList().then((value) {
        notifyListeners();
      });
    });
  }
}
