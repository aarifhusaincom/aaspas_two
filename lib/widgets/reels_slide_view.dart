import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/reel_card.dart';

import '../constant_and_api/aaspas_constant.dart';

class ReelsSlideView extends StatefulWidget {
  const ReelsSlideView({super.key});

  @override
  State<ReelsSlideView> createState() => _ReelsSlideViewState();
}

class _ReelsSlideViewState extends State<ReelsSlideView> {
  /////// getAllReels()
  List<Map<String, dynamic>> reelsList = [];
  Future<List<Map<String, dynamic>>> getAllReels() async {
    final response = await http.get(Uri.parse(AaspasApi.getAllReels));
    var reelsData = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in reelsData["items"]) {
        reelsList.add(i);
      }
      // print(reelsList[0]["thumbnail_url"]);
      // print(reelsList);
      return reelsList;
    } else {
      return reelsList;
    }
  }

  //
  //
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: true, // if snap is true then floating must be true
      floating: true,
      // pinned: true, // pinned means this will stick to the top at scroll with maintaining toolbarHeight. and activate the backgroundColor property smoothly.
      // If we reach to this, this will expand to the expandedHeight smoothly and activate the flexibleSpace child color.
      backgroundColor: Colors.white,
      // if tool toolbarHeight > expandedHeight then backgroundColor will not visible
      toolbarHeight: 175,
      expandedHeight: 200,
      flexibleSpace: Container(
        height: 200,
        width: double.infinity,
        color: Colors.white,
        child: FutureBuilder(
          future: getAllReels(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("Loading"));
            } else {
              return ListView.separated(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,

                padding: EdgeInsets.all(5),
                itemCount: reelsList.length,
                itemBuilder: (context, int index) {
                  return ReelCard(
                    thumbnailUrl: "${reelsList[index]["thumbnail_url"]}",
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 6); // Space between items
                },
              );
            }
          },
        ),
      ),
    );
  }
}
