import 'dart:convert';

import 'package:aaspas/constant_and_api/aaspas_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/shop_card.dart';

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
      url = '${AaspasApi.baseUrl}${AaspasApi.getAllShops}$paramString';
    }

    if (widget.shopFor == "category") {
      final String paramString =
          '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize&categoryId=${widget.id}';
      url = '${AaspasApi.baseUrl}${AaspasApi.getShopsByCategory}$paramString';
    }

    if (widget.shopFor == "item") {
      final String paramString =
          '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize&itemId=${widget.id}';
      url = '${AaspasApi.baseUrl}${AaspasApi.getShopsByItem}$paramString';
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
    if (noDataFound) {
      return Center(child: Text("No Data Found"));
    }

    return ListView.separated(
      controller: _scrollController,
      itemCount: shopList.length + (isLastPage ? 0 : 1),
      itemBuilder: (context, index) {
        if (index < shopList.length) {
          // final item = shopList[index];
          return ShopCard(
            edgeInsets: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            image: "${shopList[index].bigImageUrl}",
            shopName: "${shopList[index].shopName}",
            shopAddress: "${shopList[index].address}",
            currentDistance:
                "${shopList[index].distanceKm!.toStringAsFixed(2) ?? 0.00} KM",
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
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
