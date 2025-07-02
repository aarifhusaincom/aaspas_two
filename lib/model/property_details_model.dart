class PropertyDetailsModel {
  bool? success;
  List<PropertyDetailsItems>? items;
  String? msg;

  PropertyDetailsModel({this.success, this.items, this.msg});

  PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['items'] != null) {
      items = <PropertyDetailsItems>[];
      json['items'].forEach((v) {
        items!.add(new PropertyDetailsItems.fromJson(v));
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

class PropertyDetailsItems {
  String? sId;
  String? categoryId;
  String? itemId;
  String? itemName;
  String? title;
  int? actualPrice;
  String? visualPrice;
  String? description;
  int? totalArea;
  int? pincode;
  String? area;
  List<String>? images;
  String? ownerName;
  String? propUserType;
  int? phoneNo;
  String? brokerageType;
  List<String>? facilities;
  Location? location;
  String? city;
  int? securityDeposit;
  String? noOfMonthsSecurity;
  int? brokerageAmount;
  int? maintenanceAmount;
  int? propertyId;
  String? videoUrl;
  List<FacilityDetails>? facilityDetails;

  PropertyDetailsItems({
    this.sId,
    this.categoryId,
    this.itemId,
    this.itemName,
    this.title,
    this.actualPrice,
    this.visualPrice,
    this.description,
    this.totalArea,
    this.pincode,
    this.area,
    this.images,
    this.ownerName,
    this.propUserType,
    this.phoneNo,
    this.brokerageType,
    this.facilities,
    this.location,
    this.city,
    this.securityDeposit,
    this.noOfMonthsSecurity,
    this.brokerageAmount,
    this.maintenanceAmount,
    this.propertyId,
    this.videoUrl,
    this.facilityDetails,
  });

  PropertyDetailsItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    itemId = json['itemId'];
    itemName = json['itemName'];
    title = json['title'];
    actualPrice = json['actual_price'];
    visualPrice = json['visual_price'];
    description = json['description'];
    totalArea = json['totalArea'];
    pincode = json['pincode'];
    area = json['area'];
    images = json['images'].cast<String>();
    ownerName = json['ownerName'];
    propUserType = json['prop_user_type'];
    phoneNo = json['phoneNo'];
    brokerageType = json['brokerageType'];
    facilities = json['facilities'].cast<String>();
    location =
        json['location'] != null
            ? new Location.fromJson(json['location'])
            : null;
    city = json['city'];
    securityDeposit = json['security_deposit'];
    noOfMonthsSecurity = json['no_of_months_security'];
    brokerageAmount =
        (json['brokerageAmount'] == "") ? 0 : json['brokerageAmount'];
    maintenanceAmount = json['maintenance_amount'];
    propertyId = json['propertyId'];
    videoUrl = json['videoUrl'];
    if (json['facilityDetails'] != null) {
      facilityDetails = <FacilityDetails>[];
      json['facilityDetails'].forEach((v) {
        facilityDetails!.add(new FacilityDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['categoryId'] = this.categoryId;
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['title'] = this.title;
    data['actual_price'] = this.actualPrice;
    data['visual_price'] = this.visualPrice;
    data['description'] = this.description;
    data['totalArea'] = this.totalArea;
    data['pincode'] = this.pincode;
    data['area'] = this.area;
    data['images'] = this.images;
    data['ownerName'] = this.ownerName;
    data['prop_user_type'] = this.propUserType;
    data['phoneNo'] = this.phoneNo;
    data['brokerageType'] = this.brokerageType;
    data['facilities'] = this.facilities;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['city'] = this.city;
    data['security_deposit'] = this.securityDeposit;
    data['no_of_months_security'] = this.noOfMonthsSecurity;
    data['brokerageAmount'] = this.brokerageAmount;
    data['maintenance_amount'] = this.maintenanceAmount;
    data['propertyId'] = this.propertyId;
    data['videoUrl'] = this.videoUrl;
    if (this.facilityDetails != null) {
      data['facilityDetails'] =
          this.facilityDetails!.map((v) => v.toJson()).toList();
    }
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

class FacilityDetails {
  String? facilityId;
  String? name;
  String? image;

  FacilityDetails({this.facilityId, this.name, this.image});

  FacilityDetails.fromJson(Map<String, dynamic> json) {
    facilityId = json['facilityId'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facilityId'] = this.facilityId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
