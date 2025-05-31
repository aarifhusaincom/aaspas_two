// Use SliverList with SliverChildBuilderDelegate for lazy loading items inside a CustomScrollView.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constant_and_api/aaspas_constant.dart';
import '../../widgets/shop_card.dart';

import '../../model/shop_model.dart';

class ShopListSliver extends StatefulWidget {
  const ShopListSliver({super.key});

  @override
  State<ShopListSliver> createState() => _ShopListSliverState();
}

class _ShopListSliverState extends State<ShopListSliver> {
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
                edgeInsets: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                image: "${shopList[index].bigImageUrl}",
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
