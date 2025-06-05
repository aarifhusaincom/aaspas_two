import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constant_and_api/aaspas_constant.dart';
import 'category_card.dart';

class CategoryGridView extends StatefulWidget {
  const CategoryGridView({
    super.key,
    required this.categoriesCount,
    this.categoryType,
  });
  final int categoriesCount;
  final String? categoryType;

  @override
  State<CategoryGridView> createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  //
  //
  int page = 1;
  int pageSize = 20;
  int newCount() {
    if (widget.categoriesCount > 0) {
      return widget.categoriesCount;
    } else {
      return allCategoriesList.length;
    }
  }

  var count = 0;
  List<Map<String, dynamic>> allCategoriesList = [];

  /////// getAllCategories()
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final String paramString = '?page=$page&pageSize=$pageSize';
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
    return FutureBuilder(
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
            children:
                allCategoriesList
                    .where(
                      (item) =>
                          item["type"] == (widget.categoryType ?? item["type"]),
                    )
                    .take(newCount())
                    .map(
                      (item) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/cat_item_wise",
                            arguments: {
                              "id": "${item["_id"]}",
                              "name": "${item["category_name"]}",
                              "imageUrl": '${item["category_image"]}',
                              "categoryType": "${item["type"]}",
                              "cardType": "category",
                            },
                          );
                        },
                        child: CategoryCard(
                          categoryImage: "${item["category_image"]}",
                          categoryName: "${item["category_name"]}",
                        ),
                      ),
                    )
                    .toList(),
          );
        }
      },
    );
  }
}

// children: List.generate(newCount(), (index) {
//   if (allCategoriesList[index]["type"] == widget.categoryType) {
//     //// condition
//   }
//   return InkWell(
//     onTap: () {
//       Navigator.pushNamed(
//         context,
//         "/cat_item_wise",
//         arguments: {
//           "id": "${allCategoriesList[index]["_id"]}",
//           "name": "${allCategoriesList[index]["category_name"]}",
//           "imageUrl":
//               '${allCategoriesList[index]["category_image"]}',
//           "categoryType": "${allCategoriesList[index]["type"]}",
//           "cardType": "category",
//         },
//       );
//     },
//     child: CategoryCard(
//       categoryImage:
//           "${allCategoriesList[index]["category_image"]}",
//       categoryName:
//           "${allCategoriesList[index]["category_name"]}",
//     ),
//   );
// }),
