import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wan_android/repository/api.dart';
import 'package:wan_android/repository/data/my_collects_data.dart';

class MyCollectsViewModel with ChangeNotifier {
  List<MyCollectItemData> dataList = [];
  int _pageCount = 0;

  // 获取我的收藏列表
  Future getMyCollects(bool loadMore) async {
    if (loadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
      dataList.clear();
    }
    var list = await Api.instance.getMyCollects("$_pageCount");
    if (list != null && list.isNotEmpty == true) {
      dataList.addAll(list);
      notifyListeners();
    } else {
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
    // notifyListeners();
  }

  // 取消收藏文章
  Future cancelCollect(int index, String? id) async {
    bool? success = await Api.instance.collectOrNot(false, id ?? "");
    if (success == true) {
      try {
        dataList.remove(dataList[index]);
        notifyListeners();
      } catch (e) {
        log("cancelCollect error=$e");
      }
    }
  }
}
