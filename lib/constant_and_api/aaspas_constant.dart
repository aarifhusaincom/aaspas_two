import 'dart:ui';

class AaspasColors {
  static const Color primary = Color(0xFF732FCB); // Primary
  static const Color softAccentBg = Color(0xFFE5F3F3); // Soft accent BG
  static const Color soft2 = Color(0xFFF6EEFF); // Soft2
  static const Color white = Color(0xFFFFFFFF); // White
  static const Color black = Color(0xFF000000); // Black
  static const Color green = Color(0xFF0B8F00); // Green
  static const Color textDeactivated = Color(0xFFAAAAAA); // Text Deactivated
  static const Color deactivatedDiv = Color(0xFFE6E6E6); // Deactivated Div
  static const Color red = Color(0xFFA90000); // White
  static const Color textHalfBlack = Color(0x88000000); // 50% Black
  static const Color grayBorder = Color(
    0xFFD9D9D9,
  ); // very light border shade of black
  static const Color itemChipBg = Color(0x88FAFAFA); // Item Chip BG
  static const Color categoryChipBg = Color(0x88FAFAFA); // Category Chip BG
  static const Color weekLetterBg = Color(
    0xFFE3CCFF,
  ); // Week Letter Bg at Shop Details
}

class AaspasStrings {
  static String wizardUrl = "https://aaspas-json.web.app/androidv4.json";
  static String search = "Search";
  static String shopCategories = "Shop Categories";
  static String workerCategories = "Worker Categories";
  static String propertyCategories = "Property Categories";
  static String relatedSearch = "Related Search";
  static String details = "Details";
  static String help = "Help";
  static String khajranaIndore = "Khajrana, Indore";
  static String trendingCategories = "Trending Categories";
  static String shopListSliver = "Near By Shops";
  static String empty = "";
}

class AaspasImages {
  static String reelPlaceholder = "assets/images/reelPlaceholder.png";
  static String shopPlaceholder = "assets/images/shopPlaceholder.png";
  static String servicesPlaceholder = "assets/images/serviceplaceholder.png";
  static String videoPlaceholder = "assets/images/videoBg.png";
  static String threeDLocation = "assets/images/3_D_location Image.png";

  // Cards Images on HomePage
  static String shops = "assets/images/category_type_cards/Shops.png";
  static String serviceProvider =
      "assets/images/category_type_cards/Service Provider.png";
  static String property = "assets/images/category_type_cards/Property.png";
}

class AaspasIcons {
  static String verifiedWhite = "assets/icons/verified_white.svg";
  static String verified = "assets/icons/verified.svg";
  static String viewWhite = "assets/icons/view_white.svg";
  static String direction = "assets/icons/direction.svg";
  static String mapIcon = "assets/icons/map_icon.svg";
  static String whatsapp1 = "assets/icons/whatsapp1.svg";
  static String closeRelated = "assets/icons/close_icon.svg";
  static String shareShop = "assets/icons/share_shop.svg";
  static String whatsappWhite = "assets/icons/whatsapp_white.svg";
  static String call = "assets/icons/call.svg";
  static String directionShopDetails =
      "assets/icons/direction_shop_details.svg";
}

class AaspasLottie {
  static String videoWave = "assets/lottie/video_wave_animation.json";
  static String offer = "assets/lottie/offer.json";
  static String personInSuits = "assets/lottie/loaders/personInSuits.json";
  static String mapicon3d = "assets/lottie/loaders/mapicon3d.json";
  static String shopAnimation = "assets/lottie/loaders/shopAnimation.json";
  static String reelsAnimation = "assets/lottie/loaders/reelsAnimation.json";
  static String infiniteWithBall =
      "assets/lottie/loaders/infiniteWithBall.json";
  static String sidemapsidelist =
      "assets/lottie/loaders/sidemapsidelist.json"; // side map side list in primary color
}

class AaspasNumber {
  static int maxImagesInCache = 2000; //2000 in production
  static int maxVideoInCache = 5; //10 in production
  static int maxMBInCache = 300; //300 MB in production
  ////
}

class AaspasLocator {
  static String lat = "0.00";
  static String long = "0.00";
  static bool locationService = false;
}

class AaspasPageData {
  static int page = 1;
  static int pageSize = 30;
}

class AaspasReels {
  static List reelsList = [];
}

class AaspasWizard {
  //// generalInfo
  static String appName = "AasPas";
  static int appNameFontSize = 28;
  static String platform = "android";
  static bool checkVersionForUpdate = false;
  static String minAppVersion = "4.0.2";
  static bool itemTypeVisible = true;
  static bool cardVisibleOnReel = true;
  static bool orientationLock = true;

  //// appStrings
  static String whatsAppHelp =
      "https://api.whatsapp.com/send?phone=918884446009&text=_*Aaspas+help*_";
  static String newVersionLink =
      "https://play.google.com/store/apps/details?id=com.aaspas.app";
  static String userWhatsAppBaseUrl = "https://api.whatsapp.com/send?phone=";
  static String userDynamicMsg = "&text=_*Aaspas+hello*_";
  static String searchPlaceholder =
      "Search for Mobile shop, Bakery, Electrician";

  static String propertyChatSuffix =
      "यह जानकारी Aaspas ऐप से मिली है। मुझे इसके बारे में जानना है";

  //// api user
  static String androidUrl = "";
  static String webUrl = "";
  static String baseUrl = "";

  //// api shops
  static String getAllShops = "user/getAllShops";
  static String getShopsByCategory = "user/getShopsByCategory";
  static String getShopsByItem = "user/getShopsByItem";
  static String getRelatedShops = "user/getRelatedShops";
  static String getShopsDetailsById = "user/getShopsDetailsById";
  static String getShopsCatItems = "user/getShopsCatItems";
  static String getAllCategories = "user/getCategory";

  //// Service
  static String getServicesByCategory = "user/getServicesByCategory";
  static String getServicesDetailsById = "user/getServicesDetailsById";

  //// Property
  static String getPropertiesByCategoryId = "prop/getPropertiesByCategoryId";
  static String getPropertyByNo = "prop/getPropertyByNo";
  static String getPropertyByID = "prop/getPropertyByID";

  //// api reels
  static String getAllReels = "user/getAllReels";

  //// user area
  static String getUserArea = "user/getUserArea";

  //// others
  static String shopAltImage =
      "https://raw.githubusercontent.com/aarifhusainwork/aaspas-storage-assets/refs/heads/main/AppWizard/AltImages/ShopAltImage.png";
  static String privacyPolicy = "https://aaspas-privacypolicy.aaspas.app/";
}
