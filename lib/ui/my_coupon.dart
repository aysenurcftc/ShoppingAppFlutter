
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senior_project/service/contrat_service.dart';
import 'package:web3dart/web3dart.dart';
import 'package:crypto/crypto.dart';

class myCouponScreen extends StatefulWidget {
  const myCouponScreen({super.key});

  @override
  State<myCouponScreen> createState() => _myCouponScreenState();
}

class _myCouponScreenState extends State<myCouponScreen> {
  String couponCode = "";
  String? userId;

  late CouponService _couponService;

  @override
  void initState() {
    super.initState();
    getUserId();
    _couponService = CouponService();
  }

  Future<void> getUserId() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  EthereumAddress convertFirebaseUidToEthereumAddress(String uid) {
    // Firebase UID'yi sha3 algoritması kullanarak hash'e çevirme
    List<int> bytes = utf8.encode(uid); // UID'yi UTF-8 formatına çevirme
    Digest digest = sha1.convert(bytes); // SHA3-256 algoritması ile hash hesaplama

    // Hash'i EthereumAddress'e dönüştürme
    String ethereumAddressString = '0x${digest.toString().substring(0, 40)}';
    return EthereumAddress.fromHex(ethereumAddressString);
  }


  Future<void> useCoupon() async {
    if (userId != null) {
      // Firebase UID'yi Ethereum adresine dönüştürün
      EthereumAddress ethereumAddress = convertFirebaseUidToEthereumAddress(userId!);

      try {
        // Dönüştürülmüş Ethereum adresini kullanarak kuponu kullanma işlemini gerçekleştirin
        await _couponService.useCoupon(ethereumAddress.hex);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Coupon used successfully'),
        ));
      } catch (error) {
        print('Error using coupon: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error using coupon'),
        ));
      }
    }
  }

  String generateCouponCode() {
    final Random _random = Random();
    const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    couponCode = String.fromCharCodes(Iterable.generate(18, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
    return couponCode;
  }

  // Function to copy the coupon code to the clipboard
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: couponCode));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Coupon code copied to clipboard'),
    ));
  }

  Future<void> addCouponToUser() async {
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('coupons')
          .add({
        'code': couponCode,
        'created_at': FieldValue.serverTimestamp(),
      })
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Coupon added to your list'),
        ));
      })
          .catchError((error) {
        print('Error adding coupon to user: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error adding coupon to your list'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kuponlarım"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Generate a new coupon code when the button is pressed
                  setState(() {
                    couponCode = generateCouponCode();
                  });
                  addCouponToUser();
                  useCoupon();// Add the coupon to the user's list
                },
                child: Text('Kupon Oluştur'),
              ),
              SizedBox(height: 20),
              Text(
                'Oluşturulan Kupon Kodu:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SelectableText(
                couponCode,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {
                  // Copy the coupon code to the clipboard
                  copyToClipboard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//OL1CD94ICUHWCHA82T