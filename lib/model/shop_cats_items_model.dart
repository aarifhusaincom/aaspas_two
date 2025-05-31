class ShopCatsItemsModel {
  final bool success;
  final List<ShopItem> items;
  final List<ShopCategory> category;
  final String msg;

  ShopCatsItemsModel({
    required this.success,
    required this.items,
    required this.category,
    required this.msg,
  });

  factory ShopCatsItemsModel.fromJson(Map<String, dynamic> json) {
    return ShopCatsItemsModel(
      success: json['success'],
      items: (json['items'] as List).map((e) => ShopItem.fromJson(e)).toList(),
      category:
          (json['category'] as List)
              .map((e) => ShopCategory.fromJson(e))
              .toList(),
      msg: json['msg'],
    );
  }
}

class ShopItem {
  final String id;
  final String shopName;
  final List<FeaturedItem> featuredItems;
  final List<FeaturedItem> otherItems;

  ShopItem({
    required this.id,
    required this.shopName,
    required this.featuredItems,
    required this.otherItems,
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      id: json['_id'],
      shopName: json['shopName'],
      featuredItems:
          (json['featuredItems'] as List)
              .map((e) => FeaturedItem.fromJson(e))
              .toList(),
      otherItems:
          (json['otherItems'] as List)
              .map((e) => FeaturedItem.fromJson(e))
              .toList(),
    );
  }
}

class FeaturedItem {
  final String id;
  final String itemName;

  FeaturedItem({required this.id, required this.itemName});

  factory FeaturedItem.fromJson(Map<String, dynamic> json) {
    return FeaturedItem(id: json['_id'], itemName: json['item_name']);
  }
}

class ShopCategory {
  final String id;
  final String shopName;
  final List<CategoryDetail> featuredCategoryDetails;
  final List<CategoryDetail> otherCategoryDetails;

  ShopCategory({
    required this.id,
    required this.shopName,
    required this.featuredCategoryDetails,
    required this.otherCategoryDetails,
  });

  factory ShopCategory.fromJson(Map<String, dynamic> json) {
    return ShopCategory(
      id: json['_id'],
      shopName: json['shopName'],
      featuredCategoryDetails:
          (json['featuredCategoryDetails'] as List)
              .map((e) => CategoryDetail.fromJson(e))
              .toList(),
      otherCategoryDetails:
          (json['otherCategoryDetails'] as List)
              .map((e) => CategoryDetail.fromJson(e))
              .toList(),
    );
  }
}

class CategoryDetail {
  final String id;
  final String categoryName;
  final String categoryImage;

  CategoryDetail({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
  });

  factory CategoryDetail.fromJson(Map<String, dynamic> json) {
    return CategoryDetail(
      id: json['_id'],
      categoryName: json['category_name'],
      categoryImage: json['category_image'],
    );
  }
}
