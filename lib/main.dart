import 'package:flutter/material.dart';
import 'package:flutter_demo/http/dio_instance.dart';

import 'app.dart';

void main() {
  DioInstance.instance().initDio(baseUrl: "https://www.wanandroid.com/");

  runApp(const MyApp());
}
