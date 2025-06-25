import 'dart:convert';

import 'package:aaspas/constant_and_api/aaspas_constant.dart';
import 'package:aaspas/model/property_card_model.dart';
import 'package:aaspas/widgets/property/property_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PropertyListSliver extends StatefulWidget {
  const PropertyListSliver({
    super.key,
    this.propertyId = '6832ba660061f42441adc081',
    this.propertyCategoryId = '6793353ecf01ca5fecd2c881',
    this.onTapPropertyCard,
  });
  final String? propertyId;
  final String? propertyCategoryId;
  final void Function(String propertyId)? onTapPropertyCard;

  @override
  State<PropertyListSliver> createState() => _PropertyListSliverState();
}

class _PropertyListSliverState extends State<PropertyListSliver> {
  ////////////----- Params Starts--------///////////
  String? categoryId;

  ////////////----- Params Ends--------///////////

  List propertyList = [];
  int currentPage = 1;
  final int pageSize = 20;
  bool isLoading = false;
  bool isLastPage = false;
  bool noDataFound = false;
  int maxListCount = 1000;
  final ScrollController _scrollController = ScrollController();
  //////////////////////////////////////////
  var jsonData;
  @override
  void initState() {
    super.initState();

    fetchServices();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          !isLastPage) {
        fetchServices();
      }
    });
  }

  Future<void> fetchServices() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });
    categoryId = widget.propertyCategoryId!;
    final String paramString =
        '?categoryId=$categoryId&lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=${AaspasPageData.page}&pageSize=${AaspasPageData.pageSize}';
    final url =
        '${AaspasWizard.baseUrl}${AaspasWizard.getPropertiesByCategoryId}$paramString';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      final model = PropertyCardModel.fromJson(jsonData);
      final newItems = model.items ?? [];
      final model2 = Items.fromJson(jsonData);
      // final newItems2 = model2.images ?? [];
      print("/////////////////////////////////////////////item 2");
      // print(jsonData['items']);
      // print(jsonData['items'][1]['images']);

      setState(() {
        if (newItems.isEmpty && propertyList.isEmpty) {
          noDataFound = true;
        } else {
          propertyList.addAll(newItems);
          // print(propertyList);
          isLastPage = newItems.length < pageSize;
          currentPage++;
        }
        isLoading = false;
      });
    }
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
        : propertyList.isEmpty
        ? SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
        : SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: propertyList.length + 1,
            (context, index) {
              ////////////////////////////////
              if (noDataFound) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("No Data Found")),
                );
              }
              if (index >= maxListCount) {
                // propertyList = propertyList.take(maxListCount).toList();
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

              if (index < propertyList.length) {
                if (widget.propertyId != propertyList[index].sId) {
                  return InkWell(
                    onTap: () {
                      widget.onTapPropertyCard!(propertyList[index].sId);
                    },
                    child: PropertyCard(
                      propertyTitle: "${propertyList[index].title}",
                      actualPrice: propertyList[index].actualPrice,
                      visualPrice: "${propertyList[index].visualPrice}",
                      totalArea: propertyList[index].totalArea,
                      phoneNo: propertyList[index].phoneNo.toString(),
                      brokerageType: "${propertyList[index].brokerageType}",
                      // image:
                      //     jsonData['items'][index]['images'].length == 0
                      //         ? "assets/images/shopPlaceholder.png"
                      //         : jsonData['items'].length == 0
                      //         ? "assets/images/shopPlaceholder.png"
                      //         : "${jsonData['items'][index]['images'][0]['url']}",
                      image:
                          propertyList[index].images == null
                              ? AaspasWizard.shopAltImage
                              : propertyList[index].images!.isEmpty
                              ? AaspasWizard.shopAltImage
                              // : !propertyList[index].images![0] is String
                              : true
                              ? AaspasWizard.shopAltImage
                              : propertyList[index].images![0],
                      // : AaspasWizard.shopAltImage,
                      area: "${propertyList[index].area}",
                      city: "${propertyList[index].city}",
                      edgeInsets: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              } else {
                if (isLastPage) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("End of List")),
                  );
                }
                currentPage++;
                fetchServices();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } //else ends
            },
          ),
        );
  }
}
