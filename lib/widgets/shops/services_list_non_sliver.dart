import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/services/service_card.dart';

import '../../model/services_card_model.dart';

class ServicesListNonSliver extends StatefulWidget {
  const ServicesListNonSliver({super.key});

  @override
  State<ServicesListNonSliver> createState() => _ServicesListNonSliverState();
}

class _ServicesListNonSliverState extends State<ServicesListNonSliver> {
  List<Items> serviceList = [];
  int currentPage = 1;
  final int pageSize = 20;
  bool isLoading = false;
  bool isLastPage = false;
  bool noDataFound = false;
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

    final url =
        'https://api-246icbhmiq-uc.a.run.app/user/getServicesByCategory?page=$currentPage&pageSize=$pageSize&categoryId=6751965996e15298c8c8ac1a&lat=22.733255&lng=75.913898';
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
    if (noDataFound) {
      return Center(child: Text("No Data Found"));
    }

    return ListView.separated(
      controller: _scrollController,
      itemCount: serviceList.length + (isLastPage ? 0 : 1),
      itemBuilder: (context, index) {
        if (index < serviceList.length) {
          // final item = serviceList[index];
          return ServiceCard(
            karigarName: "${serviceList[index].karigarName}",
            charges: "${serviceList[index].charges}",
            image: "${serviceList[index].image}",
            edgeInsets: EdgeInsets.symmetric(horizontal: 16, vertical: 0),

            area: "${serviceList[index].area}",
            categoryName: '${serviceList[index].categoryName}',
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
