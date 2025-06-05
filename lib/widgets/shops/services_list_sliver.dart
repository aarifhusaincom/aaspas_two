import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constant_and_api/aaspas_constant.dart';
import '../../widgets/services/service_card.dart';

import '../../model/services_card_model.dart';

class ServicesListSliver extends StatefulWidget {
  const ServicesListSliver({
    super.key,
    this.categoryId,
    this.serviceId,
    this.onServiceTap,
  });
  final String? categoryId;
  final String? serviceId;
  final void Function(String serviceId)? onServiceTap;

  @override
  State<ServicesListSliver> createState() => _ServicesListSliverState();
}

class _ServicesListSliverState extends State<ServicesListSliver> {
  List<Items> serviceList = [];
  int currentPage = 1;
  final int pageSize = 20;
  bool isLoading = false;
  bool isLastPage = false;
  bool noDataFound = false;
  int maxListCount = 1000;
  final ScrollController _scrollController = ScrollController();

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

    final String paramString =
        '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize&categoryId=${widget.categoryId}';

    final url =
        '${AaspasApi.baseUrl}${AaspasApi.getServicesByCategory}$paramString';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final model = ServicesCardModel.fromJson(jsonData);
      final newItems = model.items ?? [];

      setState(() {
        if (newItems.isEmpty && serviceList.isEmpty) {
          noDataFound = true;
        } else {
          serviceList.addAll(newItems);
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
        : serviceList.isEmpty
        ? SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
        : SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: serviceList.length + 1,
            (context, index) {
              ////////////////////////////////
              if (noDataFound) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("No Data Found")),
                );
              }
              if (index >= maxListCount) {
                // serviceList = serviceList.take(maxListCount).toList();
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

              if (index < serviceList.length) {
                if (widget.serviceId != serviceList[index].sId) {
                  return ServiceCard(
                    onTap: () {
                      widget.onServiceTap!(serviceList[index].sId!);
                    },
                    karigarName: "${serviceList[index].karigarName}",
                    charges: "${serviceList[index].charges}",
                    image: "${serviceList[index].image}",
                    edgeInsets: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),

                    area: "${serviceList[index].area}",
                    categoryName: '${serviceList[index].categoryName}',
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
