import 'dart:convert';

import 'package:aaspas/model/property_details_model.dart';
import 'package:aaspas/widgets/image_slider/image_slider.dart';
import 'package:aaspas/widgets/property/property_list_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant_and_api/aaspas_constant.dart';
import '../../widgets/app_and_search_bar/appbar_only_back.dart';
import '../../../widgets/buttons/custom_button.dart';

import '../../functions/location/LocationSetterAaspas.dart';
import '../../widgets/cat_type_and_cards/label_card.dart';

class PropertyDetailsPage extends StatefulWidget {
  const PropertyDetailsPage({
    super.key,
    // this.propertyId = '6832ba660061f42441adc081',
  });
  // final String propertyId;
  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  //------for same page refresh----- starts //
  final ScrollController _scrollController = ScrollController();
  late String currentPropertyId;
  late String propertyCategoryId;

  /// load new property method
  void loadNewProperty(String newPropertyId) {
    if (newPropertyId == currentPropertyId) return;

    currentPropertyId = newPropertyId;
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    dataLoaded = false;
    setState(() {});
    getPropertyByID();
    // getPropertyByID().then((_) {
    //   _scrollController.animateTo(
    //     0,
    //     duration: const Duration(milliseconds: 400),
    //     curve: Curves.easeOut,
    //   );
    // });
  }

  //------for same page refresh----- ends //
  bool dataLoaded = false;

  List<dynamic> newImageLinks = [];
  /////////////////////////////
  bool containsMap(List list) {
    return list.any((element) => element is Map);
  }

  //////////////////////////////
  PropertyDetailsItems item = PropertyDetailsItems();
  Future<void> getPropertyByID() async {
    final String paramString = '?id=$currentPropertyId';
    final url =
        '${AaspasWizard.baseUrl}${AaspasWizard.getPropertyByID}$paramString';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      item = PropertyDetailsItems.fromJson(jsonData["items"][0]);
      if (item.images != null) {
        cacheImageUrls(item.images!);
      }
      final images = item.images ?? [];
      if (images.isEmpty) {
        newImageLinks = [];
        setState(() {
          LocationSetterAaspas.getLocation();
          // print(dataLoaded);
          dataLoaded = true;
          // print(dataLoaded);
        });
      } else if (containsMap(images)) {
        newImageLinks = [];
        setState(() {
          LocationSetterAaspas.getLocation();
          // print(dataLoaded);
          dataLoaded = true;
          // print(dataLoaded);
        });
      } else {
        newImageLinks = [];
        newImageLinks = images;
        setState(() {
          LocationSetterAaspas.getLocation();
          // print(dataLoaded);
          dataLoaded = true;
          // print(dataLoaded);
        });
      }
      // dataLoaded = true;
      // setState(() {});
    }
  }

  /////////////-----getShareText start ////////////

  //   String getShareText2() {
  //     return '''
  // 🏠 *$title*
  //
  // 📍 $area, $city - $pinCode
  //
  // 💰 Price: ₹${_formatPrice(actualPrice)}
  // 📐 Area: $totalArea sq.ft
  // ☎️ Owner: $ownerName (${phoneNo.isNotEmpty ? phoneNo : "N/A"})
  //
  // 📝 $description
  //
  // Aaspas Property Link:
  // https://aaspas.app/property?id=${widget.propertyId}
  // ''';
  //   }

  String getShareText() {
    return '''💸 *Price - ₹ ${_formatPrice(item.actualPrice ?? 1)}*
📐 *${item.totalArea} sq Feet*
( ₹ ${(item.actualPrice! / item.totalArea!).toStringAsFixed(0)} per sq Feet )

📍 ${item.area!} - ${item.city}
🏠 ${item.description ?? ""}
*👤 *${item.ownerName}*
*📞 *${item.phoneNo}*
        
*Property Code - 123*''';
  }

  // String getShareText() {
  //   return '💸 *Price - ₹ ${_formatPrice(actualPrice)}*\n'
  //       '📐 *$totalArea sq Feet*\n'
  //       '( ₹ ${(actualPrice / totalArea).toStringAsFixed(0)} per sq Feet )\n\n'
  //       '📍 $area - $city\n'
  //       '🏠 $description \n\n'
  //       '*👤 *$ownerName*\n'
  //       '*📞 *$phoneNo*\n'
  //       '\n\n'
  //       '*Property Code- 123*\n\n';
  // }
  /////////////-----getShareText end ////////////

  String _formatPrice(int price) {
    if (price >= 10000000) {
      double cr = price / 10000000;
      return '${cr.toStringAsFixed(cr.truncateToDouble() == cr ? 0 : 2)} Cr';
    } else if (price >= 100000) {
      double lakh = price / 100000;
      return '${lakh.toStringAsFixed(lakh.truncateToDouble() == lakh ? 0 : 2)} Lakh';
    } else {
      return price.toString();
    }
  }

  @override
  initState() {
    super.initState();
    // currentPropertyId = widget.propertyId;
    // getPropertyByID();
  }

  dynamic data;
  String? sid;
  @override
  void didChangeDependencies() {
    LocationSetterAaspas.getLocation();
    print("//////// didChangeDependencies called in Property details");
    if (data == null) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        data = args;
        sid = data?['sid'];
        currentPropertyId = sid!;
        getPropertyByID();
      }
    }
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

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
    print('//////////////////// Property Details Build Method');
    print(newImageLinks);
    if (!dataLoaded) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppbarOnlyBack(title: "Property Details"),
      backgroundColor: AaspasColors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 10,
                runSpacing: 20,
                children: [
                  ////// ImageSlider
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
                        if (item.videoUrl != '' && item.videoUrl != null)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/single_video_players',
                                  arguments: {'video': item.videoUrl},
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
                  //////// All Details After Slider
                  Container(
                    // color: Colors.purple,
                    constraints: BoxConstraints(
                      maxWidth:
                          orientation == Orientation.portrait
                              ? (currentSize.width - 35)
                              : (currentSize.width - 350),
                    ),
                    child: Column(
                      spacing: 10,
                      children: [
                        // Property Name
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          // color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  // "1 BHK House 2 manjil 1 BHK House 2 manjil",
                                  item.title ?? "",
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
                            ],
                          ),
                        ),
                        // // SqFeet and Price
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),

                          // color: Colors.lightGreenAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                spacing: 14,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // 6000 /ft2

                                  // Price
                                  Text(
                                    "₹ ${_formatPrice(item.actualPrice ?? 1)}",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: AaspasColors.primary,
                                      ),
                                    ),
                                  ),
                                  //conditional price/sqft
                                  if (item.categoryId !=
                                      "67a10bc020db3d33ffa8928e")
                                    LabelCard(
                                      decoration: BoxDecoration(
                                        color: AaspasColors.soft2,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      title:
                                          "₹ ${(item.actualPrice! / item.totalArea!).toStringAsFixed(0)} /sqft",
                                      fontSize: 14,
                                      horizontalPadding: 10,
                                      color: AaspasColors.primary,
                                      // bgColor: AaspasColors.soft2,
                                      // spacing: 10,
                                      showIcon: false,
                                      // iconPath: AaspasIcons.shareShop,
                                      // iconSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                ],
                              ),
                              Text(
                                // "1200 sq Feet",
                                "Size ${item.totalArea} sqFt",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AaspasColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          // color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              LabelCard(
                                decoration: BoxDecoration(
                                  color: AaspasColors.soft2,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                title: item.itemName ?? "N/A",
                                fontSize: 15,
                                horizontalPadding: 10,
                                color: AaspasColors.black,
                                // bgColor: AaspasColors.soft2,
                                spacing: 0,
                                showIcon: false,
                                iconSize: 0,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        // // // Area , Copy , Share
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),

                          // color: Colors.lightGreenAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              // LabelCard(
                              //   decoration: BoxDecoration(
                              //     color: AaspasColors.soft2,
                              //     borderRadius: BorderRadius.circular(4),
                              //   ),
                              //   title: item.itemName ?? "N/A",
                              //   fontSize: 15,
                              //   horizontalPadding: 10,
                              //   color: AaspasColors.black,
                              //   // bgColor: AaspasColors.soft2,
                              //   spacing: 0,
                              //   showIcon: false,
                              //   iconSize: 0,
                              //   fontWeight: FontWeight.w600,
                              // ),
                              LabelCard(
                                decoration: BoxDecoration(
                                  color: AaspasColors.soft2,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                title: item.area!,
                                fontSize: 15,
                                horizontalPadding: 10,
                                color: AaspasColors.black,
                                // bgColor: AaspasColors.soft2,
                                spacing: 0,
                                showIcon: false,
                                iconSize: 0,
                                fontWeight: FontWeight.w600,
                              ),

                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  spacing: 22,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final text = getShareText();
                                        await Clipboard.setData(
                                          ClipboardData(text: text),
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Property details copied to clipboard",
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.copy_all_outlined,
                                        size: 25,
                                        color: AaspasColors.primary,
                                      ),
                                    ),
                                    LabelCard(
                                      onTap: () {
                                        Share.share(getShareText());
                                      },
                                      constraints: BoxConstraints(
                                        minWidth: 100,
                                        maxWidth: 100,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AaspasColors.white,
                                        borderRadius: BorderRadius.circular(4),
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
                              ),
                            ],
                          ),
                        ),
                        // // Property Description
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            item.description ?? "",
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
                        // // call WhatsApp
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomButton(
                                onPressed: () async {
                                  // print("Call Clicked");
                                  final Uri dialUri = Uri(
                                    scheme: 'tel',
                                    path: item.phoneNo!.toString(),
                                  );
                                  if (await canLaunchUrl(dialUri)) {
                                    await launchUrl(dialUri);
                                  } else {
                                    // Handle error
                                    print("Could not launch dialer");
                                  }
                                },
                                textColor: AaspasColors.primary,
                                constraints: BoxConstraints(minWidth: 120),
                                svgPicture: SvgPicture.asset(AaspasIcons.call),
                                text: "Call",
                                decoration: BoxDecoration(
                                  color: AaspasColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AaspasColors.primary,
                                    width: 1,
                                  ),
                                ),
                              ),
                              CustomButton(
                                spacing: 4,
                                onPressed: () async {
                                  // print("WhatsApp Clicked");
                                  var url =
                                      'https://api.whatsapp.com/send?phone=91${item.phoneNo}&text=${Uri.encodeComponent(item.description ?? "")}%0A%0A_*${Uri.encodeComponent(AaspasWizard.propertyChatSuffix)}*_';
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
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // // Related Commercial Properties near by
                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   // color: Colors.purple,
                        //   // height: 40,
                        //   width: double.infinity,
                        //   child: Text(
                        //     "Related Commercial Properties near by",
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
                  ),
                ],
              ),
            ),
          ),
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
                  "Related Properties Nearby",
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
          PropertyListSliver(
            propertyId: currentPropertyId,
            propertyCategoryId: item.categoryId,
            onTapPropertyCard: loadNewProperty,
          ),
        ],
      ),
    );
  }
}
