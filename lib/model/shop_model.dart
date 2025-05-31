class ShopModel {
  bool? success;
  List<Items>? items;
  String? msg;

  ShopModel({this.success, this.items, this.msg});

  ShopModel.fromJson(Map<String, dynamic> json) {
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
  String? shopName;
  String? address;
  Location? location;
  int? rating;
  double? distanceKm;
  String? bigImageUrl;

  Items({
    this.sId,
    this.shopName,
    this.address,
    this.location,
    this.rating,
    this.distanceKm,
    this.bigImageUrl,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shopName = json['shopName'];
    address = json['address'];
    location =
        json['location'] != null
            ? Location.fromJson(json['location'])
            : null;
    rating = json['rating'];
    distanceKm = json['distanceKm'];
    bigImageUrl = json['bigImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['shopName'] = shopName;
    data['address'] = address;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['rating'] = rating;
    data['distanceKm'] = distanceKm;
    data['bigImageUrl'] = bigImageUrl;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
