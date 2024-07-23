import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchasesManager {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final productDetails = <ProductDetails>[];
  final Set<String> productId = {};

  InAppPurchase get instance => _inAppPurchase;

  void init(String id) {
    productId.add(id.replaceAll('-', '_'));
    final purchasesUpd = InAppPurchase.instance.purchaseStream;

    purchasesUpd.listen(
      _listenToPurchases,
      onError: (error) => debugPrint(error.toString()),
    );
    _initStore();
  }

  void _listenToPurchases(List<PurchaseDetails> purchases) {
    for (var p in purchases) {
      if (p.status == PurchaseStatus.pending) {
        debugPrint('Pending!!!');
      }
      if (p.status == PurchaseStatus.error) {
        debugPrint('Error!!!');
      }
      if (p.status == PurchaseStatus.purchased) {
        debugPrint('Purchased!!!');
      }
    }
  }

  Future<void> _initStore() async {
    final productsResponse = await _inAppPurchase.queryProductDetails({});
    if (productsResponse.error != null) return;

    productDetails.addAll(productsResponse.productDetails);
  }

  void buy() {
    final product = productDetails.firstOrNull;
    if (product == null) return;
    final params = PurchaseParam(productDetails: product);

    _inAppPurchase.buyConsumable(purchaseParam: params);
  }
}
