import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context);
    final double height = screenSize.size.height;
    final double width = screenSize.size.width;


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            color: Colors.grey.shade50,
            child: Text("Ürün Bilgisi",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26,top: 10,bottom: 10),
              child: Text("Fotoğraflar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            Container(
              width: width ,
              height: 200,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 26,bottom: 15,top: 15),
                    child: Text("En az 3 tane resim yükleyin",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),),
                  ),

                  Row(

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.white, // Container rengi
                              borderRadius: BorderRadius.circular(20), // Köşeleri yuvarlaklaştırma
                              border: Border.all(
                                color: Colors.grey.shade600,// Kenar çizgisi rengi
                                width: 1, // Kenar çizgisi kalınlığı
                              ),
                            ),
                            child: Icon(Icons.add,
                              color:Colors.grey.shade600, )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 26,top: 10,bottom: 10),
              child: Text("Ürün Başlığı",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            Container(
              width: width,
              height: 100,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  maxLength: 5,
                  decoration: InputDecoration(
                    hintText: "En az 5 karakterli ürün başlığı",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 26,top: 10,bottom: 10),
              child: Text("Ürün Açıklaması",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            Container(
              width: width,
              height: 100,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  maxLength: 50,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "En az 5 karakterli ürün başlığı",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
