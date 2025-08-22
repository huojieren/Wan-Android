import 'package:dio/dio.dart';
import 'package:flutter_demo/http/base_model.dart';
import 'package:oktoast/oktoast.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 检查HTTP状态码
    if (response.statusCode == 200) {
      try {
        // 解析基础模型
        var responseData = BaseModel.fromJson(response.data);

        // 只处理特定errorCode
        if (responseData.errorCode == 0) {
          // 执行成功，返回data字段
          handler.next(Response(requestOptions: response.requestOptions, data: responseData.data));
        } else if (responseData.errorCode == -1001) {
          // 登录失效，需要重新登录
          showToast("请先登录");
          handler.reject(DioException(requestOptions: response.requestOptions, message: "未登录"));
        } else {
          // 其他所有errorCode都视为业务成功，但可能包含错误信息
          // 可以选择显示错误信息，但仍继续处理
          if (responseData.errorMsg?.isNotEmpty == true) {
            showToast(responseData.errorMsg!);
          }

          // 返回data字段，让业务层自行处理
          handler.next(Response(requestOptions: response.requestOptions, data: responseData.data));
        }
      } catch (e) {
        // JSON解析失败
        handler.reject(
          DioException(requestOptions: response.requestOptions, message: "数据解析失败: $e"),
        );
      }
    } else {
      // HTTP状态码非200
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          message: "网络请求失败，状态码: ${response.statusCode}",
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 网络错误处理
    String errorMessage = "网络请求出错";

    if (err.type == DioExceptionType.connectionTimeout) {
      errorMessage = "连接超时";
    } else if (err.type == DioExceptionType.receiveTimeout) {
      errorMessage = "接收超时";
    } else if (err.type == DioExceptionType.sendTimeout) {
      errorMessage = "发送超时";
    } else if (err.type == DioExceptionType.badResponse) {
      errorMessage = "服务器响应错误";
    } else if (err.type == DioExceptionType.cancel) {
      errorMessage = "请求已取消";
    } else if (err.type == DioExceptionType.unknown) {
      errorMessage = "未知错误";
    }

    showToast(errorMessage);
    handler.next(err);
  }
}
