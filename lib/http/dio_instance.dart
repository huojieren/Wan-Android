import 'package:dio/dio.dart';
import 'package:wan_android/http/http_method.dart';
import 'package:wan_android/http/interceptor/cookies_interceptor.dart';
import 'package:wan_android/http/interceptor/print_log_interceptor.dart';
import 'package:wan_android/http/interceptor/rsp_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;
  static const _defaultTime = Duration(seconds: 30);
  final _dio = Dio();

  DioInstance._();

  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  void initDio({
    required String baseUrl,
    String? httpMethod = HttpMethod.GET,
    Duration? connectTimeout = _defaultTime,
    Duration? receiveTimeout = _defaultTime,
    Duration? sendTimeout = _defaultTime,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
      method: httpMethod,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      responseType: responseType,
      contentType: contentType,
    );
    // 添加Cookie拦截器
    _dio.interceptors.add(CookiesInterceptor());
    // 添加打印请求返回信息拦截器
    _dio.interceptors.add(PrintLogInterceptor());
    // 添加统一返回值处理拦截器
    _dio.interceptors.add(ResponseInterceptor());
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.get(
      path,
      queryParameters: param,
      options:
          options ??
          Options(method: HttpMethod.GET, receiveTimeout: _defaultTime, sendTimeout: _defaultTime),
      cancelToken: cancelToken,
    );
  }

  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options:
          options ??
          Options(method: HttpMethod.POST, receiveTimeout: _defaultTime, sendTimeout: _defaultTime),
      cancelToken: cancelToken,
    );
  }
}
