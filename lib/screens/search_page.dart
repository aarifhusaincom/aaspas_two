import 'package:flutter/material.dart';
import '../../widgets/appbar_only_back.dart';
import '../widgets/shops/services_list_non_sliver.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
      appBar: AppbarOnlyBack(title: "Search"),
      body: ServicesListNonSliver(),
      // body: CustomScrollView(
      //   slivers: [AaspasSearchBar(isEnabled: true), CategoryGridView()],
      // ),
    );
  }
}
