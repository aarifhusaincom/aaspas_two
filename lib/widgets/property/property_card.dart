import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant_and_api/aaspas_constant.dart';
import '../buttons/custom_button.dart';
import '../cat_type_and_cards/label_card.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.propertyTitle,
    required this.image,
    required this.visualPrice,
    required this.actualPrice,
    required this.totalArea,
    required this.area,
    required this.phoneNo,
    required this.brokerageType,
    required this.city,
    required this.edgeInsets,
  });

  final String propertyTitle;
  final String image;
  final String visualPrice;
  final int actualPrice;
  final int totalArea;
  final String area;
  final String phoneNo;
  final String brokerageType;
  final String city;
  final EdgeInsets edgeInsets;

  //////////////////// function start

  String _formatPrice(int price) {
    final formatter = NumberFormat.decimalPattern('en_IN');

    if (price >= 10000000) {
      double cr = price / 10000000;
      return '${cr.toStringAsFixed(cr.truncateToDouble() == cr ? 0 : 2)} Cr';
    } else if (price >= 100000) {
      double lakh = price / 100000;
      return '${lakh.toStringAsFixed(lakh.truncateToDouble() == lakh ? 0 : 2)} Lakh';
    } else {
      return formatter.format(price);
    }
  }

  //////////////////// function Ends

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

              child:
                  image != "" && image != 'assets/images/shopPlaceholder.png'
                      ? CachedNetworkImage(
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
                      )
                      : Image.asset(
                        AaspasImages.shopPlaceholder,
                        fit: BoxFit.cover,
                        errorBuilder:
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
                  spacing: 1,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      // color: Colors.blueAccent,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              maxLines: 1,
                              '₹ ${_formatPrice(actualPrice)} /-',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: "Roboto",
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // LabelCard(
                          //   decoration: BoxDecoration(
                          //     color: AaspasColors.soft2,
                          //     borderRadius: BorderRadius.circular(4),
                          //   ),
                          //   title: "$totalArea Sqft",
                          //   fontSize: 13,
                          //   horizontalPadding: 10,
                          //   color: AaspasColors.primary,
                          //   bgColor: AaspasColors.soft2,
                          //   spacing: 10,
                          //   showIcon: false,
                          //   iconSize: 15,
                          //   fontWeight: FontWeight.w600,
                          //   widthLabel: 100,
                          // ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AaspasColors.soft2,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            // color: Colors.purple,
                            child: Text(
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              "$totalArea Sqft Area",

                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  // fontFamily: "Roboto aarif",
                                  // fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                  color: AaspasColors.black,
                                  fontSize: 13,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.brown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        propertyTitle,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AaspasColors.textHalfBlack,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      // color: Colors.deepOrange,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // alignment: WrapAlignment.spaceBetween,
                        spacing: double.minPositive,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              // color: Colors.lightGreen,
                              // width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  LabelCard(
                                    decoration: BoxDecoration(
                                      color: AaspasColors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: AaspasColors.grayBorder,
                                      ),
                                    ),
                                    title: area,
                                    // title: "Khajoori Bazar",
                                    fontSize: 12,
                                    horizontalPadding: 10,
                                    verticalPadding: 4,
                                    color: AaspasColors.black,
                                    // bgColor: AaspasColors.soft2,
                                    spacing: 10,
                                    showIcon: false,
                                    iconSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  LabelCard(
                                    decoration: BoxDecoration(
                                      color: AaspasColors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: AaspasColors.grayBorder,
                                      ),
                                    ),
                                    title: brokerageType,
                                    fontSize: 12,
                                    horizontalPadding: 10,
                                    verticalPadding: 4,
                                    color:
                                        brokerageType == "Brokerage"
                                            ? AaspasColors.red
                                            : AaspasColors.green,
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
                            spacing: 3,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            onPressed: () async {
                              // print("WhatsApp Clicked");
                              var url =
                                  'https://api.whatsapp.com/send?phone=91$phoneNo&text=_*Aaspas+Hello*_';
                              // launch(url);
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            svgPicture: SvgPicture.asset(
                              AaspasIcons.whatsappWhite,
                              width: 20,
                            ),
                            fontSize: 14,
                            text: "Chat",
                            // color: Colors.green,
                            decoration: BoxDecoration(
                              color: AaspasColors.green,
                              borderRadius: BorderRadius.circular(6),
                            ),
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
    );
  }
}
