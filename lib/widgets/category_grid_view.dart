import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constant_and_api/aaspas_constant.dart';
import 'category_card.dart';

class CategoryGridView extends StatefulWidget {
  const CategoryGridView({
    super.key,
    this.categoriesCount = "allCategoriesList.length",
  });
  final String categoriesCount;

  @override
  State<CategoryGridView> createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  //
  //
  int newCount() {
    if (widget.categoriesCount == "allCategoriesList.length") {
      return allCategoriesList.length;
    } else {
      return int.parse(widget.categoriesCount);
    }
  }

  var count = 0;
  List<Map<String, dynamic>> allCategoriesList = [];

  /////// getAllCategories()
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final String paramString = '?page=${AaspasPageData.page}&pageSize=12';
    final url = '${AaspasApi.baseUrl}${AaspasApi.getAllCategories}$paramString';

    final response = await http.get(Uri.parse(url));
    var allCategoriesData = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in allCategoriesData["items"]) {
        allCategoriesList.add(i);
      }
      // print(reelsList[0]["thumbnail_url"]);
      // print(allCategoriesList);
      return allCategoriesList;
    } else {
      return allCategoriesList;
    }
  }
  //

  //

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FutureBuilder(
        future: getAllCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("Loading"));
          } else {
            return
            //
            //
            Wrap(
              spacing: 10, // horizontal spacing
              alignment: WrapAlignment.center,

              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 1, // vertical spacing
              children: List.generate(newCount(), (index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/cat_item_wise",
                      arguments: {
                        "id": "${allCategoriesList[index]["_id"]}",
                        "name": "${allCategoriesList[index]["category_name"]}",
                        "imageUrl":
                            '${allCategoriesList[index]["category_image"]}',
                        "categoryType": "${allCategoriesList[index]["type"]}",
                        "cardType": "category",
                      },
                    );
                  },
                  child: CategoryCard(
                    categoryImage:
                        "${allCategoriesList[index]["category_image"]}",
                    categoryName:
                        "${allCategoriesList[index]["category_name"]}",
                  ),
                );
              }),
            );
          }
        },
      ),
    );
  }
}
