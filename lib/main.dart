// import 'dart:convert';
import 'dart:core';
import 'package:aaspas/functions/location/LocationSetterAaspas.dart';
import 'package:aaspas/screens/dummy_class_aarif.dart';
import 'package:aaspas/screens/property_details.dart';
import 'package:aaspas/screens/property_screens/property_video_player.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/image_slider/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../reels/reel_builder.dart';
import '../../screens/cat_item_wise.dart';
import '../../screens/homepage.dart';
import '../../screens/location_permission.dart';
import '../../screens/other_screens/location_denied.dart';
import '../../screens/search_page.dart';
import '../../screens/service_details.dart';
import '../../screens/shop_details.dart';
import 'hive/boxes.dart';
import 'hive/userisold.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),);
//   FlutterNativeSplash.removeAfter(initialization);
//   // await initialized(null);
//   runApp(MyApp());
// }

// void main() {
//   runApp(void main() {
//   runApp(MyApp());
// }
//     MaterialApp(home: Scaffold(body: Center(child: Text('Splash working')))),
//   );
// }
// bool isLocationEnabaled = false;
main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(userisoldAdapter());
  boxBool = await Hive.openBox<userisold>('boolBox');
  // print('////////////////////////////////////////');
  // print(boxBool.get('key_isOld'));
  if (boxBool.get('key_isOld') == null) {
    boxBool.put('key_isOld', userisold(isold: false));
    isOld = boxBool.get('key_isOld');
  }
  isOld = boxBool.get('key_isOld');

  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  //load resource
  // await LocationSetterAaspas.getLocation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primarySwatch: MaterialColor(Colors.blueAccent, swatch),
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      debugShowCheckedModeBanner: false,

      home: isOld!.isold ? Homepage() : LocationPermission(),
      // home: LocationPermission(),
      // home: DummyClassAarif(),
      // home: VideoScrollScreen(),
      // home: SearchPage(),
      // home: ServiceDetails(),
      // home: LocationDenied(),
      // home: ShopDetailsPage(),
      // home: CatItemWise(),
      // home: VideoApp(),
      // home: ShopListScreen(),
      // home: PropertyDetailsPage(),
      routes: {
        '/homepage': (context) => Homepage(),
        '/search_page': (context) => SearchPage(),
        '/shop_details': (context) => ShopDetailsPage(),
        '/video_scroll_screen': (context) => VideoScrollScreen(),
        '/cat_item_wise': (context) => CatItemWise(),
        '/service_details': (context) => ServiceDetails(),
        '/location_permission': (context) => LocationPermission(),
        '/location_denied': (context) => LocationDenied(),
        '/image_slider': (context) => ImageSlider(),
        '/property_details': (context) => PropertyDetailsPage(),
        '/property_video_player': (context) => PropertyVideoPlayer(),
        // '/search_focused': (context) => ShopDetails(),
        // '/search_typed': (context) => ShopDetails(),
      },
    );
  }
}
