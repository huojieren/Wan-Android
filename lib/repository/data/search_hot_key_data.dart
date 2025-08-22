class SearchHotKeyListData {
  List<SearchHotKeyData>? searchHotKeyList;

  SearchHotKeyListData.fromJson(dynamic json) {
    searchHotKeyList = [];
    if (json is List) {
      for (var element in json) {
        searchHotKeyList?.add(SearchHotKeyData.fromJson(element));
      }
    }
  }
}

class SearchHotKeyData {
  SearchHotKeyData({this.id, this.link, this.name, this.order, this.visible});

  SearchHotKeyData.fromJson(dynamic json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  num? id;
  String? link;
  String? name;
  num? order;
  num? visible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['link'] = link;
    map['name'] = name;
    map['order'] = order;
    map['visible'] = visible;
    return map;
  }
}
