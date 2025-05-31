import 'dart:convert';

import 'package:aaspas/widgets/property/property_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constant_and_api/aaspas_constant.dart';
import '../../model/PropertyByCategoryModel.dart';

class PropertyListNonSliver extends StatefulWidget {
  const PropertyListNonSliver({
    super.key,
    this.id,
    // this.propertyFor = 'sale',
  });
  // final String? propertyFor;
  final String? id;

  @override
  State<PropertyListNonSliver> createState() => _PropertyListNonSliverState();
}

class _PropertyListNonSliverState extends State<PropertyListNonSliver> {
  late final String url;
  late final dynamic jsonData;
  List<Items> propertyList = [];
  int currentPage = 1;
  final int pageSize = 20;
  bool isLoading = false;
  bool isLastPage = false;
  bool noDataFound = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchPropertyList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          !isLastPage) {
        fetchPropertyList();
      }
    });
  }

  Future<void> fetchPropertyList() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final String paramString =
        '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize&categoryId=${widget.id}';
    url =
        '${AaspasApi.baseUrl}${AaspasApi.getPropertiesByCategoryId}$paramString';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      final model = PropertyByCategoryIdModel.fromJson(jsonData);
      final newItems = model.items ?? [];

      setState(() {
        if (newItems.isEmpty && propertyList.isEmpty) {
          noDataFound = true;
        } else {
          propertyList.addAll(newItems);
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
      itemCount: propertyList.length + (isLastPage ? 0 : 1),
      itemBuilder: (context, index) {
        if (index < propertyList.length) {
          // final item = propertyList[index];
          return PropertyCard(
            brokerageType: '${propertyList[index].brokerageType}',
            actualPrice: propertyList[index].actualPrice!,
            area: propertyList[index].area!,
            edgeInsets: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            city: '${propertyList[index].city}',
            phoneNo: '${propertyList[index].phoneNo}',
            propertyTitle: '${propertyList[index].title}',
            totalArea: propertyList[index].totalArea!,
            visualPrice: '${propertyList[index].visualPrice}',
            image:
                jsonData['items'][index]['images'].length == 0
                    ? "assets/images/shopPlaceholder.png"
                    : jsonData['items'].length == 0
                    ? "assets/images/shopPlaceholder.png"
                    : "${jsonData['items'][index]['images'][0]['url']}",
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
