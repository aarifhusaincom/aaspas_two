import 'dart:ui';

import 'package:aaspas/constant_and_api/aaspas_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopCardOnReel extends StatelessWidget {
  const ShopCardOnReel({
    super.key,
    required this.shopId,
    required this.shopImage,
    required this.shopName,
    required this.address,
    this.views = 0,
  });
  final String shopId;
  final String shopImage;
  final String shopName;
  final String address;
  final int views;

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

    final String convertedViews = formatView(views);

    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            padding: EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Color(0x4D848484),
              borderRadius: BorderRadius.circular(10),
            ),
            // width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 10,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: AssetImage(AaspasImages.shopPlaceholder),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: shopImage,
                    fit: BoxFit.cover,
                    // progressIndicatorBuilder:
                    //     (context, url, downloadProgress) =>
                    //         CircularProgressIndicator(
                    //           color: Colors.purple,
                    //           value: downloadProgress.progress,
                    //         ),
                    errorWidget:
                        (context, url, error) => Image.asset(
                          fit: BoxFit.cover,
                          AaspasImages.shopPlaceholder,
                        ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              shopName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: AaspasColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: AaspasColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6,
                        children: [
                          Text(
                            convertedViews,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: AaspasColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SvgPicture.asset(AaspasIcons.viewWhite),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
