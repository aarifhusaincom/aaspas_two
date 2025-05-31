import 'package:aaspas/functions/location/LocationGetterAaspas.dart';
import 'package:aaspas/functions/location/LocationSetterAaspas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant_and_api/aaspas_constant.dart';
import '../hive/boxes.dart';
import '../hive/userisold.dart';

class LocationPermission extends StatefulWidget {
  const LocationPermission({super.key});

  @override
  State<LocationPermission> createState() => _LocationPermissionState();
}

class _LocationPermissionState extends State<LocationPermission> {
  bool circleFlag = true;
  Future<void> freshLocation() async {
    boxBool.put('key_isOld', userisold(isold: true));
    circleFlag = false;
    setState(() {});
    await LocationSetterAaspas.getLocation();
    circleFlag = LocationSetterAaspas.locationService;
    //////////////
    if (circleFlag) {
      Navigator.popAndPushNamed(context, '/homepage');
      // Navigator.popAndPushNamed(context, '/property_sale_details');
    }
    print("Location ${AaspasLocator.lat}");
    print("Location ${LocationSetterAaspas.locationService}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AaspasImages.threeDLocation).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Black Gradient
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0, 1],
                  end: Alignment(0.5, -0.3),
                  begin: Alignment(0.5, 0.32),
                  colors: [Color(0xFF000000), Color(0x80000000)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Please let us know \n Where you are ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AaspasColors.white,
                      ),
                    ),
                  ),
                  Text(
                    "We provide the location and contacts of nearest shops and services to you and always give the desired result based on your current location, for that we have to check your precise location provided by the your device to calculate the exact distance and nearest area. By accept you can give the permission to access your current location.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AaspasColors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Tap on “I Accept” if you are okay to give us permission to access your current location and accept our ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AaspasColors.textDeactivated,
                      ),
                    ),
                  ),
                  Row(
                    spacing: 6,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          // print("Privacy Policy Clicked");
                          var url = 'https://aaspas-privacypolicy.aaspas.app/';
                          // launch(url);
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                        child: Text(
                          "Privacy Policy",
                          textAlign: TextAlign.center,

                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: AaspasColors.green,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationColor: AaspasColors.green,
                              decorationThickness: 2,

                              // textBaseline: TextBaseline.ideographic,
                              // decorationStyle: TextDecorationStyle.dotted,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.open_in_new, color: AaspasColors.white),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FilledButton(
                      onPressed: freshLocation,
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // 👈 Adjust corner radius here
                          ),
                        ),
                        // maximumSize: WidgetStateProperty.all(Size(200, 50)),
                        alignment: Alignment.center,
                        textStyle: WidgetStateProperty.all(
                          GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          AaspasColors.primary,
                        ),
                      ),
                      child:
                          circleFlag
                              ? const Text('I Accept')
                              : CircularProgressIndicator(
                                color: AaspasColors.white,
                                constraints: BoxConstraints(
                                  minWidth: 24,
                                  minHeight: 24,
                                ),
                              ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
