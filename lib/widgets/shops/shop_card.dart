import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant_and_api/aaspas_constant.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({
    super.key,
    required this.image,
    required this.shopName,
    required this.shopAddress,
    required this.currentDistance,
    required this.edgeInsets,
    required this.locLat,
    required this.locLong,
    this.onTap,
    required this.onDirectionTap,
  });

  final String image;
  final String locLat;
  final String locLong;
  final String shopName;
  final String shopAddress;
  final String currentDistance;
  final EdgeInsets edgeInsets;
  final VoidCallback? onTap;
  final void Function({required String lat1, required String long1})?
  onDirectionTap;

  ////
  // Get API

  // Logic in State Ends//
  @override
  Widget build(BuildContext context) {
    print("/////// - image value in shop card widget");
    print(image);
    // print(
    //   "/////// - image == null || image == "
    //   "",
    // );
    print(image == null || image == "");
    print(image == null);
    return InkWell(
      onTap: onTap,
      child: Card(
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
                // uncomment this if you want to use cached network image
                child: CachedNetworkImage(
                  imageUrl:
                      (image == null || image == "")
                          ? AaspasWizard.shopAltImage
                          : image,
                  // image ?? AaspasWizard.shopAltImage,
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
                          InkWell(
                            onTap: () {
                              // You can pass actual lat/long values from the shop model here
                              if (onDirectionTap != null) {
                                onDirectionTap!(
                                  lat1: locLat,
                                  long1: locLong,
                                ); // Example lat/long
                              }
                            },
                            child: SizedBox(
                              width: 58,
                              child: Center(
                                child: SvgPicture.asset(AaspasIcons.direction),
                              ),
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
      ),
    );
  }
}
