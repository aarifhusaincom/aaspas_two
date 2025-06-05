import 'package:flutter/material.dart';
import '../../reels/reel_cache.dart';
import '../../reels/reel_ui.dart';

import '../constant_and_api/aaspas_constant.dart';
import '../functions/location/LocationSetterAaspas.dart';

class VideoScrollScreen extends StatefulWidget {
  const VideoScrollScreen({super.key, this.reelNumber = 0});
  final int reelNumber;

  @override
  State<VideoScrollScreen> createState() => _VideoScrollScreenState();
}

class _VideoScrollScreenState extends State<VideoScrollScreen> {
  // int scrollPages = 1;
  // bool _isLoading = true;

  late PageController _pageController;
  // static List<String> videos = [];

  // //////////////////////////////////////////////////////////// //

  //-------- initState --------Start//
  @override
  void initState() {
    super.initState();
    // ReelCache.currentPage = widget.reelNumber;
    // ReelCache.fetchVideos()
    //     .then((fetchedVideos) {
    //       setState(() {
    //         ReelCache.videos = fetchedVideos;
    //         // _isLoading = false; // Set to false when data is load
    //         // print(
    //         //   "(reel builder init nextTwoVideosDownload() downloading 2 videos) ",
    //         // );
    //         ReelCache.nextTwoVideosDownload(widget.reelNumber);
    //       });
    //     })
    //     .catchError((error) {
    //       // Handle error appropriately, maybe show an error message
    //       setState(() {
    //         // _isLoading = false; // Also set to false on error
    //       });
    //     });
    // _pageController = PageController(initialPage: widget.reelNumber);
  }

  //-------- initState --------End//
  //-------- didChangeDependencies --------Start//
  dynamic data;
  int? reelIndex;
  @override
  void didChangeDependencies() {
    LocationSetterAaspas();
    print("/////////////// didChangeDependencies called");
    if (data == null) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        data = args;
        reelIndex = data?['reelIndex'];

        ///////// init thing in didchangedepend
        ReelCache.currentPage = reelIndex!;
        ReelCache.fetchVideos()
            .then((fetchedVideos) {
              setState(() {
                ReelCache.videos = fetchedVideos;
                // _isLoading = false; // Set to false when data is load
                // print(
                //   "(reel builder init nextTwoVideosDownload() downloading 2 videos) ",
                // );
                ReelCache.nextTwoVideosDownload(reelIndex!);
              });
            })
            .catchError((error) {
              // Handle error appropriately, maybe show an error message
              setState(() {
                // _isLoading = false; // Also set to false on error
              });
            });
        _pageController = PageController(initialPage: reelIndex!);
        ///////// init thing in didchangedepend
      }
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  //-------- didChangeDependencies --------Ends//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ReelCache.videos.isEmpty
              // _isLoading
              // ? Center(child: CircularProgressIndicator())
              ? Center(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAD2FF),
                    image: DecorationImage(
                      image: AssetImage(AaspasImages.videoPlaceholder),
                      fit: BoxFit.cover, // covers entire container
                    ),
                  ),
                ),
              )
              : PageView.builder(
                onPageChanged: ReelCache.onPageChangeFunction,
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: ReelCache.videos.length,
                itemBuilder: (context, index) {
                  return VideoPlayerItem(videoUrl: ReelCache.videos[index]);
                },
              ),
    );
  }

  @override
  void dispose() {
    // ReelCache.clearAllCache();
    _pageController.dispose();
    super.dispose();
  }
}
