import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/datas/home_banner_data.dart';
import 'package:flutter_demo/pages/home/home_list_data.dart';

class HomeViewModel with ChangeNotifier {
  List<BannerItemData>? bannerList;
  List<HomeListItemData>? listData;
  Dio dio = Dio();

  void initDio() {
    dio.options = BaseOptions(
      method: "GET",
      baseUrl: "https://www.wanandroid.com/",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
    );
  }

  Future getBanner() async {
    Response response = await dio.get("banner/json");
    HomeBannerData bannerData = HomeBannerData.fromJson(response.data);
    if (bannerData.data != null) {
      bannerList = bannerData.data;
    } else {
      bannerList = [];
    }
    notifyListeners();
  }

  Future getHomeList() async {
    Response response = await dio.get("article/list/0/json");
    HomeData homeData = HomeData.fromJson(response.data);
    if (homeData.data != null && homeData.data?.datas != null) {
      listData = homeData.data?.datas;
    } else {
      listData = [];
    }
    notifyListeners();
  }
}
