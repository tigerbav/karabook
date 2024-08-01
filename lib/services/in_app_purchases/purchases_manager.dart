import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesManager {
  static final PurchasesManager shared = PurchasesManager._();
  PurchasesManager._();

  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.info);

    final PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration('goog_vcYgapPyptXdnjmCvaviJidnTIm');
    } else {
      configuration =
          PurchasesConfiguration('appl_IQgMSbiDcXQWDakqTsoBDTeeijI');
    }
    await Purchases.configure(configuration);
  }

  Future<Offering?> fetch(String id) async {
    try {
      final offerings = await Purchases.getOfferings();
      return offerings.getOffering(id);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> buy(Package package) async {
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      final identifier = package.storeProduct.identifier;
      if (customerInfo.entitlements.all[identifier]?.isActive == true) {
        return true;
      }
      return false;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint(errorCode.toString());
      }
      return false;
    }
  }

  Future<bool> check(String id) async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[id]?.isActive == true;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<CustomerInfo?> restorePurchase() async {
    try {
      return await Purchases.restorePurchases();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
