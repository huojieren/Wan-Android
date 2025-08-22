import 'package:dio/dio.dart';
import 'package:flutter_demo/http/dio_instance.dart';
import 'package:flutter_demo/repository/data/auth_data.dart';
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
    if (response.data != null) {
      HomeBannerListData bannerData = HomeBannerListData.fromJson(response.data);
      return bannerData.bannerList;
    }
    return [];
  }

  // 获取首页列表
  Future<List<HomeListItemData>?> getHomeList(String pageCount) async {
    Response response = await DioInstance.instance().get(path: "article/list/$pageCount/json");
    if (response.data != null) {
      HomeListData homeData = HomeListData.fromJson(response.data);
      return homeData.datas;
    }
    return [];
  }

  // 获取首页置顶列表
  Future<List<HomeListItemData>?> getHomeTopList() async {
    Response response = await DioInstance.instance().get(path: "article/top/json");
    if (response.data != null) {
      HomeTopListData homeData = HomeTopListData.fromJson(response.data);
      return homeData.topList;
    }
    return [];
  }

  // 获取常用网站
  Future<List<CommonWebsiteData>?> getWebsiteList() async {
    Response response = await DioInstance.instance().get(path: "friend/json");
    if (response.data != null) {
      CommonWebsiteListData websiteListData = CommonWebsiteListData.fromJson(response.data);
      return websiteListData.websiteList;
    }
    return [];
  }

  // 获取搜索热词
  Future<List<SearchHotKeyData>?> getSearchHotkeyList() async {
    Response response = await DioInstance.instance().get(path: "hotkey/json");
    if (response.data != null) {
      SearchHotKeyListData hotKeyListData = SearchHotKeyListData.fromJson(response.data);
      return hotKeyListData.searchHotKeyList;
    }
    return [];
  }

  // 注册
  Future<bool> register({
    required String? username,
    required String? password,
    required String? repassword,
  }) async {
    Response response = await DioInstance.instance().post(
      path: "user/register",
      queryParameters: {"username": username, "password": password, "repassword": repassword},
    );
    // 根据拦截器，成功时返回实际数据，失败时抛出异常。如果返回了数据（即使是null），说明注册成功
    return response.data != null;
  }

  // 登录
  Future<AuthData> login({required String? username, required String? password}) async {
    Response response = await DioInstance.instance().post(
      path: "user/login",
      queryParameters: {"username": username, "password": password},
    );
    return AuthData.fromJson(response.data);
  }
}
