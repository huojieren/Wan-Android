import 'package:flutter/foundation.dart';
import 'package:wan_android/repository/api.dart';
import 'package:wan_android/repository/data/search_data.dart';

class SearchViewModel extends ChangeNotifier {
  List<SearchListData>? searchList;

  Future search(String? keyword, {String? pageCount}) async {
    searchList = await Api.instance.searchList("0", keyword);
    notifyListeners();
  }

  void clear() {
    searchList?.clear();
    notifyListeners();
  }
}
