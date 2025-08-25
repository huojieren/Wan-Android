import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wan_android/constants.dart';
import 'package:wan_android/utils/sp_utils.dart';

class CookiesInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    SpUtils.getStringList(Constants.SP_Cookie_List).then((cookieList) {
      options.headers[HttpHeaders.cookieHeader] = cookieList;
      handler.next(options);
    });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    if (response.requestOptions.path.contains("user/login")) {
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookieList = [];
      if (list is List) {
        for (String? cookie in list) {
          cookieList.add(cookie ?? "");
          print("CookiesInterceptor cookie = ${cookie.toString()}");
        }
      }
      SpUtils.saveStringList(Constants.SP_Cookie_List, cookieList);
    }
  }
}
