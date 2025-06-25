import 'dart:convert';

import 'package:aaspas/constant_and_api/aaspas_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../reels/reel_cache.dart';
import 'reel_card.dart';

import '../../model/reel_model.dart';

class ReelsSlideView extends StatefulWidget {
  const ReelsSlideView({super.key});

  @override
  State<ReelsSlideView> createState() => _ReelsSlideViewState();
}

class _ReelsSlideViewState extends State<ReelsSlideView> {
  //////////////////////////////////////////////////

  int currentPage = 1;
  int pageSize = 20;
  bool isLastPage = false;
  bool noDataFound = false;
  int maxListCount = 1000;
  // List<String> items = ["Item 1", "Item 2", "Item 3"];

  //////////////////////////////////////////////////
  Future<void> fetchReels() async {
    final String paramString =
        '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=$currentPage&pageSize=$pageSize';
    final url =
        '${AaspasWizard.baseUrl}${AaspasWizard.getAllReels}$paramString';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final model = ReelModel.fromJson(jsonData);

      final newItems = model.items ?? [];
      if (newItems.isEmpty) {
        if (ReelCache.reelList.isEmpty) {
          noDataFound = true;
        }
        isLastPage = newItems.length < pageSize;
      }

      ////////////////////
      setState(() {
        ReelCache.reelList.addAll(newItems);

        // print("/////////////////////////////// Current Page");
        // print(currentPage);
        //
        // print("/////////////////////////////// Page Size");
        // print(pageSize);
        //
        // print("/////////////////////////////// new Item Length");
        // print(newItems.length);
        //
        // print("/////////////////////////// Current Reel List item Count");
        // print(ReelCache.reelList.length);

        isLastPage = newItems.length < pageSize;

        if (ReelCache.reelList.length > maxListCount) {
          ReelCache.reelList.removeRange(
            maxListCount,
            ReelCache.reelList.length,
          );
        }
      });
      ////////////
    }

    //////////////////////////////////////////////////
  }

  @override
  void initState() {
    ReelCache.reelList = [];
    super.initState();
    fetchReels();
  }

  @override
  Widget build(BuildContext context) {
    return noDataFound
        ? SliverAppBar(
          automaticallyImplyLeading: false,
          snap: true,
          floating: true,
          backgroundColor: Color(0x00FFFFFF),
          toolbarHeight: 175,
          expandedHeight: 200,
          flexibleSpace: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("No Data Found")),
            ),
          ),
        )
        : ReelCache.reelList.isEmpty
        ? SliverAppBar(
          automaticallyImplyLeading: false,
          snap: true,
          floating: true,
          backgroundColor: Colors.white,
          toolbarHeight: 175,
          expandedHeight: 200,
          flexibleSpace: Container(
            child: Center(
              child: Lottie.asset(AaspasLottie.reelsAnimation, height: 200),
            ),
          ),
        )
        : SliverAppBar(
          automaticallyImplyLeading: false,
          snap: true,
          floating: true,
          backgroundColor: Colors.white,
          toolbarHeight: 175,
          expandedHeight: 200,
          flexibleSpace: Container(
            height: 200,

            // width: MediaQuery.of(context).size.width,
            color: Colors.white, // can hide color to get adoptive
            child: ListView.separated(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,

              padding: EdgeInsets.all(5),
              itemCount: ReelCache.reelList.length + 1,
              itemBuilder: (context, int index) {
                ////////////////////////////////
                if (noDataFound) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("No Data Found")),
                  );
                }
                ///////////////////////////////////
                if (index >= maxListCount) {
                  // shopList = shopList.take(maxListCount).toList();
                  return Padding(
                    padding: EdgeInsets.all(8),
                    // child: Text("Reached Max"),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 5, // space above and below
                    ),
                  );
                }
                ///////////////////////////////////////
                if (index < ReelCache.reelList.length) {
                  print(
                    "ReelCache.reelList.length = ${ReelCache.reelList.length}",
                  );
                  print(
                    "////// ReelCache.reelList[index] = ${ReelCache.reelList[index].url} ",
                  );
                  return ReelCard(
                    reelIndex: index,
                    thumbnailUrl: "${ReelCache.reelList[index].thumbnailUrl}",
                    totalViews: ReelCache.reelList[index].views ?? 0,
                  );
                } else {
                  if (isLastPage) {
                    print(
                      "//////////////////////////////////////////////////////////",
                    );
                    print("End of Reel List");
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("End of List")),
                    );
                  }
                  currentPage++;
                  fetchReels();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                ///////////////////////////////////////////////////////
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 6); // Space between items
              },
            ),
          ),
        );
  }
}
