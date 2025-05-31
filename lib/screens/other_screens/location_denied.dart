import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant_and_api/aaspas_constant.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationDenied extends StatefulWidget {
  const LocationDenied({super.key});

  @override
  State<LocationDenied> createState() => _LocationDeniedState();
}

class _LocationDeniedState extends State<LocationDenied> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AaspasColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(44.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              spacing: 44,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AaspasStrings.appName,
                  style: GoogleFonts.sansita(
                    textStyle: TextStyle(
                      fontSize: 58,
                      letterSpacing: 2.0,
                      color: AaspasColors.primary,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                    border: Border.all(color: Color(0xFFD2D2D2), width: 1),
                  ),
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Column(
                    spacing: 16,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Turn on location permission",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              height: 1.2,
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: AaspasColors.black,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Please go to Settings -> Location to turn on Location permission",
                        textAlign: TextAlign.start,

                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            height: 1.2,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AaspasColors.textHalfBlack,
                          ),
                        ),
                      ),

                      FilledButton(
                        onPressed: () async {
                          bool opened = await openAppSettings();
                          if (!opened) {
                            // Handle failure to open settings
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(
                            Size(double.infinity, 50),
                          ),
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
                        child: const Text('App Settings'),
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
