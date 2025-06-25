class PropertyByCategoryIdModel {
  bool? success;
  List<Items>? items;
  String? msg;

  PropertyByCategoryIdModel({this.success, this.items, this.msg});

  PropertyByCategoryIdModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  int? actualPrice;
  String? visualPrice;
  int? totalArea;
  String? area;
  String? images;
  int? phoneNo;
  String? brokerageType;
  String? city;
  int? propertyId;
  String? videoUrl;
  double? distanceKm;

  Items({
    this.sId,
    this.title,
    this.actualPrice,
    this.visualPrice,
    this.totalArea,
    this.area,
    this.images,
    this.phoneNo,
    this.brokerageType,
    this.city,
    this.propertyId,
    this.videoUrl,
    this.distanceKm,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    actualPrice = json['actual_price'];
    visualPrice = json['visual_price'];
    totalArea = json['totalArea'];
    area = json['area'];
    images = json['images'];
    phoneNo = json['phoneNo'];
    brokerageType = json['brokerageType'];
    city = json['city'];
    propertyId = json['propertyId'];
    videoUrl = json['videoUrl'];
    distanceKm = json['distanceKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['actual_price'] = this.actualPrice;
    data['visual_price'] = this.visualPrice;
    data['totalArea'] = this.totalArea;
    data['area'] = this.area;
    data['images'] = this.images;
    data['phoneNo'] = this.phoneNo;
    data['brokerageType'] = this.brokerageType;
    data['city'] = this.city;
    data['propertyId'] = this.propertyId;
    data['videoUrl'] = this.videoUrl;
    data['distanceKm'] = this.distanceKm;
    return data;
  }
}
