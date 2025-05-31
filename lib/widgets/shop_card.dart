import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant_and_api/aaspas_constant.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({
    super.key,
    required this.image,
    required this.shopName,
    required this.shopAddress,
    required this.currentDistance,
    required this.edgeInsets,
  });

  final String image;
  final String shopName;
  final String shopAddress;
  final String currentDistance;
  final EdgeInsets edgeInsets;

  ////
  // Get API

  // Logic in State Ends//
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      child: Container(
        width: double.infinity,
        padding: edgeInsets,
        // color: Colors.purple,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          spacing: 10,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 80,
              height: 80,

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AaspasImages.shopPlaceholder),
                  fit: BoxFit.cover, // covers entire container
                ),
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey,
              ),
              // Image.network(
              //   // width: 80,
              //   // height: 80,
              //   fit: BoxFit.cover,
              //   "${shopsList[index]["bigImageUrl"]}",
              //   errorBuilder: (context, error, stackTrace) {
              //     return Image.asset(
              //       fit: BoxFit.cover,
              //       'assets/images/shopPlaceholder.png',
              //     ); // fallback image
              //   },
              // ),
              child: CachedNetworkImage(
                imageUrl: image,
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
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: 1,
                            shopName,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 58,
                          child: Text(
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            currentDistance,
                            style: TextStyle(
                              // fontFamily: "Roboto aarif",
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF732FCB),
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: 3,
                            shopAddress,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Color(0x88000000),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 58,
                          child: Center(
                            child: SvgPicture.asset(AaspasIcons.direction),
                          ),
                        ),
                      ],
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
