class ShopCatsItemsModel {
  bool? success;
  List<ShopItems>? items;
  List<ShopCategories>? categories;
  String? msg;

  ShopCatsItemsModel({this.success, this.items, this.categories, this.msg});

  ShopCatsItemsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['items'] != null) {
      items = <ShopItems>[];
      json['items'].forEach((v) {
        items!.add(new ShopItems.fromJson(v));
      });
    }
    if (json['category'] != null) {
      categories = <ShopCategories>[];
      json['category'].forEach((v) {
        categories!.add(new ShopCategories.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['success'] = this.success;
  //   if (this.items != null) {
  //     data['items'] = this.items!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.categories != null) {
  //     data['category'] = this.categories!.map((v) => v.toJson()).toList();
  //   }
  //   data['msg'] = this.msg;
  //   return data;
  // }
}

class ShopItems {
  String? sId;
  String? shopName;
  List<FeaturedItems>? featuredItems;
  List<OtherItems>? otherItems;

  ShopItems({this.sId, this.shopName, this.featuredItems, this.otherItems});

  ShopItems.fromJson(Map<String, dynamic> json) {
    // print("ShopItems.fromJson(Map<String, dynamic> json)");
    sId = json['_id'];
    shopName = json['shopName'];
    if (json['featuredItems'] != null && json['featuredItems'].length > 0) {
      featuredItems = <FeaturedItems>[];
      json['featuredItems'].forEach((v) {
        featuredItems!.add(new FeaturedItems.fromJson(v));
      });
    }
    if (json['otherItems'] != null && json['otherItems'].length > 0) {
      otherItems = <OtherItems>[];
      json['otherItems'].forEach((v) {
        otherItems!.add(new OtherItems.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['shopName'] = this.shopName;
  //   if (this.featuredItems != null) {
  //     data['featuredItems'] =
  //         this.featuredItems!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.otherItems != null) {
  //     data['otherItems'] = this.otherItems!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class FeaturedItems {
  String? sId;
  String? itemName;

  FeaturedItems({this.sId, this.itemName});

  FeaturedItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemName = json['item_name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['item_name'] = this.itemName;
  //   return data;
  // }
}

class OtherItems {
  String? sId;
  String? itemName;

  OtherItems({this.sId, this.itemName});

  OtherItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemName = json['item_name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['item_name'] = this.itemName;
  //   return data;
  // }
}

class ShopCategories {
  String? sId;
  String? shopName;
  List<FeaturedCategoryDetails>? featuredCategoryDetails;
  List<OtherCategoryDetails>? otherCategoryDetails;

  ShopCategories({
    this.sId,
    this.shopName,
    this.featuredCategoryDetails,
    this.otherCategoryDetails,
  });

  ShopCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shopName = json['shopName'];
    if (json['featuredCategoryDetails'] != null &&
        json['featuredCategoryDetails'].length > 0) {
      featuredCategoryDetails = <FeaturedCategoryDetails>[];
      json['featuredCategoryDetails'].forEach((v) {
        featuredCategoryDetails!.add(new FeaturedCategoryDetails.fromJson(v));
      });
    }
    if (json['otherCategoryDetails'] != null &&
        json['otherCategoryDetails'].length > 0) {
      print(
        "json['otherCategoryDetails'] != null && json['otherCategoryDetails'].length > 0",
      );
      print(
        json['otherCategoryDetails'] != null &&
            json['otherCategoryDetails'].length > 0,
      );
      otherCategoryDetails = <OtherCategoryDetails>[];
      json['otherCategoryDetails'].forEach((v) {
        otherCategoryDetails!.add(new OtherCategoryDetails.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['shopName'] = this.shopName;
  //   if (this.featuredCategoryDetails != null) {
  //     data['featuredCategoryDetails'] =
  //         this.featuredCategoryDetails!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.otherCategoryDetails != null) {
  //     data['otherCategoryDetails'] =
  //         this.otherCategoryDetails!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class FeaturedCategoryDetails {
  String? sId;
  String? categoryName;
  String? categoryImage;

  FeaturedCategoryDetails({this.sId, this.categoryName, this.categoryImage});

  FeaturedCategoryDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['category_name'] = this.categoryName;
  //   data['category_image'] = this.categoryImage;
  //   return data;
  // }
}

class OtherCategoryDetails {
  String? sId;
  String? categoryName;
  String? categoryImage;

  OtherCategoryDetails({this.sId, this.categoryName, this.categoryImage});

  OtherCategoryDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['category_name'] = this.categoryName;
  //   data['category_image'] = this.categoryImage;
  //   return data;
  // }
}
