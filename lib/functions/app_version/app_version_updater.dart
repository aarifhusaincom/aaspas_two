import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant_and_api/aaspas_constant.dart';

class AppVersionUpdater {
  static BuildContext? get context => null;

  static Future<bool> isUpdateAvailable(String latestVersion) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String currentVersion = packageInfo.version;

    return _isVersionLessThan(currentVersion, latestVersion);
  }

  static bool _isVersionLessThan(String current, String latest) {
    List<int> currentParts = current.split('.').map(int.parse).toList();
    List<int> latestParts = latest.split('.').map(int.parse).toList();

    for (int i = 0; i < currentParts.length; i++) {
      if (i >= latestParts.length) return false;
      if (currentParts[i] < latestParts[i]) return true;
      if (currentParts[i] > latestParts[i]) return false;
    }

    return currentParts.length < latestParts.length;
  }

  static Future<bool> checkUpdate(String newVersion) async {
    /// "1.3.2"
    bool needsUpdate = await isUpdateAvailable(newVersion);
    if (needsUpdate) {
      print("Update is available");
      return true;
    } else {
      print("App is up-to-date");
      return false;
    }
  }

  static Future<void> sendToUpdaterScreen(BuildContext myContext) async {
    if (AaspasWizard.checkVersionForUpdate) {
      AppVersionUpdater.checkUpdate(AaspasWizard.minAppVersion).then((
        ifUpdateAvailable,
      ) {
        if (ifUpdateAvailable) {
          // if (myContext.mounted) {
          // Check if the widget is still in the tree
          Navigator.popAndPushNamed(myContext, '/app_update_screen');
          // }
        }
      });
    }
  }

  static void openPlayStore() async {
    final Uri playUri = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.aaspas.app',
    );

    if (await canLaunchUrl(playUri)) {
      await launchUrl(
        playUri,
        mode: LaunchMode.externalApplication,
      ); // Opens in Google Maps app or browser
    } else {
      throw 'Could not launch Google Maps.';
    }
  }
}
