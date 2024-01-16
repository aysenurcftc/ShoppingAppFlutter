

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/providers/wallet_provider.dart';

class myWalletScreen extends StatefulWidget {
  const myWalletScreen({super.key});

  @override
  State<myWalletScreen> createState() => _myWalletScreenState();
}



class _myWalletScreenState extends State<myWalletScreen> {

  late WalletProvider walletProvider;

  @override
  void initState() {
    super.initState();
    walletProvider = Provider.of<WalletProvider>(context, listen: false);
    walletProvider.getWalletData();
  }

  int bakiye = 1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cüzdanım"),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<WalletProvider>(builder: (context, value, widget){
                      return Text("${value.wallet?.price}");
                    },
                    )
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
