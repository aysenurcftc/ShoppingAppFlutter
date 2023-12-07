
import 'package:flutter/material.dart';

class ShoppingBasketScreen extends StatefulWidget {

  final String image;
  final String productTitle;
  final String productPrice;
  final String description;
  final String condition;
  final String category;
  final String size;
  late bool isLiked;
  final String uid;

  ShoppingBasketScreen(this.image, this.productTitle, this.productPrice, this.description,this.condition,
      this.category, this.size, this.isLiked, this.uid);




  @override
  State<ShoppingBasketScreen> createState() => _ShoppingBasketScreenState();
}

class _ShoppingBasketScreenState extends State<ShoppingBasketScreen> {


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sepetim"),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Arkaplan rengi
              borderRadius: BorderRadius.circular(15.0), // Kenarların oval olması için
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Gölge rengi
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Gölge konumu (x, y)
                ),
              ],
            ),

            child: ListTile(
              leading: Image.network(widget.image,
                width: 60.0, // Resim genişliği
                height: 80.0, // Resim yüksekliği
                ),
              title: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                  Text(widget.category),
                  Text("${widget.productPrice}₺"),
                ],
              ),
              trailing: Icon(Icons.restore_from_trash),
            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_downward),
            label: "Toplam: ${widget.productPrice}₺ ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Ödemeye Geç',
            backgroundColor: Colors.pinkAccent
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
