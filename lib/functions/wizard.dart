import 'dart:convert';

import 'package:aaspas/constant_and_api/aaspas_constant.dart';
import 'package:aaspas/model/wizard_model.dart';
import 'package:http/http.dart' as http;

class Wizard {
  static Future<void> setWizardIntoConstant() async {
    final response = await http.get(Uri.parse(AaspasStrings.wizardUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final model = WizardModel.fromJson(jsonData);

      //// set generalInfo
      AaspasWizard.appName = model.generalInfo!.appName!;
      AaspasWizard.appNameFontSize = model.generalInfo!.appNameFontSize!;
      AaspasWizard.platform = model.generalInfo!.platform!;
      AaspasWizard.checkVersionForUpdate =
          model.generalInfo!.checkVersionForUpdate!;
      AaspasWizard.minAppVersion = model.generalInfo!.minAppVersion!;
      AaspasWizard.itemTypeVisible = model.generalInfo!.itemTypeVisible!;
      AaspasWizard.cardVisibleOnReel = model.generalInfo!.cardVisibleOnReel!;
      AaspasWizard.orientationLock = model.generalInfo!.orientationLock!;

      //// set appStrings
      AaspasWizard.whatsAppHelp = model.appStrings!.whatsAppHelp!;
      AaspasWizard.newVersionLink = model.appStrings!.newVersionLink!;
      AaspasWizard.userWhatsAppBaseUrl = model.appStrings!.userWhatsAppBaseUrl!;
      AaspasWizard.userDynamicMsg = model.appStrings!.userDynamicMsg!;
      AaspasWizard.searchPlaceholder = model.appStrings!.searchPlaceholder!;
      AaspasWizard.propertyChatSuffix = model.appStrings!.propertyChatSuffix!;

      //// set api base urls
      AaspasWizard.androidUrl = model.api!.androidUrl!;
      AaspasWizard.webUrl = model.api!.webUrl!;
      AaspasWizard.baseUrl = model.api!.baseUrl!;

      //// set api user url part
      AaspasWizard.getAllShops = model.api!.user!.getAllShops!;
      AaspasWizard.getShopsByCategory = model.api!.user!.getShopsByCategory!;
      AaspasWizard.getShopsByItem = model.api!.user!.getShopsByItem!;
      AaspasWizard.getRelatedShops = model.api!.user!.getRelatedShops!;
      AaspasWizard.getAllCategories = model.api!.user!.getAllCategories!;
      AaspasWizard.getShopsDetailsById = model.api!.user!.getShopsDetailsById!;
      AaspasWizard.getShopsCatItems = model.api!.user!.getShopsCatItems!;
      AaspasWizard.getServicesByCategory =
          model.api!.user!.getServicesByCategory!;
      AaspasWizard.getServicesDetailsById =
          model.api!.user!.getServicesDetailsById!;
      AaspasWizard.getPropertiesByCategoryId =
          model.api!.user!.getPropertiesByCategoryId!;
      AaspasWizard.getPropertyByID = model.api!.user!.getPropertyByID!;
      AaspasWizard.getAllReels = model.api!.user!.getAllReels!;
      AaspasWizard.getUserArea = model.api!.user!.getUserArea!;
      AaspasWizard.shopAltImage = model.api!.user!.shopAltImage!;
    }
  }
}
