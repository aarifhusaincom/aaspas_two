import 'dart:convert';

import 'package:aaspas/reels/reel_cache.dart';
import 'package:http/http.dart' as http;

import '../constant_and_api/aaspas_constant.dart';
import '../model/reel_model.dart';

class OnScrollFetchVideos {
  // static bool loadNewVideos = true;
  static Future<void> onPageChangeFunction(int currentIndex) async {
    print("onPageChangeFunction() Running");
    if (currentIndex + 3 > ReelCache.reelList.length) {
      print("if (currentIndex + 3 > ReelCache.reelList.length) Running");
      // if (loadNewVideos) {
      print(" if (loadNewVideos)  Running");
      final int currentApiPage = ((ReelCache.reelList.length / 20).toInt());
      print("currentApiPage = $currentApiPage");
      final String paramString =
          '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}&page=${currentApiPage + 1}&pageSize=20';
      final url =
          '${AaspasWizard.baseUrl}${AaspasWizard.getAllReels}$paramString';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final model = ReelModel.fromJson(jsonData);

        final newItems = model.items ?? [];
        print("newItems.length = ${newItems.length}");
        // if (newItems.isEmpty) {
        //   loadNewVideos = false;
        // }
        // if (newItems.length < 20) {
        //   loadNewVideos = false;
        // }
        ReelCache.reelList.addAll(newItems);
        ReelCache.reelList.toSet().toList();
        print("updated reeList ${ReelCache.reelList.length}");
      }
      // }
    }
  }
}
