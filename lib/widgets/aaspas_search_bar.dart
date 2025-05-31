import 'package:flutter/material.dart';
import '../constant_and_api/aaspas_constant.dart';

class AaspasSearchBar extends StatelessWidget {
  const AaspasSearchBar({super.key, this.isEnabled = false});
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // snap: true,// if snap is true then floating must be true
      floating: false,
      pinned: true,
      automaticallyImplyLeading: false,

      backgroundColor: Colors.white,
      // if tool toolbarHeight > expandedHeight then backgroundColor will not visible
      toolbarHeight: 64,
      expandedHeight: 64,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(context, "/reelsPlayer");
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  enabled: isEnabled,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Color(0x88000000),
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 13.0,
                      horizontal: 10.0,
                    ),
                    filled: true,
                    hintMaxLines: 1,
                    hintText: AaspasStrings.searchPlaceholder,
                    hintStyle: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: "Roboto",
                      fontSize: 14,
                      height: 1.7,
                      fontWeight: FontWeight.w600,
                      color: Color(0x80000000),
                    ),
                    maintainHintHeight: true,
                    fillColor: Color(0xFFF6EEFF),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xFFE6E9EF),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xFFE6E9EF),
                        width: 1,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Color(0x80000000),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
