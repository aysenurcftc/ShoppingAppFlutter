
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/models/purchased.dart';
import 'package:senior_project/providers/basket_provider.dart';
import 'package:senior_project/providers/purchased_provider.dart';
import 'package:senior_project/providers/wallet_provider.dart';
import 'package:senior_project/service/auth.dart';
import 'package:senior_project/service/product_service.dart';

class ShoppingBasketScreen extends StatefulWidget {



  @override
  State<ShoppingBasketScreen> createState() => _ShoppingBasketScreenState();
}

class _ShoppingBasketScreenState extends State<ShoppingBasketScreen> {

  final AuthService authService = AuthService();
  int _selectedIndex = 0;
  bool deleteItem = false;

  var toplam = 0.0;

  late String? userId;

  int count = 1;





  Future<void> fetchData() async {
    userId = await authService.getCurrentUserId();
  }

  late WalletProvider walletProvider;

  @override
  void initState() {
    super.initState();
    walletProvider = Provider.of<WalletProvider>(context, listen: false);
    walletProvider.getWalletData();
    fetchData();
  }




  Future<void> _onItemTapped(int index) async {


    if (index == 1) {
      double basketTotal = toplam;
      WalletProvider walletProvider =
      Provider.of<WalletProvider>(context, listen: false);
      double currentBalance = double.parse(walletProvider.wallet?.price ?? "0");

      if (currentBalance >= basketTotal) {
        await walletProvider.updateWalletBalance(
            (currentBalance - basketTotal).toString());


        Provider.of<BasketProvider>(context, listen: false)
            .basketItems
            .forEach((basketItem) async {

          int remainingQuantity =  int.parse(basketItem.productQuantity) - basketItem.count;
          await ProductService().updateProductQuantity(basketItem.productId, remainingQuantity);

          PurchasedItem purchasedItem = PurchasedItem(
            title: basketItem.title,
            productId : basketItem.productId,
            category: basketItem.category,
            price: double.parse(basketItem.price) * basketItem.count,
            image: basketItem.image,
            productQuantity: basketItem.productQuantity,
            count : basketItem.count,
          );

          Provider.of<PurchasedItemsProvider>(context, listen: false).addPurchasedItem(purchasedItem, userId!);

        });

        Provider.of<BasketProvider>(context, listen: false).clearBasket();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sepet onaylandı"),
          ),
        );
      }

      else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Yetersiz bakiye!"),
          ),
        );
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Sepetim"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
           Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<BasketProvider>(
        builder: (context, basketProvider, child) {
          if (basketProvider.basketItems.isEmpty) {
            toplam = 0.0;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Sepetiniz Boş"),
              ),
            );
          }

          toplam = basketProvider.basketItems
              .map((item) => double.parse(item.price) * item.count)
              .reduce((value, element) => value + element);


          return Column(
            children: [
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: basketProvider.basketItems.length,
                  itemBuilder: (context, index) {
                    var item = basketProvider.basketItems[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.network(
                          item.image,
                          width: 60.0,
                          height: 80.0,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(item.category),
                            Text("${item.price}₺"),
                            Row(
                              children: [
                                Text("ürün miktarı: ${item.count}"),
                                IconButton(
                                    onPressed: (){
                                      if (item.count < int.parse(item.productQuantity)) {
                                        setState(() {
                                          basketProvider.incrementItemCount(index);
                                        });
                                      } else {

                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                           content: Text("Ürün miktarı aşıldı!"),  ));
                                      }

                                    },
                                    icon: Icon(Icons.add)
                                ),

                                Padding(
                                  padding: EdgeInsets.only(bottom: 15,left: 1),
                                  child: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          if (item.count > 1) {
                                            basketProvider.decrementItemCount(index);

                                          }
                                        });

                                      },
                                      icon: Icon(Icons.minimize)
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            toplam -= double.parse(item.price);
                            basketProvider.removeFromBasket(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 10),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Toplam:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '${toplam.toStringAsFixed(2)}₺',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),


      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_ios),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Sepeti Onayla',
            backgroundColor: Colors.pinkAccent,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}