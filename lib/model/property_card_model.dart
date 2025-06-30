// class PropertyCardModel {
//   bool? success;
//   List<Items>? items;
//   String? msg;
//
//   PropertyCardModel({this.success, this.items, this.msg});
//
//   PropertyCardModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(Items.fromJson(v));
//       });
//     }
//     msg = json['msg'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     data['msg'] = this.msg;
//     return data;
//   }
// }
//
// class Items {
//   String? sId;
//   String? title;
//   int? actualPrice;
//   String? visualPrice;
//   int? totalArea;
//   String? area;
//   List<dynamic>? images;
//   int? phoneNo;
//   String? brokerageType;
//   String? city;
//   double? distanceKm;
//
//   Items({
//     this.sId,
//     this.title,
//     this.actualPrice,
//     this.visualPrice,
//     this.totalArea,
//     this.area,
//     this.images,
//     this.phoneNo,
//     this.brokerageType,
//     this.city,
//     this.distanceKm,
//   });
//
//   Items.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     actualPrice = json['actual_price'];
//     visualPrice = json['visual_price'];
//     totalArea = json['totalArea'];
//     area = json['area'];
//     images = json['images'];
//     phoneNo = json['phoneNo'];
//     brokerageType = json['brokerageType'];
//     city = json['city'];
//     distanceKm = json['distanceKm'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['actual_price'] = actualPrice;
//     data['visual_price'] = visualPrice;
//     data['totalArea'] = totalArea;
//     data['area'] = area;
//     data['images'] = images;
//     data['phoneNo'] = phoneNo;
//     data['brokerageType'] = brokerageType;
//     data['city'] = city;
//     data['distanceKm'] = distanceKm;
//     return data;
//   }
// }
