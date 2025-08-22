class CommonWebsiteListData {
  List<CommonWebsiteData>? websiteList;

  CommonWebsiteListData.fromJson(dynamic json) {
    websiteList = [];
    if (json is List) {
      for (var element in json) {
        websiteList?.add(CommonWebsiteData.fromJson(element));
      }
    }
  }
}

class CommonWebsiteData {
  CommonWebsiteData({
    this.category,
    this.icon,
    this.id,
    this.link,
    this.name,
    this.order,
    this.visible,
  });

  CommonWebsiteData.fromJson(dynamic json) {
    category = json['category'];
    icon = json['icon'];
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  String? category;
  String? icon;
  num? id;
  String? link;
  String? name;
  num? order;
  num? visible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = category;
    map['icon'] = icon;
    map['id'] = id;
    map['link'] = link;
    map['name'] = name;
    map['order'] = order;
    map['visible'] = visible;
    return map;
  }
}
