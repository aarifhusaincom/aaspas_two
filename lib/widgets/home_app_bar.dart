import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant_and_api/aaspas_constant.dart';
import 'buttons/custom_button.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  ////
  String location = "Khajrana Indore";
  String flexibleSpaceImage = "https://picsum.photos/600";
  double listHeight = 80;
  @override
  void initState() {
    super.initState();
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
        AaspasStrings.appName,
        style: GoogleFonts.sansita(
          textStyle: TextStyle(
            fontSize: 28,
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
                    var url = AaspasStrings.whatsappHelp;
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
