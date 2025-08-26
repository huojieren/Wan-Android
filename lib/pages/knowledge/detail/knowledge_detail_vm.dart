import 'package:flutter/material.dart';
import 'package:wan_android/repository/api.dart';
import 'package:wan_android/repository/data/knowledge_detail_list_data.dart';
import 'package:wan_android/repository/data/knowledge_list_data.dart';

class KnowledgeDetailViewModel with ChangeNotifier {
  List<Tab> tabList = [];
  List<KnowledgeDetailItemData> detailList = [];
  int _pageCount = 0;

  void initTabs(List<KnowledgeChildren>? tabList) {
    tabList?.forEach((element) {
      this.tabList.add(Tab(text: element.name ?? ""));
    });
  }

  Future getDetailList(String? cid, bool isLoadMore) async {
    if (isLoadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
      detailList.clear();
    }
    var list = await Api.instance.getKnowledgeListItem(_pageCount.toString(), cid);
    if (list?.isNotEmpty == true) {
      detailList.addAll(list ?? []);
      notifyListeners();
    } else {
      if (isLoadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
  }
}
