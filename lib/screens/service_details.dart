import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/appbar_only_back.dart';

import '../constant_and_api/aaspas_constant.dart';
import '../widgets/buttons/custom_button.dart';
import '../widgets/label_card.dart';
import '../widgets/shops/services_list_sliver.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({super.key});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  ///////////////////////////////////////////////
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ////////////////////////////////////////////////
  var servicesDetailsJson;
  ////////
  String karigarName = "";
  String catName = "";
  String area = "";
  String minCharge = "";
  String age = "";
  String description = "";
  String imgUrl = "";
  String phone = "";
  /////////////////////////////////////////////////////////////
  Future<void> getShopsCatItems() async {
    final url = AaspasApi.getServicesDetailsById;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        servicesDetailsJson = jsonData['items'][0];

        karigarName = servicesDetailsJson['karigar_name'].toString();
        imgUrl = servicesDetailsJson['image'].toString();
        catName = servicesDetailsJson['categoryName'].toString();
        area = servicesDetailsJson['area'].toString();
        minCharge = servicesDetailsJson['charges'].toString();
        age = servicesDetailsJson['age'].toString();
        description = servicesDetailsJson['description'].toString();
        phone = servicesDetailsJson['phoneNo'].toString();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShopsCatItems();
  }

  /////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    if (servicesDetailsJson == null) {
      return Scaffold(body: const Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: AaspasColors.white,
      appBar: AppbarOnlyBack(title: "Service Details"),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                spacing: 70,
                children: [
                  Container(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    height: 200,
                    width: double.infinity,
                    // color: Colors.purple,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.purple,
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://github.com/aarifhusainwork/aaspas-storage-assets/blob/main/TempImages/electricianbg.png?raw=true",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 42),
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x99000000),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${servicesDetailsJson['categoryName']}",

                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                                color: AaspasColors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 120,
                          width: 120,
                          bottom: -60,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              // color: Colors.green,
                              borderRadius: BorderRadius.circular(17),
                              border: Border.all(
                                color: AaspasColors.white,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  AaspasImages.servicesPlaceholder,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: CachedNetworkImage(imageUrl: imgUrl),
                            ),
                          ),
                        ),

                        // Container(
                        //   width: 30,
                        //   height: 20,
                        //   color: Colors.indigoAccent,
                        // ),
                      ],
                    ),
                  ),
                  // Starting Name and all
                  Column(
                    spacing: 12,
                    children: [
                      // Karigar
                      SizedBox(
                        child: Text(
                          karigarName,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: AaspasColors.black,
                            ),
                          ),
                        ),
                      ),
                      // Halwai , Khajrana , copy , share
                      SizedBox(
                        height: 50,
                        // color: AaspasColors.softAccentBg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                LabelCard(
                                  decoration: BoxDecoration(
                                    color: AaspasColors.soft2,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  title: catName,

                                  fontSize: 13,
                                  horizontalPadding: 10,
                                  color: AaspasColors.black,
                                  bgColor: AaspasColors.soft2,
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
                                  title: "Khajrana",
                                  fontSize: 13,
                                  horizontalPadding: 10,
                                  color: AaspasColors.black,
                                  bgColor: AaspasColors.soft2,
                                  spacing: 10,
                                  showIcon: false,
                                  iconSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              spacing: 22,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.copy_all_outlined,
                                  size: 25,
                                  color: AaspasColors.primary,
                                ),
                                LabelCard(
                                  decoration: BoxDecoration(
                                    color: AaspasColors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  title: "Share",
                                  fontSize: 15,
                                  horizontalPadding: 10,
                                  color: AaspasColors.primary,
                                  bgColor: AaspasColors.white,
                                  spacing: 10,
                                  showIcon: true,
                                  iconPath: AaspasIcons.shareShop,
                                  iconSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // call WhatsApp
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                              onPressed: () async {
                                // print("Call Clicked");
                                final Uri dialUri = Uri(
                                  scheme: 'tel',
                                  path: phone,
                                );
                                if (await canLaunchUrl(dialUri)) {
                                  await launchUrl(dialUri);
                                } else {
                                  // Handle error
                                  print("Could not launch dialer");
                                }
                              },
                              textColor: AaspasColors.primary,
                              constraints: BoxConstraints(minWidth: 120),
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
                            ),
                            CustomButton(
                              onPressed: () async {
                                // print("WhatsApp Clicked");
                                var url =
                                    'https://api.whatsapp.com/send?phone=91$phone&text=_*Aaspas+Hello*_';
                                // launch(url);
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              svgPicture: SvgPicture.asset(
                                AaspasIcons.whatsappWhite,
                              ),
                              text: "WhatsApp",
                              // color: Colors.green,
                              decoration: BoxDecoration(
                                color: AaspasColors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Age , Min Charge
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              spacing: 6,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Age - ",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AaspasColors.textHalfBlack,
                                    ),
                                  ),
                                ),
                                Text(
                                  "$age Years",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AaspasColors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 6,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Min Charge - ",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AaspasColors.textHalfBlack,
                                    ),
                                  ),
                                ),
                                Text(
                                  "₹ $minCharge /-",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AaspasColors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Description
                      Container(
                        alignment: Alignment.centerLeft,
                        // width: double.infinity,
                        child: Text(
                          description,
                          maxLines: 5,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              height: 1.2,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AaspasColors.textHalfBlack,
                            ),
                          ),
                        ),
                      ),
                      // Sliver Heading Other Halwai in Khajrana
                      Container(
                        alignment: Alignment.centerLeft,
                        // color: Colors.purple,
                        child: Text(
                          "Other $catName in $area",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(),
                ],
              ),
            ),
          ),
          ServicesListSliver(id: servicesDetailsJson['_id'].toString()),
        ],
      ),
    );
  }
}
