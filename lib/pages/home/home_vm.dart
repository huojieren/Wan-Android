import 'package:flutter/cupertino.dart';
import 'package:wan_android/repository/api.dart';
import 'package:wan_android/repository/data/home_banner_data.dart';
import 'package:wan_android/repository/data/home_list_data.dart';

class HomeViewModel with ChangeNotifier {
  List<HomeBannerData?>? bannerList = [];
  List<HomeListItemData>? listData = [];
  int pageCount = 0;

  Future getBanner() async {
    List<HomeBannerData?>? fetchedBannerList = await Api.instance.getBanner();
    bannerList = fetchedBannerList ??= [];
    notifyListeners();
  }

  Future initListData(bool loadMore, {ValueChanged<bool>? callback}) async {
    if (loadMore) {
      pageCount++;
    } else {
      pageCount = 0;
      listData?.clear();
    }
    getTopList(loadMore).then((fetchedTopList) {
      if (!loadMore) {
        listData?.addAll(fetchedTopList ??= []);
      }
      getHomeList(loadMore).then((fetchedHomeList) {
        listData?.addAll(fetchedHomeList ??= []);
        notifyListeners();
        callback?.call(loadMore);
      });
    });
  }

  Future<List<HomeListItemData>?> getTopList(bool loadMore) async {
    if (loadMore) {
      return [];
    }
    List<HomeListItemData>? fetchedTopList = await Api.instance
        .getHomeTopList();
    return fetchedTopList;
  }

  Future<List<HomeListItemData>?> getHomeList(bool loadMore) async {
    List<HomeListItemData>? fetchedHomeList = await Api.instance.getHomeList(
      "$pageCount",
    );
    if (fetchedHomeList != null && fetchedHomeList.isNotEmpty) {
      return fetchedHomeList;
    } else {
      if (loadMore && pageCount > 0) {
        pageCount--;
      }
      return [];
    }
  }
}
