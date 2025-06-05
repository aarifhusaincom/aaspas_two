import 'package:flutter/material.dart';
import '../../widgets/app_and_search_bar/appbar_only_back.dart';
import '../../widgets/app_and_search_bar/aaspas_search_bar.dart';
import '../../widgets/cat_type_and_cards/category_grid_view.dart';

class SearchPageServiceWise extends StatelessWidget {
  const SearchPageServiceWise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   centerTitle: true,
      //   title: Text(
      //     "title",
      //     style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
      //   ),
      // ),
      appBar: AppbarOnlyBack(title: "Service Categories"),
      // body: ServicesListNonSliver(),
      body: CustomScrollView(
        slivers: [
          AaspasSearchBar(isEnabled: false),
          SliverToBoxAdapter(
            child: CategoryGridView(
              categoryType: 'services',
              categoriesCount: 0,
            ),
          ),
        ],
      ),
    );
  }
}
