import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

import '../../constant_and_api/aaspas_constant.dart';
import '../../reels/reel_cache.dart';

class PropertyVideoPlayer extends StatefulWidget {
  const PropertyVideoPlayer({super.key});
  @override
  State<PropertyVideoPlayer> createState() => _PropertyVideoPlayerState();
}

class _PropertyVideoPlayerState extends State<PropertyVideoPlayer> {
  VideoPlayerController? _controller;
  Map<String, dynamic>? data;
  late final String video;
  @override
  void initState() {
    super.initState();
    // New Code Invoke
    // initializePlayer(widget.videoUrl ?? '');
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // if (args != null) {
    //   video = args?['video'];
    // }
    // initializePlayer(video);
  }

  // Initialize Video Player with network url or Local File path
  void initializePlayer(String url) async {
    FileInfo? fileInfo = await ReelCache.checkCacheFor(url);
    if (fileInfo == null) {
      // print("(reel ui initializePlayer by init ) Video not found in cache ");
      // print(
      //   "(reel ui initializePlayer by init ) so now video is playing using Network via $url",
      // );
      _controller = VideoPlayerController.networkUrl(Uri.parse(url));
      // await _controller!.setLooping(true);
      _controller!.initialize().then((_) {
        _controller!.setLooping(true);
        _controller!.play();
        setState(() {
          // print("Network run setState() Runs");
        });
        // print(
        //   "(reel ui initializePlayer by init ) And Video Downloading in Cache",
        // );
        ReelCache.downloadInCacheFrom(url);
      });
    } else {
      // print("(reel ui initializePlayer by init ) Cache Found Successfully ");
      File file = fileInfo.file;
      // print("(reel ui initializePlayer by init ) Video playing using Cache ");
      _controller = VideoPlayerController.file(file);
      // await _controller!.setLooping(true);
      _controller!.initialize().then((_) {
        _controller!.setLooping(true);
        _controller!.play();
        setState(() {
          // print("Cache run setState() Runs");
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (data == null) {
      // print("//////////---- 1");
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        // print("//////////---- 2");
        data = args;
        video = data?['video'];
        // print(video);
      }
    }
    initializePlayer(video);
  }

  @override
  Widget build(BuildContext context) {
    // final args =        const ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return _controller != null && _controller!.value.isInitialized
        ? Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: () {
                  if (_controller != null && _controller!.value.isInitialized) {
                    if (_controller!.value.isPlaying) {
                      // The video is currently playing
                      // print('Video is playing');
                      _controller!.pause();
                    } else {
                      _controller!.play();
                      // The video is paused, stopped, or buffering
                      // print('Video is not playing');
                    }
                  } else {
                    // The video controller is not initialized yet
                    // print('Video controller not initialized');
                  }
                  setState(() {});
                },
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Container(
                    width: _controller?.value.size.width,
                    height: _controller?.value.size.height,
                    decoration: BoxDecoration(
                      // color: Colors.yellow,
                      image: DecorationImage(
                        image: AssetImage(AaspasImages.videoPlaceholder),
                        fit: BoxFit.cover, // covers entire container
                      ),
                    ),
                    child: VideoPlayer(_controller!),
                  ),
                ),
              ),
              if (!_controller!.value.isPlaying)
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_controller != null &&
                          _controller!.value.isInitialized) {
                        if (_controller!.value.isPlaying) {
                          // The video is currently playing
                          // print('Video is playing');
                          _controller!.pause();
                        } else {
                          _controller!.play();
                          // The video is paused, stopped, or buffering
                          // print('Video is not playing');
                        }
                      } else {
                        // The video controller is not initialized yet
                        // print('Video controller not initialized');
                      }
                      setState(() {});
                    },
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      color: Color(0xD7FFFFFF),
                      size: 70,
                    ),
                  ),
                ),
            ],
          ),
        )
        : Scaffold(
          body: Center(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(AaspasImages.videoPlaceholder),
                  fit: BoxFit.cover, // covers entire container
                ),
              ),
              // Remove Expanded from here and place it as a child of Column
              child: Column(
                spacing: 20,
                // Column is the direct parent
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Wrap the children that should expand in Expanded
                  SizedBox(height: 130),
                  Text("Loading"),
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
