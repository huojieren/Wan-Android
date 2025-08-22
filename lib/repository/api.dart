import 'package:dio/dio.dart';
import 'package:flutter_demo/http/dio_instance.dart';
import 'package:flutter_demo/repository/data/common_website_data.dart';
import 'package:flutter_demo/repository/data/home_banner_data.dart';
import 'package:flutter_demo/repository/data/home_list_data.dart';
import 'package:flutter_demo/repository/data/search_hot_key_data.dart';

class Api {
  static Api instance = Api._();

  Api._();

  // 获取轮播图
  Future<List<HomeBannerData?>?> getBanner() async {
    Response response = await DioInstance.instance().get(path: "banner/json");
    HomeBannerListData bannerData = HomeBannerListData.fromJson(response.data);
    return bannerData.bannerList;
  }

  // 获取首页列表
  Future<List<HomeListItemData>?> getHomeList(String pageCount) async {
    Response response = await DioInstance.instance().get(path: "article/list/$pageCount/json");
    HomeListData homeData = HomeListData.fromJson(response.data);
    return homeData.datas;
  }

  // 获取首页置顶列表
  Future<List<HomeListItemData>?> getHomeTopList() async {
    Response response = await DioInstance.instance().get(path: "article/top/json");
    HomeTopListData homeData = HomeTopListData.fromJson(response.data);
    return homeData.topList;
  }

  // 获取常用网站
  Future<List<CommonWebsiteData>?> getWebsiteList() async {
    Response response = await DioInstance.instance().get(path: "friend/json");
    CommonWebsiteListData websiteListData = CommonWebsiteListData.fromJson(response.data);
    return websiteListData.websiteList;
  }

  Future<List<SearchHotKeyData>?> getSearchHotkeyList() async {
    Response response = await DioInstance.instance().get(path: "hotkey/json");
    SearchHotKeyListData hotKeyListData = SearchHotKeyListData.fromJson(response.data);
    return hotKeyListData.searchHotKeyList;
  }
}
