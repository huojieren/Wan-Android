import 'package:dio/dio.dart';
import 'package:flutter_demo/datas/home_banner_data.dart';

class HomeViewModel {
  static Future<List<BannerItemData>?> getBanner() async {
    Dio dio = Dio();
    dio.options = BaseOptions(
      method: "GET",
      baseUrl: "https://www.wanandroid.com/",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
    );
    Response response = await dio.get("banner/json");
    HomeBannerData bannerData = HomeBannerData.fromJson(response.data);
    if (bannerData.data != null) {
      return bannerData.data;
    }
    return [];
  }
}
