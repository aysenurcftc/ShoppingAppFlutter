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
        backgroundColor: Colors.grey.shade50,
        title: Center(
          child: Text("Ürün Bilgisi",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            Container(
              width: width,
              height: 150,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 26,bottom: 15,top: 15,),
                    child: Text("En az 3 tane resim yükleyin",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                        child: Container(
                            width: 150,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.shade600,
                                width: 1,
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
                  fontSize: 17,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            Container(
              width: width,
              height: 130,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  maxLength: 50,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "En az 5 karakterli ürün başlığı",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 26,top: 10,bottom: 10),
              child: Text("Ürün Açıklaması",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            Container(
              width: width,
              height: 120,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: SizedBox(
                  height: 200,
                  child: TextField(
                    maxLength: 50,
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Ürün açıklaması",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Colors.white,
                width: width,
                height: 60,
                child: ListTile(
                  title: Row(
                    children: [
                      Text("Kategorisi",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                        color: Colors.grey.shade600,),
                    ],
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                color: Colors.white,
                width: width,
                height: 60,
                child: ListTile(
                  title: Row(
                    children: [
                      Text("Durumu",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                        color: Colors.grey.shade600,),
                    ],
                  ),
                ),
              ),
            ),


            Container(
              width: width,
              height: 100,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Fiyatı",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),




            Padding(
              padding: const EdgeInsets.only(bottom: 25,top: 25),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.pinkAccent, // foreground
                  ),
                  onPressed: () { },
                  child: Text('Tamamla'),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}


