class ShopDetailsModel {
  bool? success;
  List<Items>? items;
  String? msg;

  ShopDetailsModel({this.success, this.items, this.msg});

  ShopDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? shopType;
  String? address;
  String? area;
  Location? location;
  String? ownerName;
  int? phoneNo;
  List<String>? workingDays;
  String? openTime;
  String? closeTime;
  List<ShopImages>? shopImages;
  int? pincode;
  int? shopNo;
  int? click;
  int? rating;
  int? showPhoneNumber;
  int? verified;
  int? showItemType;
  List<String>? featuredCategories;
  List<String>? featuredItemTypeIds;
  List<String>? otherCategories;
  List<String>? otherItemTypeIds;
  int? active;
  double? distance;
  double? distanceKm;

  Items({
    this.sId,
    this.shopName,
    this.shopType,
    this.address,
    this.area,
    this.location,
    this.ownerName,
    this.phoneNo,
    this.workingDays,
    this.openTime,
    this.closeTime,
    this.shopImages,
    this.pincode,
    this.shopNo,
    this.click,
    this.rating,
    this.showPhoneNumber,
    this.verified,
    this.showItemType,
    this.featuredCategories,
    this.featuredItemTypeIds,
    this.otherCategories,
    this.otherItemTypeIds,
    this.active,
    this.distance,
    this.distanceKm,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shopName = json['shopName'];
    shopType = json['shopType'];
    address = json['address'];
    area = json['area'];
    location =
        json['location'] != null
            ? new Location.fromJson(json['location'])
            : null;
    ownerName = json['ownerName'];
    phoneNo = json['phoneNo'];
    workingDays = json['workingDays'].cast<String>();
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    if (json['shopImages'] != null) {
      shopImages = <ShopImages>[];
      json['shopImages'].forEach((v) {
        shopImages!.add(new ShopImages.fromJson(v));
      });
    }
    pincode = json['pincode'];
    shopNo = json['shopNo'];
    click = json['click'];
    rating = json['rating'];
    showPhoneNumber = json['showPhoneNumber'];
    verified = json['verified'];
    showItemType = json['showItemType'];
    featuredCategories = json['featuredCategories'].cast<String>();
    featuredItemTypeIds = json['featuredItemTypeIds'].cast<String>();
    otherCategories = json['otherCategories'].cast<String>();
    otherItemTypeIds = json['otherItemTypeIds'].cast<String>();
    active = json['active'];
    distance = json['distance'];
    distanceKm = json['distanceKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['shopName'] = this.shopName;
    data['shopType'] = this.shopType;
    data['address'] = this.address;
    data['area'] = this.area;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['ownerName'] = this.ownerName;
    data['phoneNo'] = this.phoneNo;
    data['workingDays'] = this.workingDays;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    if (this.shopImages != null) {
      data['shopImages'] = this.shopImages!.map((v) => v.toJson()).toList();
    }
    data['pincode'] = this.pincode;
    data['shopNo'] = this.shopNo;
    data['click'] = this.click;
    data['rating'] = this.rating;
    data['showPhoneNumber'] = this.showPhoneNumber;
    data['verified'] = this.verified;
    data['showItemType'] = this.showItemType;
    data['featuredCategories'] = this.featuredCategories;
    data['featuredItemTypeIds'] = this.featuredItemTypeIds;
    data['otherCategories'] = this.otherCategories;
    data['otherItemTypeIds'] = this.otherItemTypeIds;
    data['active'] = this.active;
    data['distance'] = this.distance;
    data['distanceKm'] = this.distanceKm;
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

class ShopImages {
  String? key;
  String? url;

  ShopImages({this.key, this.url});

  ShopImages.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['url'] = this.url;
    return data;
  }
}
