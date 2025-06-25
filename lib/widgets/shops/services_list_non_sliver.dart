import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../constant_and_api/aaspas_constant.dart';
// import '../../functions/location/LocationSetterAaspas.dart';
import '../../widgets/services/service_card.dart';

import '../../model/services_card_model.dart';

class ServicesListNonSliver extends StatefulWidget {
  const ServicesListNonSliver({super.key, this.id});
  final String? id;
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

    final String paramString =
        '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize&categoryId=${widget.id}';

    final url =
        '${AaspasWizard.baseUrl}${AaspasWizard.getServicesByCategory}$paramString';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final model = ServicesCardModel.fromJson(jsonData);
      final newItems = model.items ?? [];
      print("///////////////////// newItems");
      print(newItems);
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
    print("/////////////////// service list non sliver running");
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
            onTap: () {
              Navigator.pushNamed(
                context,
                "/service_details",
                arguments: {"sid": "${serviceList[index].sId}"},
              );
            },
            providerName: "${serviceList[index].providerName}",
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
              child: Lottie.asset(
                AaspasLottie.sidemapsidelist,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fitWidth,
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
