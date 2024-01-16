
import 'package:flutter/material.dart';

class myCouponScreen extends StatefulWidget {
  const myCouponScreen({super.key});

  @override
  State<myCouponScreen> createState() => _myCouponScreenState();
}

class _myCouponScreenState extends State<myCouponScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kuponlarım"),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
