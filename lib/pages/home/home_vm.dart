import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/repository/api.dart';
import 'package:flutter_demo/repository/datas/home_banner_data.dart';
import 'package:flutter_demo/repository/datas/home_list_data.dart';

class HomeViewModel with ChangeNotifier {
  List<HomeBannerData?>? bannerList = [];
  List<HomeListItemData>? listData = [];

  Future getBanner() async {
    List<HomeBannerData?>? fetchedBannerList = await Api.instance.getBanner();
    bannerList = fetchedBannerList ??= [];
    notifyListeners();
  }

  Future initListData() async {
    await getTopList();
    await getHomeList();
  }

  Future getTopList() async {
    List<HomeListItemData>? fetchedTopList = await Api.instance
        .getHomeTopList();
    listData?.clear();
    listData?.addAll(fetchedTopList ??= []);
  }

  Future getHomeList() async {
    List<HomeListItemData>? fetchedHomeList = await Api.instance.getHomeList();
    listData?.addAll(fetchedHomeList ??= []);
    notifyListeners();
  }
}
