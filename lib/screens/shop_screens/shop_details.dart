import 'dart:convert';

import 'package:aaspas/functions/location/LocationSetterAaspas.dart';
import 'package:aaspas/widgets/image_slider/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant_and_api/aaspas_constant.dart';
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
  void loadNewShop(String newShopId) {
    if (newShopId == currentShopId) return;

    currentShopId = newShopId;
    print("//////////////////////////// load new method");
    print(currentShopId);
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    dataLoaded = false;
    setState(() {});
    fetchShopDetailsById();
    getShopsCatItems();
  }

  //------for same page refresh----- ends //
  ///////////////////////////////////////////////////////////

  bool noDataFoundForCatsItems = false;
  bool noDataFound = false;
  bool isShopOpenNow = false;

  bool dataLoaded = false;

  //////////////////////////////////////////////////

  List featuredCategoryDetails = [];
  List othersCategories = [];
  List featuredItems = [];
  List otherItems = [];
  Future<void> getShopsCatItems() async {
    print("///////////////// getShopsCatItems() called");
    /////////////////////////////////////
    final String paramString = '?id=$currentShopId';
    final url = '${AaspasApi.baseUrl}${AaspasApi.getShopsCatItems}$paramString';
    /////////////////////////////////////

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      featuredItems = jsonData['items'][0]['featuredItems'] ?? [];
      otherItems = jsonData['items'][0]['otherItems'] ?? [];

      featuredCategoryDetails =
          jsonData['category'][0]['featuredCategoryDetails'] ?? [];
      othersCategories = jsonData['category'][0]['otherCategoryDetails'] ?? [];
      print("//////////////////////////// featuredCategories");
      print(featuredCategories);
      print(othersCategories);
      print(featuredItems);
      print(otherItems);
      print(openTime);
      setState(() {});
    }
  }

  //////////////////////////////////////////////////
  String video = '';

  List shopImages = [];
  List<String> newImageLinks = [];
  List workingDays = [];
  List<dynamic> featuredCategories = [];
  String shopName = "";
  String address = "";
  double lat = 0;
  double long = 0;
  String area = "";
  String phoneNo = "";
  String openTime = "";
  String closeTime = "";
  int pinCode = 0;
  int shopNo = 0;
  int showPhoneNumber = 0;
  int verified = 0;
  int showItemType = 0;
  int active = 0;
  double distanceKm = 0;
  Future<void> fetchShopDetailsById() async {
    print("///////////////// fetchShopDetailsById() called");
    /////////////////////////////////////
    final String paramString =
        '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&id=$currentShopId';
    final url =
        '${AaspasApi.baseUrl}${AaspasApi.getShopsDetailsById}$paramString';
    /////////////////////////////////////

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // print(jsonData);
      shopImages = jsonData['items'][0]['shopImages'] ?? [];
      // print("///////////////////////////////////////////print 1");
      // print(shopImages);
      shopName = jsonData['items'][0]['shopName'].toString();
      // print(shopName);
      address = jsonData['items'][0]['address'].toString();
      lat = jsonData['items'][0]['location']['coordinates'][1];
      long = jsonData['items'][0]['location']['coordinates'][0];
      area = jsonData['items'][0]['area'].toString();
      // TODO: Handle video. and remove the default link
      video =
          jsonData['items'][0]['video'] ??
          'https://github.com/aarifhusainwork/aaspas-storage-assets/raw/refs/heads/main/IndoreInstagram/other_reels/reels/1.mp4';
      phoneNo =
          (jsonData['items'][0]['phoneNo'] == null)
              ? '8884446009'
              : jsonData['items'][0]['phoneNo'].toString();
      openTime = jsonData['items'][0]['openTime'].toString();
      closeTime = jsonData['items'][0]['closeTime'].toString();
      pinCode = jsonData['items'][0]['pincode'];
      shopNo = jsonData['items'][0]['shopNo'];
      showPhoneNumber = jsonData['items'][0]['showPhoneNumber'];
      verified = jsonData['items'][0]['verified'];
      showItemType = jsonData['items'][0]['showItemType'];
      active = jsonData['items'][0]['active'] ?? 0;
      distanceKm = jsonData['items'][0]['distanceKm'];
      workingDays = jsonData['items'][0]['workingDays'] ?? [];
      featuredCategories = jsonData['items'][0]['featuredCategories'] ?? [];

      print("///////////////////////////////////////////All shop Deails");
      // print(shopImages.isEmpty);
      // print(shopName);
      // print(address);
      // print(lat);
      // print(long);
      // print(area);
      // print(video);
      // print(phoneNo);
      // print(openTime);
      // print(closeTime);
      // print(pinCode);
      // print(shopNo);
      // print(showPhoneNumber);
      // print(verified);
      // print(showItemType);
      // print(active);
      // print(distanceKm);
      // print(workingDays.join(","));
      // print(featuredCategories.join(","));

      if (shopImages.isEmpty) {
        newImageLinks = [];
        setState(() {
          LocationSetterAaspas.getLocation();
          // print(dataLoaded);
          dataLoaded = true;
          // print(dataLoaded);
        });
      } else {
        newImageLinks = List.generate(
          shopImages.length,
          // TODO: null exception chacha chai response does not have url key
          (index) => shopImages[index]['url'] ?? AaspasImages.shopAltImage,
        );
        print("///////////////////////////////////////////newImageLinks");
        // print(newImageLinks.join(","));
        setState(() {
          LocationSetterAaspas.getLocation();
          // print(dataLoaded);
          dataLoaded = true;
          // print(dataLoaded);
        });
      }
    }
  }

  // @override
  // void initState() {
  //   print("/////////////// init called");
  //   super.initState();
  // }

  dynamic data;
  String? sid;
  @override
  void didChangeDependencies() {
    LocationSetterAaspas();
    print("/////////////// didChangeDependencies called");
    if (data == null) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        data = args;
        sid = data?['sid'];
        currentShopId = sid!;
        fetchShopDetailsById().then((_) {
          isShopOpenNow = isShopOpen(
            openTimeStr: openTime,
            closeTimeStr: closeTime,
          );
        });
        getShopsCatItems();
      }
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  /////////////////////////////////////////////////////
  String cleanTimeString(String input) {
    print("///////////////////////////////////// clean Time called");
    print(input);
    return input
        .replaceAll('\u202F', ' ') // narrow no-break space
        .replaceAll('\u00A0', ' ') // regular no-break space
        .replaceAll(RegExp(r'\s+'), ' ') // normalize multiple spaces
        .trim();
  }

  bool isShopOpen({required String openTimeStr, required String closeTimeStr}) {
    print("///////////////////////////////////// isShopOpen called");
    print(openTimeStr);
    print(closeTimeStr);
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
      'https://www.google.com/maps/search/?api=1&query=$lat,$long',
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
  bool isTodayOff(List<String> workingDays) {
    return !workingDays.contains(today());
  }

  ///------- isTodayOff() End-------///
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final currentSize = MediaQuery.of(context).size;
    final bool isMobile = currentSize.width < 600;
    final bool isTablet = currentSize.width >= 600 && currentSize.width < 1024;
    if (!dataLoaded) {
      return Scaffold(
        body: Center(child: Lottie.asset(AaspasLottie.videoWave)),
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
                      // Container(
                      //   constraints: BoxConstraints(
                      //     maxWidth:
                      //         orientation == Orientation.portrait
                      //             ? (currentSize.width - 35)
                      //             : 300,
                      //     maxHeight:
                      //         orientation == Orientation.portrait
                      //             ? (currentSize.width - 35)
                      //             : 300,
                      //   ),
                      //   clipBehavior: Clip.hardEdge,
                      //   decoration: BoxDecoration(
                      //     color: Colors.purple,
                      //     borderRadius: BorderRadius.circular(16),
                      //   ),
                      // ),
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
                            if (video != '')
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/single_video_player',
                                      arguments: {'video': video},
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
                                      shopName,
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
                                  if (verified == 1)
                                    LabelCard(
                                      constraints: BoxConstraints(
                                        minWidth: 120,
                                        maxWidth: 120,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AaspasColors.soft2,
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
                                address,
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
                                    title: area,
                                    fontSize: 15,
                                    horizontalPadding: 10,
                                    color: AaspasColors.black,
                                    bgColor: AaspasColors.soft2,
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
                                        SizedBox(
                                          width: 65,
                                          child: LabelCard(
                                            decoration: BoxDecoration(
                                              color: AaspasColors.soft2,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            // TODO: Add Shop Type
                                            title: "Retail",
                                            fontSize: 14,
                                            horizontalPadding: 10,
                                            color: AaspasColors.primary,
                                            bgColor: AaspasColors.soft2,
                                            spacing: 10,
                                            showIcon: false,
                                            iconSize: 15,
                                            fontWeight: FontWeight.w700,
                                            widthLabel: 100,
                                          ),
                                        ),
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
                                            bgColor: AaspasColors.soft2,
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
                                        "Direction ${distanceKm.toStringAsFixed(2)} KM",
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
                                                "$openTime - $closeTime",
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
                                              status: workingDays.contains(
                                                'Monday',
                                              ),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "T",
                                              status: workingDays.contains(
                                                'Tuesday',
                                              ),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "W",
                                              status: workingDays.contains(
                                                'Wednesday',
                                              ),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "T",
                                              status: workingDays.contains(
                                                'Thursday',
                                              ),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "F",
                                              status: workingDays.contains(
                                                'Friday',
                                              ),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "S",
                                              status: workingDays.contains(
                                                'Saturday',
                                              ),
                                            ),
                                            WeekDayLetter(
                                              weekLetter: "S",
                                              status: workingDays.contains(
                                                'Sunday',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (showPhoneNumber == 1)
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
                                                  'https://api.whatsapp.com/send?phone=91$phoneNo&text=_*Aaspas+Hello*_';
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
                                                path: phoneNo,
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
                      // Shop Description
                      SizedBox(
                        width: double.infinity,
                        // TODO: Remove this line and replace with the actual description
                        child: Text(
                          " Ye API me nhi aa rha h गरीब नवाज केटरर्स | गोश्त कोरमा, बटर चिकन, माँडे, ब्रियानी, सीक कबाब, चिकन फ्राय | शादी व पार्टी मे सभी प्रकार का खाना बनाने का ऑर्डर लिया जाता है |",
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
                          if (featuredItems.isNotEmpty && showItemType == 1)
                            Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.purple,
                              // height: 40,
                              width: double.infinity,
                              child: Text(
                                "All items/services of $shopName",
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
                          if (featuredItems.isNotEmpty && showItemType == 1)
                            SizedBox(
                              width: double.infinity,
                              child:
                                  featuredItems.isEmpty
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
                                          (featuredItems.length +
                                              otherItems.length),
                                          (index) {
                                            if (index < featuredItems.length) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/cat_item_wise',
                                                    arguments: {
                                                      'id':
                                                          featuredItems[index]['_id'],
                                                      'name':
                                                          featuredItems[index]['item_name'],
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
                                                      featuredItems[index]['item_name'] ??
                                                      '',
                                                ),
                                              );
                                            } else {
                                              final adjustedIndex =
                                                  index - featuredItems.length;
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/cat_item_wise',
                                                    arguments: {
                                                      'id':
                                                          otherItems[adjustedIndex]['_id'],
                                                      'name':
                                                          otherItems[adjustedIndex]['item_name'],
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
                                                      otherItems[adjustedIndex]['item_name'] ??
                                                      '',
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                            ),
                          //Category Chips
                          if (featuredItems.isNotEmpty && showItemType == 1)
                            SizedBox(
                              width: double.infinity,
                              child:
                                  featuredItems.isEmpty
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
                                          (featuredCategoryDetails.length +
                                              othersCategories.length),
                                          (index) {
                                            if (index <
                                                featuredCategoryDetails
                                                    .length) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/cat_item_wise',
                                                    arguments: {
                                                      'id':
                                                          featuredCategoryDetails[index]['_id'],
                                                      'name':
                                                          featuredCategoryDetails[index]['category_name'],
                                                      "imageUrl":
                                                          featuredCategoryDetails[index]['category_image'],
                                                      'categoryType': 'shops',
                                                      'cardType': 'category',
                                                    },
                                                  );
                                                },

                                                child: CategoryChip(
                                                  catName:
                                                      featuredCategoryDetails[index]['category_name'] ??
                                                      '',
                                                  imageUrl:
                                                      featuredCategoryDetails[index]['category_image'] ??
                                                      '',
                                                ),
                                              );
                                            } else {
                                              final adjustedIndex =
                                                  index -
                                                  featuredCategoryDetails
                                                      .length;
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/cat_item_wise',
                                                    arguments: {
                                                      'id':
                                                          othersCategories[adjustedIndex]['_id'],
                                                      'name':
                                                          othersCategories[adjustedIndex]['category_name'],
                                                      "imageUrl":
                                                          othersCategories[adjustedIndex]['category_image'],
                                                      'categoryType': 'shops',
                                                      'cardType': 'category',
                                                    },
                                                  );
                                                },
                                                child: CategoryChip(
                                                  catName:
                                                      othersCategories[adjustedIndex]['category_name'] ??
                                                      '',
                                                  imageUrl:
                                                      othersCategories[adjustedIndex]['category_image'] ??
                                                      '',
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                            ),
                          // Heading Related Shop Near By
                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   // color: Colors.purple,
                          //   // height: 40,
                          //   width: double.infinity,
                          //   child: Text(
                          //     "Related Shop Near By",
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: GoogleFonts.roboto(
                          //       textStyle: TextStyle(
                          //         fontSize: 17,
                          //         fontWeight: FontWeight.w700,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
