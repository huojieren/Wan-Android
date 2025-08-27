import 'package:flutter/foundation.dart';
import 'package:wan_android/repository/api.dart';
import 'package:wan_android/repository/data/search_data.dart';

class SearchViewModel extends ChangeNotifier {
  List<SearchListData>? searchList;
  int _pageCount = 0;

  Future initSearch(String? keyword) async {
    _pageCount = 0;
    // searchList?.clear();
    await search(keyword: keyword, loadMore: false);
  }

  Future search({String? keyword, bool loadMore = false}) async {
    if (loadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
      searchList?.clear();
    }

    var result = await Api.instance.searchList("$_pageCount", keyword);
    if (result?.isNotEmpty == true) {
      searchList ??= [];
      searchList!.addAll(result ?? []);
      notifyListeners();
    } else {
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
  }

  void clear() {
    _pageCount = 0;
    searchList?.clear();
    notifyListeners();
  }
}
