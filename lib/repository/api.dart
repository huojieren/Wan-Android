import 'package:dio/dio.dart';
import 'package:flutter_demo/http/dio_instance.dart';
import 'package:flutter_demo/repository/datas/home_banner_data.dart';
import 'package:flutter_demo/repository/datas/home_list_data.dart';

class Api {
  static Api instance = Api._();

  Api._();

  Future<List<HomeBannerData?>?> getBanner() async {
    Response response = await DioInstance.instance().get(path: "banner/json");
    HomeBannerListData bannerData = HomeBannerListData.fromJson(response.data);
    return bannerData.bannerList;
  }

  Future<List<HomeListItemData>?> getHomeList() async {
    Response response = await DioInstance.instance().get(
      path: "article/list/0/json",
    );
    HomeListData homeData = HomeListData.fromJson(response.data);
    return homeData.datas;
  }

  Future<List<HomeListItemData>?> getHomeTopList() async {
    Response response = await DioInstance.instance().get(
      path: "article/top/json",
    );
    HomeTopListData homeData = HomeTopListData.fromJson(response.data);
    return homeData.topList;
  }
}
