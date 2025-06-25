class WizardModel {
  GeneralInfo? generalInfo;
  AppStrings? appStrings;
  Api? api;

  WizardModel({this.generalInfo, this.appStrings, this.api});

  WizardModel.fromJson(Map<String, dynamic> json) {
    generalInfo =
        json['generalInfo'] != null
            ? new GeneralInfo.fromJson(json['generalInfo'])
            : null;
    appStrings =
        json['appStrings'] != null
            ? new AppStrings.fromJson(json['appStrings'])
            : null;
    api = json['api'] != null ? new Api.fromJson(json['api']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generalInfo != null) {
      data['generalInfo'] = this.generalInfo!.toJson();
    }
    if (this.appStrings != null) {
      data['appStrings'] = this.appStrings!.toJson();
    }
    if (this.api != null) {
      data['api'] = this.api!.toJson();
    }
    return data;
  }
}

class GeneralInfo {
  String? appName;
  int? appNameFontSize;
  String? platform;
  bool? checkVersionForUpdate;
  String? minAppVersion;
  bool? itemTypeVisible;
  bool? cardVisibleOnReel;
  bool? orientationLock;

  GeneralInfo({
    this.appName,
    this.appNameFontSize,
    this.platform,
    this.checkVersionForUpdate,
    this.minAppVersion,
    this.itemTypeVisible,
    this.cardVisibleOnReel,
    this.orientationLock,
  });

  GeneralInfo.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    appNameFontSize = json['appNameFontSize'];
    platform = json['platform'];
    checkVersionForUpdate = json['checkVersionForUpdate'];
    minAppVersion = json['minAppVersion'];
    itemTypeVisible = json['itemTypeVisible'];
    cardVisibleOnReel = json['cardVisibleOnReel'];
    orientationLock = json['orientationLock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = this.appName;
    data['appNameFontSize'] = this.appNameFontSize;
    data['platform'] = this.platform;
    data['checkVersionForUpdate'] = this.checkVersionForUpdate;
    data['minAppVersion'] = this.minAppVersion;
    data['itemTypeVisible'] = this.itemTypeVisible;
    data['cardVisibleOnReel'] = this.cardVisibleOnReel;
    data['orientationLock'] = this.orientationLock;
    return data;
  }
}

class AppStrings {
  String? whatsAppHelp;
  String? newVersionLink;
  String? userWhatsAppBaseUrl;
  String? userDynamicMsg;
  String? searchPlaceholder;
  String? propertyChatSuffix;

  AppStrings({
    this.whatsAppHelp,
    this.newVersionLink,
    this.userWhatsAppBaseUrl,
    this.userDynamicMsg,
    this.searchPlaceholder,
    this.propertyChatSuffix,
  });

  AppStrings.fromJson(Map<String, dynamic> json) {
    whatsAppHelp = json['whatsAppHelp'];
    newVersionLink = json['newVersionLink'];
    userWhatsAppBaseUrl = json['userWhatsAppBaseUrl'];
    userDynamicMsg = json['userDynamicMsg'];
    searchPlaceholder = json['searchPlaceholder'];
    propertyChatSuffix = json['propertyChatSuffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whatsAppHelp'] = this.whatsAppHelp;
    data['newVersionLink'] = this.newVersionLink;
    data['userWhatsAppBaseUrl'] = this.userWhatsAppBaseUrl;
    data['userDynamicMsg'] = this.userDynamicMsg;
    data['searchPlaceholder'] = this.searchPlaceholder;
    data['propertyChatSuffix'] = this.propertyChatSuffix;
    return data;
  }
}

class Api {
  String? androidUrl;
  String? commentUrl;
  String? webUrl;
  String? baseUrl;
  User? user;

  Api({this.androidUrl, this.commentUrl, this.webUrl, this.baseUrl, this.user});

  Api.fromJson(Map<String, dynamic> json) {
    androidUrl = json['androidUrl'];
    commentUrl = json['comment_url'];
    webUrl = json['webUrl'];
    baseUrl = json['baseUrl'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['androidUrl'] = this.androidUrl;
    data['comment_url'] = this.commentUrl;
    data['webUrl'] = this.webUrl;
    data['baseUrl'] = this.baseUrl;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? getAllShops;
  String? getShopsByCategory;
  String? getShopsByItem;
  String? getRelatedShops;
  String? getAllCategories;
  String? getShopsDetailsById;
  String? getShopsCatItems;
  String? getServicesByCategory;
  String? getServicesDetailsById;
  String? getPropertiesByCategoryId;
  String? getPropertyByNo;
  String? getPropertyByID;
  String? getAllReels;
  String? getUserArea;
  String? shopAltImage;
  String? privacyPolicy;

  User({
    this.getAllShops,
    this.getShopsByCategory,
    this.getShopsByItem,
    this.getRelatedShops,
    this.getAllCategories,
    this.getShopsDetailsById,
    this.getShopsCatItems,
    this.getServicesByCategory,
    this.getServicesDetailsById,
    this.getPropertiesByCategoryId,
    this.getPropertyByNo,
    this.getPropertyByID,
    this.getAllReels,
    this.getUserArea,
    this.shopAltImage,
    this.privacyPolicy,
  });

  User.fromJson(Map<String, dynamic> json) {
    getAllShops = json['getAllShops'];
    getShopsByCategory = json['getShopsByCategory'];
    getShopsByItem = json['getShopsByItem'];
    getRelatedShops = json['getRelatedShops'];
    getAllCategories = json['getAllCategories'];
    getShopsDetailsById = json['getShopsDetailsById'];
    getShopsCatItems = json['getShopsCatItems'];
    getServicesByCategory = json['getServicesByCategory'];
    getServicesDetailsById = json['getServicesDetailsById'];
    getPropertiesByCategoryId = json['getPropertiesByCategoryId'];
    getPropertyByNo = json['getPropertyByNo'];
    getPropertyByID = json['getPropertyByID'];
    getAllReels = json['getAllReels'];
    getUserArea = json['getUserArea'];
    shopAltImage = json['shopAltImage'];
    privacyPolicy = json['privacyPolicy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getAllShops'] = this.getAllShops;
    data['getShopsByCategory'] = this.getShopsByCategory;
    data['getShopsByItem'] = this.getShopsByItem;
    data['getRelatedShops'] = this.getRelatedShops;
    data['getAllCategories'] = this.getAllCategories;
    data['getShopsDetailsById'] = this.getShopsDetailsById;
    data['getShopsCatItems'] = this.getShopsCatItems;
    data['getServicesByCategory'] = this.getServicesByCategory;
    data['getServicesDetailsById'] = this.getServicesDetailsById;
    data['getPropertiesByCategoryId'] = this.getPropertiesByCategoryId;
    data['getPropertyByNo'] = this.getPropertyByNo;
    data['getPropertyByID'] = this.getPropertyByID;
    data['getAllReels'] = this.getAllReels;
    data['getUserArea'] = this.getUserArea;
    data['shopAltImage'] = this.shopAltImage;
    data['privacyPolicy'] = this.privacyPolicy;
    return data;
  }
}
