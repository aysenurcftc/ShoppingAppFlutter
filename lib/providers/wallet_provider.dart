

import 'package:flutter/material.dart';
import 'package:senior_project/models/wallet.dart';
import 'package:senior_project/service/auth.dart';

class WalletProvider extends ChangeNotifier {
  Wallet? _wallet;

  Wallet? get wallet => _wallet;

  Future<void> getWalletData() async {
    String? userId = await AuthService().getCurrentUserId();
    if (userId != null) {
      Wallet wallet = await AuthService().getWallet(userId);
      _wallet = wallet;
      notifyListeners();
    }
  }



  Future<void> updateWalletBalance(String newBalance) async {
    String? userId = await AuthService().getCurrentUserId();
    if (userId != null) {
      await AuthService().updateWalletBalance(userId, newBalance);
      await getWalletData();
    }
  }
}