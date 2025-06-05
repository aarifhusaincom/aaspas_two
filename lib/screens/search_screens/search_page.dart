import 'package:flutter/material.dart';
import '../../widgets/app_and_search_bar/appbar_only_back.dart';
import '../../widgets/app_and_search_bar/aaspas_search_bar.dart';
import '../../widgets/cat_type_and_cards/category_grid_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //////////////
  late FocusNode _focusNode;
  late TextEditingController _controller;

  ////////////////
  /// init start///

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();

    // Delay to ensure build context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus(); // This will show the keyboard
    });
  }

  /// init Ends///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarOnlyBack(title: "Search"),
      // body: ServicesListNonSliver(),
      body: CustomScrollView(
        slivers: [
          AaspasSearchBar(
            isEnabled: true,
            focusNode: _focusNode,
            controller: _controller,
          ),
          SliverToBoxAdapter(child: CategoryGridView(categoriesCount: 0)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
