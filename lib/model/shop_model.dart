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
        items!.add(new Items.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Items {
  String? sId;
  String? shopName;
  String? address;
  Location? location;
  int? rating;
  int? verified;
  double? distanceKm;
  String? shopImage;

  Items({
    this.sId,
    this.shopName,
    this.address,
    this.location,
    this.rating,
    this.verified,
    this.distanceKm,
    this.shopImage,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shopName = json['shopName'];
    address = json['address'];
    location =
        json['location'] != null
            ? new Location.fromJson(json['location'])
            : null;
    rating = json['rating'];
    verified = json['verified'];
    distanceKm = json['distanceKm'];
    shopImage = json['shopImage'] is String ? json['shopImage'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['shopName'] = this.shopName;
    data['address'] = this.address;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['rating'] = this.rating;
    data['verified'] = this.verified;
    data['distanceKm'] = this.distanceKm;
    data['shopImage'] = this.shopImage;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
