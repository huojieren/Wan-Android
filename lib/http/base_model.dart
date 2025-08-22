class BaseModel<T> {
  T? data;
  int? errorCode;
  String? errorMsg;

  BaseModel.fromJson(dynamic json) {
    // 增强null安全检查
    if (json is Map<String, dynamic>) {
      data = json["data"];
      errorCode = json["errorCode"] as int?;
      errorMsg = json["errorMsg"] as String?;
    } else {
      errorCode = -1;
      errorMsg = "响应数据格式错误";
    }
  }
}
