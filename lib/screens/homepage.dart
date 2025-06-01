import 'dart:core';
import 'package:aaspas/widgets/shops/shop_list_sliver_nearby.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant_and_api/aaspas_constant.dart';
import '../../widgets/category_grid_view.dart';
import '../../widgets/home_app_bar.dart';

// import '../../widgets/near_by_shops_update0.dart';

// import '../../widgets/reels_slide_view.dart';
import '../../widgets/reels_slide_view_updated.dart';

import '../../widgets/three_cards_of_category_type.dart';

import '../functions/location/LocationSetterAaspas.dart';
import '../widgets/aaspas_search_bar.dart';
import '../widgets/shop_cards_builder/shop_list_sliver.dart';
import '../widgets/shops/shop_list_sliver.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isLocationFetch = false;
  // freshLocation() {
  // }

  @override
  void initState() {
    //////////////////
    LocationSetterAaspas.getLocation().then((e) {
      setState(() {
        isLocationFetch = true;
      });
    });
    /////////////////////
    // freshLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLocationFetch) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: HomeAppBar(),
        body: Center(
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [CircularProgressIndicator(), Text("Loading")],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: CustomScrollView(
        slivers: [
          ReelsSlideView(),
          AaspasSearchBar(),
          ThreeCardsOfCategoryType(),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: SizedBox(
                // height: 10,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,

                  children: [
                    // Text(
                    //   maxLines: 1,
                    //   AaspasStrings.trendingCategories,
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     overflow: TextOverflow.ellipsis,
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.w700,
                    //     fontFamily: "Roboto",
                    //     fontStyle: FontStyle.normal,
                    //   ),
                    // ),

                    // SearchPage(),
                    Container(
                      color: Colors.yellow,
                      width: 160,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/search_page");
                        },
                        child: Text(
                          maxLines: 1,
                          "search_page",
                          style: TextStyle(
                            decorationColor: Color(0xFF732FCB),
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF732FCB),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    // ShopDetailsPage(),
                    Container(
                      color: Colors.yellow,
                      width: 160,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/shop_details");
                        },
                        child: Text(
                          maxLines: 1,
                          "shop_details",
                          style: TextStyle(
                            decorationColor: Color(0xFF732FCB),
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF732FCB),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    // VideoScrollScreen(),
                    Container(
                      color: Colors.yellow,
                      width: 160,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/video_scroll_screen");
                        },
                        child: Text(
                          maxLines: 1,
                          "video_scroll_screen",
                          style: TextStyle(
                            decorationColor: Color(0xFF732FCB),
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF732FCB),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    // CatItemWise(),
                    Container(
                      color: Colors.yellow,
                      width: 160,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/cat_item_wise_shops");
                        },
                        child: Text(
                          maxLines: 1,
                          "cat_item_wise_shops",
                          style: TextStyle(
                            decorationColor: Color(0xFF732FCB),
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF732FCB),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    // ServiceDetails(),
                    Container(
                      color: Colors.yellow,
                      width: 160,
                      child: TextButton(
                        //
                        onPressed: () {
                          Navigator.pushNamed(context, "/service_details");
                        },
                        child: Text(
                          maxLines: 1,
                          "service_details",
                          style: TextStyle(
                            decorationColor: Color(0xFF732FCB),
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF732FCB),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    // LocationPermission(),
                    Container(
                      color: Colors.yellow,
                      width: 160,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/location_permission");
                        },
                        child: Text(
                          maxLines: 1,
                          "location_permission",
                          style: TextStyle(
                            decorationColor: Color(0xFF732FCB),
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF732FCB),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    // LocationDenied(),
                    Container(
                      color: Colors.yellow,
                      width: 160,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/location_denied");
                        },
                        child: Text(
                          maxLines: 1,
                          "location_denied",
                          style: TextStyle(
                            decorationColor: Color(0xFF732FCB),
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF732FCB),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    //Image Slider
                    Container(
                      color: Colors.yellow,
                      width: 160,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/image_slider");
                        },
                        child: Text(
                          maxLines: 1,
                          "image_slider",
                          style: TextStyle(
                            decorationColor: Color(0xFF732FCB),
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF732FCB),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    // Property Details
                    Container(
                      color: Colors.yellow,
                      width: 160,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/property_details");
                        },
                        child: Text(
                          maxLines: 1,
                          "property_details",
                          style: TextStyle(
                            decorationColor: Color(0xFF732FCB),
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF732FCB),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Text(
                //       maxLines: 1,
                //       AaspasStrings.trendingCategories,
                //       style: TextStyle(
                //         fontSize: 14,
                //         overflow: TextOverflow.ellipsis,
                //         color: Colors.black,
                //         fontWeight: FontWeight.w700,
                //         fontFamily: "Roboto",
                //         fontStyle: FontStyle.normal,
                //       ),
                //     ),
                //
                //     TextButton(
                //       onPressed: () {
                //         Navigator.pushNamed(context, "/reelsPlayer");
                //       },
                //       child: Text(
                //         maxLines: 1,
                //         "See all",
                //         style: TextStyle(
                //           decorationColor: Color(0xFF732FCB),
                //           fontSize: 14,
                //           overflow: TextOverflow.ellipsis,
                //           color: Color(0xFF732FCB),
                //           decoration: TextDecoration.underline,
                //           fontWeight: FontWeight.w700,
                //           fontFamily: "Roboto",
                //           fontStyle: FontStyle.normal,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
          CategoryGridView(categoriesCount: 12.toString()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: SizedBox(
                height: 32,
                child: Text(
                  "Near By Shops",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ShopListSliverNearby(),
        ],
      ),
    );
  }
}
