// Use SliverList with SliverChildBuilderDelegate for lazy loading items inside a CustomScrollView.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../constant_and_api/aaspas_constant.dart';
import 'shop_card.dart';

import '../../model/shop_model.dart';

class ShopListSliverNearby extends StatefulWidget {
  const ShopListSliverNearby({super.key});

  @override
  State<ShopListSliverNearby> createState() => _ShopListSliverNearbyState();
}

class _ShopListSliverNearbyState extends State<ShopListSliverNearby> {
  //////////////////////////////////////////////////
  List<Items> shopList = [];
  int currentPage = 1;
  final int pageSize = 50;
  bool isLastPage = false;
  bool noDataFound = false;
  int maxListCount = 50;
  // List<String> items = ["Item 1", "Item 2", "Item 3"];

  //////////////////////////////////////////////////
  Future<void> fetchShops() async {
    final String paramString =
        '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize';
    final url = '${AaspasApi.baseUrl}${AaspasApi.getAllShops}$paramString';

    // final url =
    //     'https://api-246icbhmiq-uc.a.run.app/user/getAllShopss?lng=75.913898&lat=22.733255&page=$currentPage&pageSize=$pageSize';
    // https://api-246icbhmiq-uc.a.run.app/user/getRelatedShops?featureCategoryId=67664e11f4ba7c1a43dcc92a,66893e0599cf4b887b496af6,67738f0d0d1fbaecf3b34bde&lat=22.734947954439914&lng=75.90894186451176&page=1&pageSize=20
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final model = ShopModel.fromJson(jsonData);

      final newItems = model.items ?? [];
      if (newItems.isEmpty) {
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

    //////////////////////////////////////////////////
  }

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
              return ShopCard(
                locLat: shopList[index].location!.coordinates![1].toString(),
                locLong: shopList[index].location!.coordinates![0].toString(),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/shop_details",
                    arguments: {"sid": "${shopList[index].sId}"},
                  );
                },
                onDirectionTap: ({
                  required String lat1,
                  required String long1,
                }) {
                  openMap(latt: lat1, longg: long1); // your existing function
                },
                edgeInsets: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                image: shopList[index].bigImageUrl ?? AaspasImages.shopAltImage,
                shopName: "${shopList[index].shopName}",
                shopAddress: "${shopList[index].address}",
                currentDistance:
                    "${shopList[index].distanceKm!.toStringAsFixed(2) ?? 0.00} KM",
              );
            } else {
              if (isLastPage) {
                print(
                  "//////////////////////////////////////////////////////////",
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
