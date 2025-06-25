import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant_and_api/aaspas_constant.dart';

class ReelCard extends StatelessWidget {
  const ReelCard({
    super.key,
    required this.thumbnailUrl,
    required this.reelIndex,
    required this.totalViews,
  });
  final String thumbnailUrl;
  final int reelIndex;
  final int totalViews;

  @override
  Widget build(BuildContext context) {
    String formatView(views) {
      if (views >= 10000000000) {
        double cr = views / 10000000000;
        return '${cr.toStringAsFixed(cr.truncateToDouble() == cr ? 0 : 1)} B';
      } else if (views >= 1000000) {
        double lakh = views / 1000000;
        return '${lakh.toStringAsFixed(lakh.truncateToDouble() == lakh ? 0 : 1)} M';
      } else if (views >= 1000) {
        double lakh = views / 1000;
        return '${lakh.toStringAsFixed(lakh.truncateToDouble() == lakh ? 0 : 1)} K';
      } else {
        return views.toString();
      }
    }

    final String convertedViews = formatView(totalViews);

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
        child: Stack(
          children: [
            Image.asset(AaspasImages.reelPlaceholder, fit: BoxFit.cover),
            CachedNetworkImage(
              imageUrl: thumbnailUrl,
              fit: BoxFit.cover,
              errorWidget:
                  (context, url, error) => Image.asset(
                    fit: BoxFit.cover,
                    AaspasImages.reelPlaceholder,
                  ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              // left: 0 , right: 0, This stretches it horizontally
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  gradient: LinearGradient(
                    colors: [Color(0x0), Color(0xff000000)],
                    stops: [0, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    SvgPicture.asset(AaspasIcons.viewWhite),
                    Text(
                      convertedViews,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
