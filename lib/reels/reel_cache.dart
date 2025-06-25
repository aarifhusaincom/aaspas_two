import 'dart:convert';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../reels/video_cache_manager.dart';

import '../constant_and_api/aaspas_constant.dart';
import '../../model/reel_model.dart';
import 'on_scroll_fetch_videos.dart';

class ReelCache {
  static int currentImagesInMemory = 0;
  static int currentVideosInMemory = 0;
  static int totalDefaultCacheSize = 0;
  static int totalVideoCacheSize = 0;
  static int currentPage = 1;

  /// Reel List everywhere starts
  static List<Items> reelList = [];

  /// Reel List everywhere ends

  // static List<String> videos = [];

  // static Future<List<String>> fetchVideos() async {
  //   final response = await http.get(
  //     Uri.parse(
  //       'https://api-246icbhmiq-uc.a.run.app/user/getAllReels?lat=22.733255&lng=75.913898&page=1&pageSize=63',
  //     ),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final List items = data['items']; // adjust if JSON structure differs
  //     return items.map((item) => item['url'] as String).toList();
  //   } else {
  //     throw Exception('Failed to load videos');
  //   }
  // }
  static Future<List<String>> fetchVideos() async {
    final response = await http.get(
      Uri.parse(
        'https://api-246icbhmiq-uc.a.run.app/user/getAllReels?lat=22.733255&lng=75.913898&page=1&pageSize=63',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List items = data['items']; // adjust if JSON structure differs
      return items.map((item) => item['url'] as String).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }

  static void downloader(String url) async {
    FileInfo? fileInfo = await checkCacheFor(url);
    if (fileInfo == null) {
      downloadInCacheFrom(url);
    } else {
      // var file = fileInfo.source ;
      // print(" and Source is {fileInfo.file}.source for $url");
    }
  }

  // Download the file in cache memory
  static Future<void> downloadInCacheFrom(String url) async {
    // print("(downloadInCacheFrom) Video downloading in cache via url : $url");
    await VideoCacheManager().getSingleFile(url);
  }

  // Get the downloaded file from the cache memory
  static Future<FileInfo?> checkCacheFor(url) async {
    // print("(checkCacheFor) Video checking in cache for url : $url");
    FileInfo? value = await VideoCacheManager().getFileFromCache(url);
    return value;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static Future<void> onPageChangeFunction(int currentPageIndex) async {
    OnScrollFetchVideos.onPageChangeFunction(currentPageIndex);
    currentPage = currentPageIndex;
    // print("currentPageIndex value is $currentPageIndex");
    ReelCache.defaultCacheDetails();
    ReelCache.allVideoCacheDetails();
    nextTwoVideosDownload(currentPageIndex);
  }

  static Future<void> nextTwoVideosDownload(int currentPage) async {
    // print("(reel_cache > nextTwoVideosDownload() running for currentPage)");
    // print("(reel_cache > nextTwoVideosDownload() running for currentPage + 1)");
    downloadNext(currentPage);
    downloadNext(currentPage + 1);
  }

  static downloadNext(int currentPage) async {
    if (currentPage < reelList.length) {
      ReelCache.downloader(reelList[currentPage].url as String);
    }
  }

  //---------Get All Image Objects from Default Cache Manager Starts---------//
  static Future<void> defaultCacheDetails() async {
    final tempDir = await getTemporaryDirectory();

    final cacheDir = Directory(
      '${tempDir.path}/libCachedImageData',
    ); // default cache path

    // print("Image Directory - ${cacheDir.path}");

    if (await cacheDir.exists()) {
      final files = cacheDir.listSync();
      // print("Found ${files.length} Image cached files");

      for (var file in files) {
        if (file is File) {
          // print("${file.path}- ${file.lengthSync()} bytes");
          totalDefaultCacheSize += file.lengthSync();
        }
      }
      // print(
      //   "Total Image cache size: ${(totalDefaultCacheSize / (1024 * 1024)).toInt()} MB",
      // );
      totalDefaultCacheSize = 0;

      if (files.length > AaspasNumber.maxImagesInCache) {
        currentImagesInMemory = files.length;
        for (var file in files) {
          if (file is File) {
            if (currentImagesInMemory <= AaspasNumber.maxImagesInCache) {
              break;
            }
            // print("${file.path} - ${file.lengthSync()} bytes");
            deleteFile(file.path);
            currentImagesInMemory--;
          }
        }
        currentImagesInMemory = 0;
      }
    } else {
      // print("Images Cache directory does not exist");
    }
  } // defaultCacheDetails

  //---------Get All Image Objects from Default Cache Manager Ends---------//
  ///
  //---------Get All Video Objects from Video Cache Manager Starts---------//

  static void allVideoCacheDetails() async {
    final vidTempDir = await getTemporaryDirectory();

    final cacheDir = Directory(
      '${vidTempDir.path}/videoCache',
    ); // or your custom key

    // print("video Directory - ${cacheDir.path}");

    if (await cacheDir.exists()) {
      final files = cacheDir.listSync();
      // print("Found ${files.length} Video cached files");

      for (var file in files) {
        if (file is File) {
          // print("${file.path} - ${file.lengthSync()} bytes");
          totalVideoCacheSize += file.lengthSync();
        }
      }
      // print(
      //   "Total Video cache size: ${(totalVideoCacheSize / (1024 * 1024)).toInt()} MB",
      // );
      totalVideoCacheSize = 0;

      if (files.length > AaspasNumber.maxVideoInCache) {
        // print("Deleting extra videos from cache");
        currentVideosInMemory = files.length;
        // print("Current videos in cache $currentVideosInMemory");
        for (var file in files) {
          if (file is File) {
            if (currentVideosInMemory <= AaspasNumber.maxVideoInCache) {
              // print(
              //   "Current videos in cache $currentVideosInMemory and Max videos limit is ${AaspasNumber.maxVideoInCache}",
              // );
              // print("So now deleting process from cache has been stopped");
              break;
            }
            // print("Deleting video from cache ${file.path}");
            // print("${file.path} - ${file.lengthSync()} bytes");
            deleteFile(file.path);
            currentVideosInMemory--;
            // print(
            //   "After deleting Total videos in cache $currentVideosInMemory",
            // );
          }
        }
        currentVideosInMemory = 0;
      }
    } else {
      // print("Video Cache directory does not exist");
    }
  } //allVideoCacheDetails()
  //---------Get All Video Objects from Video Cache Manager Ends---------//

  ///--------------------Delete Cache File using path Starts-----------------//
  static Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
      // print("Deleted: $filePath");
    } else {
      // print("File not found at: $filePath");
    }
  }

  ///--------------------Delete Cache File using path Ends-----------------//
  ///
  static Future<void> clearAllCache() async {
    await VideoCacheManager().emptyCache();
    await DefaultCacheManager().emptyCache();
  }
}
