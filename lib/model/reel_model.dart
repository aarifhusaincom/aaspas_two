class ReelModel {
  bool? success;
  List<Items>? items;
  String? msg;

  ReelModel({this.success, this.items, this.msg});

  ReelModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class Items {
  String? sId;
  String? url;
  String? thumbnailUrl;
  String? shopId;
  int? count;
  int? views;
  ShopDetails? shopDetails;
  String? createdAt;

  Items({
    this.sId,
    this.url,
    this.thumbnailUrl,
    this.shopId,
    this.count,
    this.views,
    this.shopDetails,
    this.createdAt,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    url = json['url'];
    thumbnailUrl = json['thumbnail_url'];
    shopId = json['shop_id'];
    count = json['count'];
    views = json['views'];
    shopDetails =
        json['shopDetails'] != null
            ? ShopDetails.fromJson(json['shopDetails'])
            : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['url'] = url;
    data['thumbnail_url'] = thumbnailUrl;
    data['shop_id'] = shopId;
    data['count'] = count;
    if (shopDetails != null) {
      data['shopDetails'] = shopDetails!.toJson();
    }
    data['createdAt'] = createdAt;
    return data;
  }
}

class ShopDetails {
  String? sId;
  String? shopName;
  String? address;
  double? distanceKm;
  String? shopImageUrl;

  ShopDetails({
    this.sId,
    this.shopName,
    this.address,
    this.distanceKm,
    this.shopImageUrl,
  });

  ShopDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shopName = json['shopName'];
    address = json['address'];
    distanceKm = json['distanceKm'];
    shopImageUrl = json['shopImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['shopName'] = shopName;
    data['address'] = address;
    data['distanceKm'] = distanceKm;
    data['shopImageUrl'] = shopImageUrl;
    return data;
  }
}
