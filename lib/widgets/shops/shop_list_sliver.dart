// Use SliverList with SliverChildBuilderDelegate for lazy loading items inside a CustomScrollView.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../constant_and_api/aaspas_constant.dart';
import 'shop_card.dart';

import '../../model/shop_model.dart';

class ShopListSliver extends StatefulWidget {
  const ShopListSliver({
    super.key,
    required this.shopId,
    required this.featuredCatIds,
    this.onTapShopCard,
  });
  final List<dynamic> featuredCatIds;
  final String shopId;
  final void Function(String shopId)? onTapShopCard;

  @override
  State<ShopListSliver> createState() => _ShopListSliverState();
}

class _ShopListSliverState extends State<ShopListSliver> {
  //////////////////////////////////////////////////
  List<Items> shopList = [];
  List<Items> newItems = [];
  int currentPage = 1;
  final int pageSize = 50;
  bool isLastPage = false;
  bool noDataFound = false;
  int maxListCount = 50;
  // List<String> items = ["Item 1", "Item 2", "Item 3"];

  //////////////////////////////////////////////////
  Future<void> fetchShops() async {
    final String paramString =
        '?featureCategoryId=${widget.featuredCatIds.join(',')}&lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize';
    final url =
        '${AaspasWizard.baseUrl}${AaspasWizard.getRelatedShops}$paramString';

    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final model = ShopModel.fromJson(jsonData);

      newItems = model.items ?? [];
      if (newItems.isEmpty) {
        print("///////////// No new Shop found");
        print(newItems.length);
        noDataFound = true;
      }

      ////////////////////
      setState(() {
        shopList.addAll(newItems);
        isLastPage = newItems.length < pageSize;
        // items = ["Item 4", "Item 5", "Item 6"];
        if (shopList.length > maxListCount) {
          shopList.removeRange(maxListCount, shopList.length);
        }
      });
      ////////////
    }
  }
  //////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    fetchShops();
  }
  ///////////////////////////////////////////////////////////////
  // Open Google Map and redirect to that location

  void openMap({required String latt, required String longg}) async {
    final Uri mapUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latt,$longg',
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
  @override
  Widget build(BuildContext context) {
    return noDataFound
        ? SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: Center(child: Text("No Data Found")),
          ),
        )
        : shopList.isEmpty
        ? SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
        : SliverList(
          delegate: SliverChildBuilderDelegate(childCount: shopList.length + 1, (
            context,
            index,
          ) {
            ////////////////////////////////
            if (noDataFound) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("No Data Found")),
              );
            }
            ///////////////////////////////////
            if (index >= maxListCount) {
              // shopList = shopList.take(maxListCount).toList();
              return Padding(
                padding: EdgeInsets.all(8),
                // child: Text("Reached Max"),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 5, // space above and below
                ),
              );
            }
            ///////////////////////////////////////
            if (index < shopList.length) {
              if (widget.shopId == shopList[index].sId) {
                return SizedBox(height: 0);
              }
              return InkWell(
                onTap: () {
                  widget.onTapShopCard!(shopList[index].sId!);
                },
                child: ShopCard(
                  onDirectionTap: ({
                    required String lat1,
                    required String long1,
                  }) {
                    openMap(latt: lat1, longg: long1); // your existing function
                  },
                  locLat: shopList[index].location!.coordinates![1].toString(),
                  locLong: shopList[index].location!.coordinates![0].toString(),
                  edgeInsets: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  image: shopList[index].shopImage ?? AaspasWizard.shopAltImage,
                  shopName: "${shopList[index].shopName}",
                  shopAddress: "${shopList[index].address}",
                  currentDistance:
                      "${shopList[index].distanceKm!.toStringAsFixed(2) ?? 0.00} KM",
                ),
              );
            } else {
              if (isLastPage) {
                print(
                  "////////////////////////////////////////////shop_list_sliver",
                );
                print("End of Shop List");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("End of List")),
                );
              }
              currentPage++;
              fetchShops();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            ///////////////////////////////////////////////////////
          }),
        );
  }
}
