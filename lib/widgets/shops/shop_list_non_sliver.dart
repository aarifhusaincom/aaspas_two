import 'dart:convert';

import 'package:aaspas/constant_and_api/aaspas_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'shop_card.dart';

import '../../model/shop_model.dart';

class ShopListNonSliver extends StatefulWidget {
  const ShopListNonSliver({super.key, required this.shopFor, this.id});
  final String? shopFor;
  final String? id;

  @override
  State<ShopListNonSliver> createState() => _ShopListNonSliverState();
}

class _ShopListNonSliverState extends State<ShopListNonSliver> {
  late final String url;
  List<Items> shopList = [];
  int currentPage = 1;
  final int pageSize = 20;
  bool isLoading = false;
  bool isLastPage = false;
  bool noDataFound = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // if (widget.shopFor == "nearBy") {
    fetchShops();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          !isLastPage) {
        fetchShops();
      }
    });
    // }
  }

  Future<void> fetchShops() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    if (widget.shopFor == "nearBy") {
      final String paramString =
          '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize';
      url = '${AaspasWizard.baseUrl}${AaspasWizard.getAllShops}$paramString';
    }

    if (widget.shopFor == "category") {
      final String paramString =
          '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize&categoryId=${widget.id}';
      url =
          '${AaspasWizard.baseUrl}${AaspasWizard.getShopsByCategory}$paramString';
    }

    if (widget.shopFor == "item") {
      final String paramString =
          '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize&itemId=${widget.id}';
      url = '${AaspasWizard.baseUrl}${AaspasWizard.getShopsByItem}$paramString';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final model = ShopModel.fromJson(jsonData);
      final newItems = model.items ?? [];

      setState(() {
        if (newItems.isEmpty && shopList.isEmpty) {
          noDataFound = true;
        } else {
          shopList.addAll(newItems);
          isLastPage = newItems.length < pageSize;
          currentPage++;
        }
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("/////////////////// shop list non sliver running");
    if (noDataFound) {
      return Center(child: Text("No Data Found"));
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
    return ListView.separated(
      controller: _scrollController,
      itemCount: shopList.length + (isLastPage ? 0 : 1),
      itemBuilder: (context, index) {
        if (index < shopList.length) {
          // final item = shopList[index];
          return ShopCard(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/shop_details",
                arguments: {"sid": "${shopList[index].sId}"},
              );
            },
            onDirectionTap: ({required String lat1, required String long1}) {
              openMap(latt: lat1, longg: long1); // your existing function
            },
            edgeInsets: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            image: shopList[index].shopImage ?? AaspasWizard.shopAltImage,
            shopName: "${shopList[index].shopName}",
            shopAddress: "${shopList[index].address}",
            currentDistance:
                "${shopList[index].distanceKm!.toStringAsFixed(2) ?? 0.00} KM",
            locLat: shopList[index].location!.coordinates![1].toString(),
            locLong: shopList[index].location!.coordinates![0].toString(),
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset(
                AaspasLottie.sidemapsidelist,
                // width: double.infinity,
                // height: double.infinity,
                // fit: BoxFit.fitWidth,
              ),
              // CircularProgressIndicator(),
            ),
          );
        }
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20); // Space between items
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
