import 'dart:convert';

import 'package:aaspas/functions/location/LocationSetterAaspas.dart';
import 'package:aaspas/widgets/image_slider/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant_and_api/aaspas_constant.dart';
import '../../model/shop_cats_items_model.dart';
import '../../model/shop_details_model.dart';
import '../../widgets/app_and_search_bar/appbar_only_back.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/chips/category_chip.dart';
import '../../../widgets/week_days/week_day_letter.dart';

import '../../widgets/chips/item_chip.dart';
import '../../widgets/cat_type_and_cards/label_card.dart';

import '../../widgets/shops/shop_list_sliver.dart';

class ShopDetailsPage extends StatefulWidget {
  const ShopDetailsPage({super.key});
  // final String id;
  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  //------for same page refresh----- starts //
  final ScrollController _scrollController = ScrollController();
  late String currentShopId;

  /// load new Shop method
  bool _isLoadingNewShop =
      false; // Use a specific flag for loading new shop via loadNewShop

  void loadNewShop(String newShopId) async {
    // Make it async
    if (newShopId == currentShopId && !_isLoadingNewShop)
      return; // Prevent re-entry if already loading new
    if (_isLoadingNewShop) return; // Don't allow concurrent loads

    currentShopId = newShopId;
    _isLoadingNewShop = true; // Set loading flag
    print("//////////////////////////// load new shop: $currentShopId");

    // Show loading state immediately for the page content
    // This will replace the current shop details with a loading indicator
    setState(() {
      dataLoaded = false; // This flag controls the main loading Lottie
    });

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );

    try {
      // Clear old data *before* fetching new data
      // _clearShopData();

      // Fetch both sets of data. Consider using Future.wait if they can run in parallel
      // and don't depend on each other for initial request parameters.
      await fetchShopDetailsById(); // This will update its own part of the state and call setState
      await getShopCatsItems(); // This will update its own part of the state and call setState

      // After all data is fetched and individual setStates have run,
      // update the main loading flag for the page.
      isShopOpenNow = isShopOpen(
        // Recalculate this
        openTimeStr:
            firstShopItem.openTime ??
            "", // Ensure openTime/closeTime are not null
        closeTimeStr: firstShopItem.closeTime ?? "",
      );
    } catch (e) {
      print("Error loading new shop: $e");
      // Handle error state, maybe show an error message
      noDataFound = true; // Or a specific error flag
    } finally {
      // This setState will reflect the fully loaded new shop data
      // or an error state if something went wrong.
      setState(() {
        dataLoaded =
            true; // Allow build method to show content or "noDataFound"
        _isLoadingNewShop = false; // Reset loading flag
      });
    }
  }

  //------for same page refresh----- ends //

  ///////////////////////////////////////////////////////////
  bool noDataFoundForCatsItems = false;
  bool noDataFound = false;
  bool isShopOpenNow = false;
  bool dataLoaded = false;

  // Ensure initState and didChangeDependencies also manage dataLoaded correctly
  @override
  void initState() {
    LocationSetterAaspas();
    print("/////////////// init called");
    // currentShopId is NOT initialized here, it comes from didChangeDependencies
    super.initState();
  }

  dynamic
  dataRouteArgs; // Renamed to avoid confusion with other 'data' variables
  String? initialSid;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies(); // Call super first
    LocationSetterAaspas.getLocation();
    print("/////////////// didChangeDependencies called in shop details");

    // Only fetch initial data if it hasn't been fetched yet for this instance of the page
    if (dataRouteArgs == null) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        dataRouteArgs = args;
        initialSid = dataRouteArgs?['sid'];
        if (initialSid != null) {
          // Check if it's a new ID
          currentShopId = initialSid!;
          print("ShopDetailsPage: Initial load for shop ID: $currentShopId");
          // Initial load sequence
          setState(() {
            dataLoaded = false; // Show loading indicator
            // _clearShopData(); // Clear any potential stale data
          });
          _fetchInitialData();
        } else if (initialSid == null) {
          // Handle case where sid is not provided, maybe show error or default state
          setState(() {
            dataLoaded = true; // Stop loading
            noDataFound = true; // Indicate nothing to show
          });
        }
      } else {
        // Handle case where args are not as expected
        setState(() {
          dataLoaded = true; // Stop loading
          noDataFound = true; // Indicate nothing to show
        });
      }
    }
  }
  //////////////////////////////////////////////////

  /// //////////// getShopCatsItems Start //////////////
  ShopItems items = ShopItems();
  ShopCategories categories = ShopCategories();
  Future<void> getShopCatsItems() async {
    print("///////////////// getShopsCatItems() for $currentShopId");
    final String paramString = '?id=$currentShopId';
    final url =
        '${AaspasWizard.baseUrl}${AaspasWizard.getShopsCatItems}$paramString';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      items = ShopItems.fromJson(jsonData["items"][0]);
      categories = ShopCategories.fromJson(jsonData["category"][0]);

      // print("1st name of item and cats");
      // print(items.featuredItems?[0].itemName);
      // print(items.otherItems?[0].itemName);
      // print(categories.featuredCategoryDetails?[0].categoryName);
      // print(categories.otherCategoryDetails?[0].categoryName);

      setState(() {
        // Call setState AFTER updating the variables

        noDataFoundForCatsItems =
            items.featuredItems!.isEmpty &&
            items.otherItems!.isEmpty &&
            categories.featuredCategoryDetails!.isEmpty &&
            categories.otherCategoryDetails!.isEmpty;
      });
    } else {
      print("Error fetching shop cats/items: ${response.statusCode}");
      setState(() {
        noDataFoundForCatsItems =
            true; // Indicate error or no data for this part
      });
    }
  }

  /// //////////// getShopCatsItems End //////////////

  /////////

  /// //////////// fetchShopDetailsById Starts //////////////
  List newImageLinks = [];
  List<String?> featuredCategories = [];
  ShopDetailsItems firstShopItem = ShopDetailsItems();
  Future<void> fetchShopDetailsById() async {
    print("///////////////// fetchShopDetailsById() for $currentShopId");
    // No need to clear here if _clearShopData() is called in loadNewShop

    final String paramString =
        '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&id=$currentShopId';
    final url =
        '${AaspasWizard.baseUrl}${AaspasWizard.getShopsDetailsById}$paramString';
    print("shopDetails Url");
    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      firstShopItem = ShopDetailsItems.fromJson(jsonData["items"][0]);
      print('Shop DetailsNEw shopName');
      print(firstShopItem.shopName);

      if (jsonData["items"][0].isNotEmpty) {
        // Assign new data
        // It's crucial that ShopDetailsModel.Items has all the fields you need
        // or you manually parse them from jsonData as before.
        // Assuming your ShopDetailsModel is comprehensive:

        // print("/// Shop Images List");
        // print(firstShopItem.shopImages);
        if (firstShopItem.shopImages != null) {
          cacheImageUrls(firstShopItem.shopImages!);
        }
        setState(() {
          // Update all state variables within ONE setState for this fetch
          // shopDetails = newShopDetailItems; // Replace, don't add

          featuredCategories =
              firstShopItem.featuredCategories ??
              []; // This is from shop details, distinct from getShopsCatItems()

          // shopImages = firstShopItem.shopImages ?? [];
          if (firstShopItem.shopImages!.isNotEmpty) {
            newImageLinks = List<dynamic>.from(
              firstShopItem.shopImages!,
            ); // Create a new list
          } else {
            newImageLinks = [];
          }
          noDataFound = false; // Data was found
        });
      } else {
        setState(() {
          // Handle no data found for this specific shop ID
          // _clearShopData(); // Clear everything if the new shop ID returns no data
          noDataFound = true;
        });
      }
    } else {
      print("Error fetching shop details: ${response.statusCode}");
      setState(() {
        // _clearShopData(); // Clear everything on error
        noDataFound = true; // Indicate error or no data
      });
    }
  }

  /// //////////// fetchShopDetailsById Ends //////////////

  Future<void> _fetchInitialData() async {
    try {
      await fetchShopDetailsById();
      print("firstShopItem.shopName inside _fetchInitialData()");
      print(firstShopItem.shopName);
      await getShopCatsItems();
      isShopOpenNow = isShopOpen(
        openTimeStr: firstShopItem.openTime ?? "",
        closeTimeStr: firstShopItem.closeTime ?? "",
      );
    } catch (e) {
      print("Error during initial data fetch: $e");
      noDataFound = true;
    } finally {
      setState(() {
        dataLoaded = true; // Content (or error) is ready to be shown
      });
    }
  }

  /////////////////////////////////////////////////////
  String cleanTimeString(String input) {
    // print("///////////////////////////////////// clean Time called");
    // print(input);
    return input
        .replaceAll('\u202F', ' ') // narrow no-break space
        .replaceAll('\u00A0', ' ') // regular no-break space
        .replaceAll(RegExp(r'\s+'), ' ') // normalize multiple spaces
        .trim();
  }

  bool isShopOpen({required String openTimeStr, required String closeTimeStr}) {
    if (isTodayOff(firstShopItem.workingDays!)) {
      return false;
    }
    // print("///////////////////////////////////// isShopOpen called");
    // print(openTimeStr);
    // print(closeTimeStr);
    final now = DateTime.now();
    // final format = DateFormat.jm(); // e.g., "11:00 AM"
    final format = DateFormat("hh:mm a"); // e.g., "11:00 AM"
    ////
    // print("Original openTimeStr: '$openTimeStr'");
    // print("Original closeTimeStr: '$closeTimeStr'");
    ////
    String cleanedOpenTimeStr = cleanTimeString(openTimeStr);
    String cleanedCloseTimeStr = cleanTimeString(closeTimeStr);

    // print("Cleaned openTimeStr: '$cleanedOpenTimeStr'");
    // print("Cleaned closeTimeStr: '$cleanedCloseTimeStr'");

    // Parse time strings
    DateTime openTime = format.parse(cleanedOpenTimeStr);
    DateTime closeTime = format.parse(cleanedCloseTimeStr);

    // Rebuild with today's date
    openTime = DateTime(
      now.year,
      now.month,
      now.day,
      openTime.hour,
      openTime.minute,
    );
    closeTime = DateTime(
      now.year,
      now.month,
      now.day,
      closeTime.hour,
      closeTime.minute,
    );

    // Handle closing time past midnight
    if (closeTime.isBefore(openTime)) {
      closeTime = closeTime.add(Duration(days: 1));
    }

    return now.isAfter(openTime) && now.isBefore(closeTime);
  }

  ///////////////////////////////////////////////////////////////
  // Open Google Map and redirect to that location

  void openMap() async {
    final Uri mapUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${firstShopItem.location?.coordinates?[1]},${firstShopItem.location?.coordinates?[0]}',
    );

    if (await canLaunchUrl(mapUri)) {
      await launchUrl(
        mapUri,
        mode: LaunchMode.externalApplication,
      ); // Opens in Google Maps app or browser
    } else {
      throw 'Could not launch Google Maps.';
    }
  }

  ////////////////////////////////////////////////////////////

  ///------- today() Start-------///
  String today() {
    final now = DateTime.now();
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[now.weekday - 1];
  }

  ///------- today() End-------///

  ///------- isTodayOff() Start-------///
  bool isTodayOff(List workingDays) {
    return !workingDays.contains(today());
  }

  ///------- isTodayOff() End-------///
  ///
  ///
  /// isTodayAfter Starts
  bool isTodayAfter(String dateString) {
    // Parse the input date string to DateTime
    final inputDate = DateTime.parse(dateString);

    // Get today's date without time
    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);

    // Compare
    return !todayDateOnly.isAfter(inputDate);
  }

  /// isTodayAfter ends
  /// formatDateTo_ddMMyyyy Starts
  String formatDateTo_ddMMyyyy(String dateString) {
    final date = DateTime.parse(dateString); // parses yyyy-MM-dd
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day-$month-$year';
  }

  /// formatDateTo_ddMMyyyy Ends

  /// cache shopImages Starts
  Future<void> cacheImageUrls(List<String> urls) async {
    final cacheManager = DefaultCacheManager();

    for (final url in urls) {
      try {
        // Download and cache the file
        await cacheManager.downloadFile(url);
      } catch (e) {
        print("Error caching $url: $e");
      }
    }
  }

  /// cache shopImages Ends
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final currentSize = MediaQuery.of(context).size;
    final bool isMobile = currentSize.width < 600;
    final bool isTablet = currentSize.width >= 600 && currentSize.width < 1024;
    if (!dataLoaded) {
      return Scaffold(
        body: Center(child: Lottie.asset(AaspasLottie.shopAnimation)),
      );
    }
    // if (shopData == null) {
    //   return Scaffold(body: Center(child: CircularProgressIndicator()));
    // }
    return Scaffold(
      appBar: AppbarOnlyBack(title: "Shop Details"),
      backgroundColor: AaspasColors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 10,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 10,
                    runSpacing: 20,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth:
                              orientation == Orientation.portrait
                                  ? (currentSize.width - 35)
                                  : 300,
                        ),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ImageSlider(imageLinks: newImageLinks),
                            if (firstShopItem.video != '' &&
                                firstShopItem.video != null)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/single_video_player',
                                      arguments: {
                                        'video': firstShopItem.video ?? "",
                                      },
                                    );
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Lottie.asset(
                                        AaspasLottie.videoWave,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      Icon(
                                        Icons.play_arrow_rounded,
                                        color: AaspasColors.white,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      //Shop Name and Details
                      Container(
                        constraints: BoxConstraints(
                          maxWidth:
                              orientation == Orientation.portrait
                                  ? (currentSize.width - 35)
                                  : (currentSize.width - 350),
                        ),
                        child: Column(
                          spacing: 10,
                          children: [
                            /// Offer Card for mobile
                            if (isMobile &&
                                firstShopItem.offer != '' &&
                                firstShopItem.offer != null &&
                                isTodayAfter(
                                  firstShopItem.offerExpiryDate ?? "",
                                ))
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFDFFFD0),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2,
                                    color: Color(0xFF46DD00),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 6,
                                  children: [
                                    Lottie.asset(
                                      width: 60,
                                      height: 60,
                                      AaspasLottie.offer,
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            firstShopItem.offer ?? "No offer",
                                            textAlign: TextAlign.right,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                // color: AaspasColors.red,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                "Offer expire on ${formatDateTo_ddMMyyyy(firstShopItem.offerExpiryDate ?? "")}" ??
                                                    'Expired',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: AaspasColors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Shop Name
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      firstShopItem.shopName ?? "",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AaspasColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (firstShopItem.verified == 1)
                                    LabelCard(
                                      constraints: BoxConstraints(
                                        minWidth: 120,
                                        maxWidth: 120,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            AaspasColors
                                                .white, //AaspasColors.soft2
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      title: "Verified",
                                      fontSize: 15,
                                      horizontalPadding: 10,
                                      color: AaspasColors.primary,
                                      spacing: 10,
                                      showIcon: true,
                                      iconPath: AaspasIcons.verified,
                                      iconSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                ],
                              ),
                            ),
                            //Address
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                firstShopItem.address ?? '',
                                maxLines: 5,
                                softWrap: true,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    height: 1.2,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AaspasColors.textHalfBlack,
                                  ),
                                ),
                              ),
                            ),
                            // Area , Copy , Share
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),

                              // color: Colors.lightGreenAccent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  LabelCard(
                                    decoration: BoxDecoration(
                                      color: AaspasColors.soft2,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    title: firstShopItem.area ?? "",
                                    fontSize: 15,
                                    horizontalPadding: 10,
                                    color: AaspasColors.black,
                                    // bgColor: AaspasColors.soft2,
                                    spacing: 0,
                                    showIcon: false,
                                    iconSize: 0,
                                    fontWeight: FontWeight.w600,
                                  ),

                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    spacing: 22,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.copy_all_outlined,
                                        size: 25,
                                        color: AaspasColors.primary,
                                      ),
                                      LabelCard(
                                        constraints: BoxConstraints(
                                          minWidth: 100,
                                          maxWidth: 100,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AaspasColors.white,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        title: "Share",
                                        fontSize: 15,
                                        horizontalPadding: 10,
                                        color: AaspasColors.primary,
                                        spacing: 10,
                                        showIcon: true,
                                        iconPath: AaspasIcons.shareShop,
                                        iconSize: 25,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Shop Type & Direction
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 8,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Wrap(
                                      spacing: 4,
                                      runSpacing: 6,
                                      children: [
                                        if ((firstShopItem.shopType ?? [])
                                            .contains('Retail'))
                                          SizedBox(
                                            width: 65,
                                            child: LabelCard(
                                              decoration: BoxDecoration(
                                                color: AaspasColors.soft2,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),

                                              title: "Retail",
                                              fontSize: 14,
                                              horizontalPadding: 10,
                                              color: AaspasColors.primary,
                                              // bgColor: AaspasColors.soft2,
                                              spacing: 10,
                                              showIcon: false,
                                              iconSize: 15,
                                              fontWeight: FontWeight.w700,
                                              widthLabel: 100,
                                            ),
                                          ),
                                        if ((firstShopItem.shopType ?? [])
                                            .contains('Service'))
                                          SizedBox(
                                            width: 75,
                                            child: LabelCard(
                                              decoration: BoxDecoration(
                                                color: AaspasColors.soft2,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              title: "Service",
                                              fontSize: 14,
                                              horizontalPadding: 10,
                                              color: AaspasColors.primary,
                                              // bgColor: AaspasColors.soft2,
                                              spacing: 10,
                                              showIcon: false,
                                              iconSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        if ((firstShopItem.shopType ?? [])
                                            .contains('Wholesale'))
                                          SizedBox(
                                            width: 100,
                                            child: LabelCard(
                                              decoration: BoxDecoration(
                                                color: AaspasColors.soft2,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              title: "Wholesale",
                                              fontSize: 14,
                                              horizontalPadding: 10,
                                              color: AaspasColors.primary,
                                              // bgColor: AaspasColors.soft2,
                                              spacing: 10,
                                              showIcon: false,
                                              iconSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  LabelCard(
                                    onTap: openMap,
                                    constraints: BoxConstraints(
                                      maxWidth: 170,
                                      minWidth: 170,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AaspasColors.soft2,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    title:
                                        // (shopDetails[0].distance != null)
                                        //     ? "Direction ${shopDetails[0].distance!.toStringAsFixed(2)} KM"
                                        //     : "Direction NA",
                                        "Direction ${firstShopItem.distanceKm?.toStringAsFixed(2) ?? 0} KM",
                                    fontSize: 13,
                                    horizontalPadding: 10,
                                    color: AaspasColors.black,
                                    spacing: 8,
                                    showIcon: true,
                                    iconPath: AaspasIcons.directionShopDetails,
                                    iconSize: 22,
                                    fontWeight: FontWeight.w800,
                                    widthLabel: 56,
                                  ),
                                ],
                              ),
                            ),
                            // Timing & Contacts
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    // color: Colors.red,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      spacing: 17,
                                      children: [
                                        Wrap(
                                          alignment: WrapAlignment.start,
                                          runAlignment: WrapAlignment.center,
                                          spacing: 5,
                                          children: [
                                            Container(
                                              height: 27,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 2,
                                              ),
                                              child: Text(
                                                isShopOpenNow
                                                    ? "Open"
                                                    : "Close",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        isShopOpenNow
                                                            ? AaspasColors.green
                                                            : AaspasColors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 27,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 2,
                                              ),
                                              child: Text(
                                                "${firstShopItem.openTime} - ${firstShopItem.closeTime}",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: AaspasColors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Wrap(
                                          spacing: 5,
                                          runSpacing: 5,
                                          children: [
                                            WeekDayLetter(
                                              weekLetter: "M",
                                              status: (firstShopItem
                                                          .workingDays ??
                                                      [])
                                                  .contains('Monday'),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "T",
                                              status: (firstShopItem
                                                          .workingDays ??
                                                      [])
                                                  .contains('Tuesday'),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "W",
                                              status: (firstShopItem
                                                          .workingDays ??
                                                      [])
                                                  .contains('Wednesday'),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "T",
                                              status: (firstShopItem
                                                          .workingDays ??
                                                      [])
                                                  .contains('Thursday'),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "F",
                                              status: (firstShopItem
                                                          .workingDays ??
                                                      [])
                                                  .contains('Friday'),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "S",
                                              status: (firstShopItem
                                                          .workingDays ??
                                                      [])
                                                  .contains('Saturday'),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "S",
                                              status: (firstShopItem
                                                          .workingDays ??
                                                      [])
                                                  .contains('Sunday'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (firstShopItem.showPhoneNumber == 1)
                                    SizedBox(
                                      width: 140,
                                      // color: Colors.cyan,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        spacing: 11,
                                        children: [
                                          CustomButton(
                                            onPressed: () async {
                                              // print("WhatsApp Clicked");
                                              var url =
                                                  'https://api.whatsapp.com/send?phone=91${firstShopItem.phoneNo}&text=_*Aaspas+Hello*_';
                                              // launch(url);
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              }
                                            },
                                            svgPicture: SvgPicture.asset(
                                              AaspasIcons.whatsappWhite,
                                            ),
                                            text: "WhatsApp",
                                            // color: Colors.green,
                                            decoration: BoxDecoration(
                                              color: AaspasColors.green,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          CustomButton(
                                            onPressed: () async {
                                              // print("Call Clicked");
                                              final Uri dialUri = Uri(
                                                scheme: 'tel',
                                                path:
                                                    "${firstShopItem.phoneNo}",
                                              );
                                              if (await canLaunchUrl(dialUri)) {
                                                await launchUrl(dialUri);
                                              } else {
                                                // Handle error
                                                // print("Could not launch dialer");
                                              }
                                            },
                                            textColor: AaspasColors.primary,
                                            svgPicture: SvgPicture.asset(
                                              AaspasIcons.call,
                                            ),
                                            text: "Call",
                                            decoration: BoxDecoration(
                                              color: AaspasColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: AaspasColors.primary,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Description + Column
                  Column(
                    spacing: 10,
                    children: [
                      /// Offer Card for tablet
                      if (isTablet &&
                          firstShopItem.offer != '' &&
                          firstShopItem.offer != null &&
                          isTodayAfter(firstShopItem.offerExpiryDate ?? ""))
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFDFFFD0),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Color(0xFF46DD00),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 6,
                            children: [
                              Lottie.asset(
                                width: 60,
                                height: 60,
                                AaspasLottie.offer,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "20 % off on Earbud up to 50 ₹" * 1,
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          // color: AaspasColors.red,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          "Offer expire on 26-07-2025",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AaspasColors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Shop Description
                      if (firstShopItem.description != null &&
                          firstShopItem.description != '')
                        SizedBox(
                          width: double.infinity,
                          // TODO: Remove this line and replace with the actual description
                          child: Text(
                            "${(firstShopItem.description == null && firstShopItem.description == '') ? 'No Description' : firstShopItem.description}",
                            maxLines: 5,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                height: 1.2,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AaspasColors.textHalfBlack,
                              ),
                            ),
                          ),
                        ),
                      // Items Chips + Category Chips
                      Column(
                        spacing: 16,
                        children: [
                          // All items/services of $shopName
                          if ((noDataFoundForCatsItems == false) &&
                              firstShopItem.showItemType == 1)
                            Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.purple,
                              // height: 40,
                              width: double.infinity,
                              child: Text(
                                "All items/services of ${firstShopItem.shopName}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          // Items chips
                          if ((items.featuredItems ?? []).isNotEmpty &&
                              firstShopItem.showItemType == 1)
                            SizedBox(
                              width: double.infinity,
                              child:
                                  (items.featuredItems ?? []).isEmpty
                                      ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                      : Wrap(
                                        spacing: 8, // horizontal spacing
                                        alignment: WrapAlignment.start,

                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        runSpacing: 8, // vertical spacing
                                        children: List.generate(
                                          ((items.featuredItems ?? []).length +
                                              (items.otherItems ?? []).length),
                                          (index) {
                                            if (index <
                                                (items.featuredItems ?? [])
                                                    .length) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/cat_item_wise',
                                                    arguments: {
                                                      'id':
                                                          items
                                                              .featuredItems?[index]
                                                              .sId,
                                                      'name':
                                                          items
                                                              .featuredItems?[index]
                                                              .itemName,
                                                      'categoryType': 'shops',
                                                      'cardType': 'item',
                                                    },
                                                  );
                                                },
                                                child: ItemChip(
                                                  width:
                                                      isTablet
                                                          ? 120
                                                          : isMobile
                                                          ? ((currentSize
                                                                      .width -
                                                                  56) /
                                                              3)
                                                          : (currentSize.width <
                                                              390)
                                                          ? 110
                                                          : 110,
                                                  itemName:
                                                      items
                                                          .featuredItems?[index]
                                                          .itemName ??
                                                      '',
                                                ),
                                              );
                                            } else {
                                              final adjustedIndex =
                                                  index -
                                                  (items.featuredItems ?? [])
                                                      .length;
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/cat_item_wise',
                                                    arguments: {
                                                      'id':
                                                          items
                                                              .otherItems?[adjustedIndex]
                                                              .sId,
                                                      'name':
                                                          items
                                                              .otherItems?[adjustedIndex]
                                                              .itemName,
                                                      'categoryType': 'shops',
                                                      'cardType': 'item',
                                                    },
                                                  );
                                                },
                                                // itemc
                                                child: ItemChip(
                                                  width:
                                                      isTablet
                                                          ? 120
                                                          : isMobile
                                                          ? ((currentSize
                                                                      .width -
                                                                  56) /
                                                              3)
                                                          : (currentSize.width <
                                                              390)
                                                          ? 110
                                                          : 110,
                                                  itemName:
                                                      items
                                                          .otherItems?[adjustedIndex]
                                                          .itemName ??
                                                      '',
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                            ),
                          //Category Chips
                          if ((categories.featuredCategoryDetails ?? [])
                                  .isNotEmpty &&
                              firstShopItem.showItemType == 1)
                            SizedBox(
                              width: double.infinity,
                              child:
                                  (categories.featuredCategoryDetails ?? [])
                                          .isEmpty
                                      ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                      : Wrap(
                                        spacing: 8, // horizontal spacing
                                        alignment: WrapAlignment.start,

                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        runSpacing: 8, // vertical spacing
                                        children: List.generate(
                                          ((categories.featuredCategoryDetails ??
                                                      [])
                                                  .length +
                                              (categories.otherCategoryDetails ??
                                                      [])
                                                  .length),
                                          (index) {
                                            if (index <
                                                (categories.featuredCategoryDetails ??
                                                        [])
                                                    .length) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/cat_item_wise',
                                                    arguments: {
                                                      'id':
                                                          categories
                                                              .featuredCategoryDetails?[index]
                                                              .sId,
                                                      'name':
                                                          categories
                                                              .featuredCategoryDetails?[index]
                                                              .categoryName,
                                                      "imageUrl":
                                                          categories
                                                              .featuredCategoryDetails?[index]
                                                              .categoryImage,
                                                      'categoryType': 'shops',
                                                      'cardType': 'category',
                                                    },
                                                  );
                                                },

                                                child: CategoryChip(
                                                  catName:
                                                      categories
                                                          .featuredCategoryDetails?[index]
                                                          .categoryName ??
                                                      '',
                                                  imageUrl:
                                                      (categories
                                                                  .featuredCategoryDetails?[index]
                                                                  .categoryImage ==
                                                              '')
                                                          ? AaspasWizard
                                                              .shopAltImage
                                                          : (categories
                                                                  .featuredCategoryDetails?[index]
                                                                  .categoryImage ==
                                                              null)
                                                          ? AaspasWizard
                                                              .shopAltImage
                                                          : categories
                                                              .featuredCategoryDetails?[index]
                                                              .categoryImage,
                                                ),
                                              );
                                            } else {
                                              final adjustedIndex =
                                                  index -
                                                  (categories.featuredCategoryDetails ??
                                                          [])
                                                      .length;
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/cat_item_wise',
                                                    arguments: {
                                                      'id':
                                                          categories
                                                              .otherCategoryDetails?[adjustedIndex]
                                                              .sId,
                                                      'name':
                                                          categories
                                                              .otherCategoryDetails?[adjustedIndex]
                                                              .categoryName,
                                                      "imageUrl":
                                                          categories
                                                              .otherCategoryDetails?[adjustedIndex]
                                                              .categoryImage,
                                                      'categoryType': 'shops',
                                                      'cardType': 'category',
                                                    },
                                                  );
                                                },
                                                child: CategoryChip(
                                                  catName:
                                                      categories
                                                          .otherCategoryDetails?[adjustedIndex]
                                                          .categoryName ??
                                                      '',
                                                  imageUrl:
                                                      categories
                                                          .otherCategoryDetails?[adjustedIndex]
                                                          .categoryImage ??
                                                      AaspasWizard.shopAltImage,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (featuredCategories.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 2,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.purple,
                  // height: 40,
                  width: double.infinity,
                  child: Text(
                    "Related Shop Near By",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (featuredCategories.isNotEmpty)
            ShopListSliver(
              shopId: currentShopId,
              featuredCatIds: featuredCategories,
              onTapShopCard: loadNewShop,
            ),
        ],
      ),
    );
  }
}
