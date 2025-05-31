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
  List<Images>? images;
  int? phoneNo;
  String? brokerageType;
  String? city;
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
    this.distanceKm,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    actualPrice = json['actual_price'];
    visualPrice = json['visual_price'];
    totalArea = json['totalArea'];
    area = json['area'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    phoneNo = json['phoneNo'];
    brokerageType = json['brokerageType'];
    city = json['city'];
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
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['phoneNo'] = this.phoneNo;
    data['brokerageType'] = this.brokerageType;
    data['city'] = this.city;
    data['distanceKm'] = this.distanceKm;
    return data;
  }
}

class Images {
  String? key;
  String? url;

  Images({this.key, this.url});

  Images.fromJson(Map<String, dynamic> json) {
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
