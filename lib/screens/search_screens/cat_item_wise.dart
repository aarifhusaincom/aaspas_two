import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/app_and_search_bar/appbar_only_back.dart';

import '../../constant_and_api/aaspas_constant.dart';
import '../../functions/location/LocationSetterAaspas.dart';
import '../../widgets/chips/category_chip.dart';
import '../../widgets/chips/item_chip.dart';
import '../../widgets/property/property_list_non_sliver.dart';
import '../../widgets/shops/services_list_non_sliver.dart';
import '../../widgets/shops/shop_list_non_sliver.dart';

class CatItemWise extends StatefulWidget {
  const CatItemWise({super.key});

  @override
  State<CatItemWise> createState() => _CatItemWiseState();
}

class _CatItemWiseState extends State<CatItemWise> {
  @override
  void initState() {
    LocationSetterAaspas(); // TODO: implement initState
    super.initState();
  }

  ///////// received data from route arguments Starts/////////
  dynamic data;
  String? id;
  String? name;
  String? imageUrl;
  String? cardType;
  String? categoryType;
  @override
  void didChangeDependencies() {
    if (data == null) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        data = args;
        id = data?['id'] ?? '';
        name = data?['name'] ?? '';
        imageUrl = data?['imageUrl'] ?? '';
        categoryType = data?['categoryType'] ?? '';
        cardType = data?['cardType'] ?? ''; // send me category or item
        print('/////////////////////// Data received at cat_item_wise');
        print("id = $id");
        print("name = $name");
        print("imageUrl = $imageUrl");
        print("categoryType = $categoryType");
        print("cardType = $cardType");
        print(
          "(categoryType == 'properties') = ${(categoryType == 'Properties')}",
        );
        print("(categoryType == 'services') = ${(categoryType == 'Services')}");
      }
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  ///////// received data from route arguments Ends/////////

  @override
  Widget build(BuildContext context) {
    print("//// ---- in CatItemWise imageUrl---- ////");
    print(imageUrl);
    print("//// ----is ? cardType == category---- ////");
    print(cardType == "category");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarOnlyBack(title: "Related Search"),
      body: Column(
        spacing: 10,
        children: [
          Container(
            // color: Colors.purple,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Row(
              spacing: 8,
              children: [
                // ItemChipClose(itemName: "Charging Cover "),
                if (cardType == "item")
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ItemChipClose(itemName: name!),
                  ),
                if (cardType == "category")
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CategoryChipClose(
                      imageUrl: imageUrl!,
                      catName: name!,
                    ),
                  ),
                // ItemChip(itemName: "Mobile Cover"),
                // CategoryChip(
                //   imageUrl:
                //       "https://firebasestorage.googleapis.com/v0/b/aaspas-api.firebasestorage.app/o/categoryImages%2F1737092923003_1000089124.png?alt=media&token=ec54b18d-13d2-4a14-99d6-d29a5bbe6a9f",
                //   catName: "Fast Food Shop ",
                // ),
                // CategoryChip(
                //   imageUrl:
                //       "https://firebasestorage.googleapis.com/v0/b/aaspas-api.firebasestorage.app/o/categoryImages%2F1736583419690_Women's%20Traditional%20Wear.png?alt=media&token=c5e2043b-8ee0-476b-8dcb-0833b4599440",
                //   catName: "Women Traditional Wear",
                // ),
              ],
            ),
          ),

          // Related Shops Nearby (Text)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 35,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              "Related ${(cardType == "category") ? categoryType : name} nearby",
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: AaspasColors.textHalfBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Near by shops builder non Sliver

          // If come via category Card
          // if (categoryType != null && cardType == "category")
          if (cardType == "category")
            Expanded(
              child:
                  (categoryType == 'properties' || categoryType == 'Properties')
                      ? PropertyListNonSliver(id: '$id')
                      : (categoryType == 'services' ||
                          categoryType == 'Services')
                      ? ServicesListNonSliver(id: id)
                      : ShopListNonSliver(shopFor: cardType, id: id),
            ),

          // If come via item Card
          //   if (id != null && cardType == "item")
          if (cardType == "item")
            Expanded(
              child:
                  (categoryType == 'shops' || categoryType == 'Shops')
                      ? ShopListNonSliver(shopFor: cardType, id: id)
                      : PropertyListNonSliver(id: '$id'),
            ),
        ],
      ),
    );
  }
}
