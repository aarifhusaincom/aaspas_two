class ShopDetailsModel {
  bool? success;
  List<ShopDetailsItems>? items;
  String? msg;

  ShopDetailsModel({this.success, this.items, this.msg});

  ShopDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['items'] != null) {
      items = <ShopDetailsItems>[];
      json['items'].forEach((v) {
        items!.add(new ShopDetailsItems.fromJson(v));
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

class ShopDetailsItems {
  String? sId;
  String? shopName;
  List<String>? shopType;
  String? address;
  String? area;
  Location? location;
  String? ownerName;
  int? phoneNo;
  List<String>? workingDays;
  String? openTime;
  String? closeTime;
  List<String>? shopImages;
  int? pincode;
  int? shopNo;
  int? click;
  int? rating;
  int? verified;
  int? showPhoneNumber;
  int? showItemType;
  int? active;
  String? description;
  String? offer;
  String? video;
  String? offerExpiryDate;
  List<String>? featuredCategories;
  List<String>? otherCategories;
  List<String>? featuredItemTypeIds;
  List<String>? otherItemTypeIds;
  double? distance;
  double? distanceKm;

  ShopDetailsItems({
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
    this.verified,
    this.showPhoneNumber,
    this.showItemType,
    this.active,
    this.description,
    this.offer,
    this.video,
    this.offerExpiryDate,
    this.featuredCategories,
    this.otherCategories,
    this.featuredItemTypeIds,
    this.otherItemTypeIds,
    this.distance,
    this.distanceKm,
  });

  ShopDetailsItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shopName = json['shopName'];
    shopType = json['shopType'].cast<String>();
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
    shopImages = json['shopImages'].cast<String>();
    pincode = json['pincode'];
    shopNo = json['shopNo'];
    click = json['click'];
    rating = json['rating'];
    verified = json['verified'];
    showPhoneNumber = json['showPhoneNumber'];
    showItemType = json['showItemType'];
    active = json['active'];
    description = json['description'];
    offer = json['offer'];
    video = json['video'];
    offerExpiryDate = json['offerExpiryDate'];
    featuredCategories = json['featuredCategories'].cast<String>();
    otherCategories = json['otherCategories'].cast<String>();
    featuredItemTypeIds = json['featuredItemTypeIds'].cast<String>();
    otherItemTypeIds = json['otherItemTypeIds'].cast<String>();
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
    data['shopImages'] = this.shopImages;
    data['pincode'] = this.pincode;
    data['shopNo'] = this.shopNo;
    data['click'] = this.click;
    data['rating'] = this.rating;
    data['verified'] = this.verified;
    data['showPhoneNumber'] = this.showPhoneNumber;
    data['showItemType'] = this.showItemType;
    data['active'] = this.active;
    data['description'] = this.description;
    data['offer'] = this.offer;
    data['video'] = this.video;
    data['offerExpiryDate'] = this.offerExpiryDate;
    data['featuredCategories'] = this.featuredCategories;
    data['otherCategories'] = this.otherCategories;
    data['featuredItemTypeIds'] = this.featuredItemTypeIds;
    data['otherItemTypeIds'] = this.otherItemTypeIds;
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
