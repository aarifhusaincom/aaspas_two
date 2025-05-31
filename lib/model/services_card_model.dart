class ServicesCardModel {
  bool? success;
  List<Items>? items;
  String? msg;

  ServicesCardModel({this.success, this.items, this.msg});

  ServicesCardModel.fromJson(Map<String, dynamic> json) {
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
  String? karigarName;
  String? image;
  String? description;
  String? area;
  Location? location;
  String? pincode;
  int? charges;
  String? categoryId;
  int? phoneNo;
  int? age;
  String? gender;
  double? distance;
  double? distanceKm;
  String? categoryName;

  Items({
    this.sId,
    this.karigarName,
    this.image,
    this.description,
    this.area,
    this.location,
    this.pincode,
    this.charges,
    this.categoryId,
    this.phoneNo,
    this.age,
    this.gender,
    this.distance,
    this.distanceKm,
    this.categoryName,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    karigarName = json['karigar_name'];
    image = json['image'];
    description = json['description'];
    area = json['area'];
    location =
        json['location'] != null
            ? new Location.fromJson(json['location'])
            : null;
    pincode = json['pincode'];
    charges = json['charges'];
    categoryId = json['categoryId'];
    phoneNo = json['phoneNo'];
    age = json['age'];
    gender = json['gender'];
    distance = json['distance'];
    distanceKm = json['distanceKm'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['karigar_name'] = this.karigarName;
    data['image'] = this.image;
    data['description'] = this.description;
    data['area'] = this.area;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['pincode'] = this.pincode;
    data['charges'] = this.charges;
    data['categoryId'] = this.categoryId;
    data['phoneNo'] = this.phoneNo;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['distance'] = this.distance;
    data['distanceKm'] = this.distanceKm;
    data['categoryName'] = this.categoryName;
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
