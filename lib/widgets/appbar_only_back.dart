import 'package:flutter/material.dart';

class AppbarOnlyBack extends StatelessWidget implements PreferredSizeWidget {
  const AppbarOnlyBack({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(color: Colors.white),
      ),
      // toolbarOpacity: 1,
      // scrolledUnderElevation: 5,
      // leading: Text("data"),
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
