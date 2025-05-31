import 'package:geolocator/geolocator.dart';

import '../../constant_and_api/aaspas_constant.dart';
import 'LocationGetterAaspas.dart';

class LocationSetterAaspas {
  static Position? _currentPosition;
  static String error = '';
  static bool locationService = false;

  static Future<void> getLocation() async {
    try {
      final position = await LocationGetterAaspas.determinePosition();
      _currentPosition = position;
      AaspasLocator.lat = _currentPosition?.latitude.toString() ?? "0.00";
      AaspasLocator.long = _currentPosition?.longitude.toString() ?? "0.00";
      /////////////////////////////////////////////////////////////////
      locationService = await Geolocator.isLocationServiceEnabled();
      AaspasLocator.locationService = locationService;
      /////////////////////////////////////////////////////////////////
    } catch (e) {
      error = e.toString();
    }
  }
}
