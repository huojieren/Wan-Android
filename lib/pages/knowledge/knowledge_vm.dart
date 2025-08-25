import 'package:flutter/widgets.dart';
import 'package:wan_android/repository/api.dart';
import 'package:wan_android/repository/data/knowledge_list_data.dart';

class KnowledgeViewModel with ChangeNotifier {
  List<KnowledgeListData?>? list;

  Future getKnowledgeList() async {
    list = await Api.instance.getKnowledgeList();
    notifyListeners();
  }

  String generalSubTitle(List<KnowledgeChildren?>? children) {
    if (children == null || children.isEmpty == true) {
      return "";
    }
    StringBuffer buffer = StringBuffer("");
    for (var item in children) {
      buffer.write("${item?.name} ");
    }
    return buffer.toString();
  }
}
