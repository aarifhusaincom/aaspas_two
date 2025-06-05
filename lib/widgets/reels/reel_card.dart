import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constant_and_api/aaspas_constant.dart';

class ReelCard extends StatelessWidget {
  const ReelCard({
    super.key,
    required this.thumbnailUrl,
    required this.reelIndex,
  });
  final String thumbnailUrl;
  final int reelIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/video_scroll_screen',
          arguments: {'reelIndex': reelIndex},
        );
      },
      child: Card(
        // color: Colors.white,
        elevation: 0,
        clipBehavior: Clip.hardEdge,

        // Image.network(
        //   "${reelsList[index]["thumbnail_url"]}",
        //   errorBuilder: (context, error, stackTrace) {
        //     return Image.asset(
        //       fit: BoxFit.cover,
        //       'assets/images/reelPlaceholder.png',
        //     ); // fallback image
        //   },
        // ),
        child: CachedNetworkImage(
          imageUrl: thumbnailUrl,
          fit: BoxFit.cover,
          errorWidget:
              (context, url, error) =>
                  Image.asset(fit: BoxFit.cover, AaspasImages.reelPlaceholder),
        ),
      ),
    );
  }
}
