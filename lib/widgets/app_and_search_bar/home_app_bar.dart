import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../constant_and_api/aaspas_constant.dart';
import '../../functions/location/LocationSetterAaspas.dart';
import '../../functions/wizard.dart';
import '../../model/wizard_model.dart';
import '../buttons/custom_button.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  ////

  String flexibleSpaceImage = "https://picsum.photos/600";
  double listHeight = 80;
  String location = "Fetching Location...";

  Future<String> getUserArea() async {
    final response1 = await http.get(Uri.parse(AaspasStrings.wizardUrl));
    String baseUrl = "";

    if (response1.statusCode == 200) {
      final jsonData = json.decode(response1.body);
      final model = WizardModel.fromJson(jsonData);
      baseUrl = model.api!.baseUrl!;
    }
    final String paramString =
        '?lat=${AaspasLocator.lat}&lng=${AaspasLocator.long}';
    final url = '${baseUrl}${AaspasWizard.getUserArea}$paramString';
    print("//homebarurl");
    print(url);
    final response2 = await http.get(Uri.parse(url));
    print("response.statusCode");
    print(response2.statusCode);
    print(AaspasWizard.baseUrl);

    if (response2.statusCode == 200) {
      final jsonData = json.decode(response2.body);
      print("/////homebar");
      print("${jsonData['area']}, ${jsonData['city']}");
      return "${jsonData['area']}, ${jsonData['city']}";
    } else {
      return '';
    }
  }

  void fetchUserArea() async {
    final area = await getUserArea();
    setState(() {
      location = area;
    });
  }

  @override
  void initState() {
    super.initState();
    LocationSetterAaspas.getLocation().then((e) {
      fetchUserArea();
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // toolbarHeight: 180,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(color: Colors.white),
      ),

      title: Text(
        AaspasWizard.appName,
        style: GoogleFonts.sansita(
          textStyle: TextStyle(
            fontSize: AaspasWizard.appNameFontSize.toDouble(),
            letterSpacing: 2.0,
            color: AaspasColors.primary,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      // centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 6,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 6,
                children: [
                  SvgPicture.asset(AaspasIcons.mapIcon),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 12,
                      color: AaspasColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                // width: 100,
                // height: 36,
                // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                // decoration: BoxDecoration(
                //   color: AaspasColors.soft2,
                //   borderRadius: BorderRadius.all(Radius.circular(8)),
                // ),
                child: CustomButton(
                  onPressed: () async {
                    print("WhatsApp Clicked");
                    var url = AaspasWizard.whatsAppHelp;
                    // launch(url);
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  svgPicture: SvgPicture.asset(AaspasIcons.whatsapp1),
                  text: AaspasStrings.help,
                  textColor: AaspasColors.primary,
                  fontSize: 12,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: AaspasColors.soft2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   spacing: 6,
                //   children: [
                //     SizedBox(
                //       width: 20,
                //       height: 20,
                //       child: SvgPicture.asset(AaspasIcons.whatsapp1),
                //     ),
                //     Text(
                //       AaspasStrings.help,
                //       style: TextStyle(
                //         fontSize: 12,
                //         color: AaspasColors.primary,
                //         fontWeight: FontWeight.w700,
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
