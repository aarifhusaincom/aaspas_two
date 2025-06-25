import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant_and_api/aaspas_constant.dart';
import '../buttons/custom_button.dart';
import '../cat_type_and_cards/label_card.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.image,
    required this.providerName,
    required this.area,
    required this.categoryName,
    required this.charges,
    required this.edgeInsets,
    this.onTap,
  });

  final String image;
  final String providerName;
  final String area;
  final String categoryName;
  final String charges;
  final EdgeInsets edgeInsets;
  final VoidCallback? onTap;

  ////
  // Get API

  // Logic in State Ends//
  @override
  Widget build(BuildContext context) {
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
                    spacing: 6,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              providerName,
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
                              "₹ $charges /-",
                              style: TextStyle(
                                // fontFamily: "Roboto aarif",
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: AaspasColors.black,
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 48,
                        // color: Colors.deepOrange,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    LabelCard(
                                      decoration: BoxDecoration(
                                        color: AaspasColors.soft2,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      title: categoryName,
                                      fontSize: 12,
                                      horizontalPadding: 10,
                                      color: AaspasColors.black,
                                      // bgColor: AaspasColors.soft2,
                                      spacing: 10,
                                      showIcon: false,
                                      iconSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    LabelCard(
                                      decoration: BoxDecoration(
                                        color: AaspasColors.soft2,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      title: area,
                                      fontSize: 12,
                                      horizontalPadding: 10,
                                      color: AaspasColors.black,
                                      // bgColor: AaspasColors.soft2,
                                      spacing: 10,
                                      showIcon: false,
                                      iconSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomButton(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              fontSize: 14,
                              textColor: AaspasColors.primary,
                              svgPicture: SvgPicture.asset(AaspasIcons.call),
                              text: "Call",
                              decoration: BoxDecoration(
                                color: AaspasColors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AaspasColors.primary,
                                  width: 1,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
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
