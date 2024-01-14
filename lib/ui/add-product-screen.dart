

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senior_project/ui/categories/categories_secreen.dart';
import 'package:senior_project/ui/categories/size_screen.dart';
import 'package:senior_project/ui/categories/state_screen.dart';
import 'package:senior_project/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../service/product_service.dart';

class AddProductScreen extends StatefulWidget {


  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}



class _AddProductScreenState extends State<AddProductScreen> {

  Uint8List? files;


  ProductService firestoreService = ProductService();



  var selected;
  var selectedOption;
  var selectedSize;

  var productTitleController = TextEditingController();
  var productExpController = TextEditingController();
  var productPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productTitleController = TextEditingController();
    productExpController = TextEditingController();
    productPriceController = TextEditingController();
  }


  @override
  void dispose() {
    productTitleController.dispose();
    productExpController.dispose();
    productPriceController.dispose();
    super.dispose();
  }


  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: Text("Resim yükle"),
        children: [

          SimpleDialogOption(
            padding: EdgeInsets.all(5),
            child: Text("Resim çek"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera,);
              setState(() {
                files = file;
              });
            },
          ),


          SimpleDialogOption(
            padding: EdgeInsets.all(5),
            child: Text("Galeriden resim seç"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery,);
              setState(() {
                files = file;
              });
            },
          ),

          SimpleDialogOption(
            padding: EdgeInsets.all(5),
            child: Text("Çık"),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          )

        ],
      );
    }
    );
  }


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
              height: 230,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 26,bottom: 15,top: 15,),
                    child: Text("Resim yükleyin",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),


                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                        child: GestureDetector(
                          onTap: (){
                            _selectImage(context);
                            print("fis $files");
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.shade600,
                                width: 1,
                              ),
                            ),
                            child: files != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                files!,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 55,
                              ),
                            )
                                : Icon(
                              Icons.add,
                              color: Colors.grey.shade600,
                            ),
                          ),

                        ),
                      )
                    ],
                  ),

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
                  controller: productTitleController,
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
                    controller: productExpController,
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
                child: GestureDetector(
                  onTap: () async{
                    var selectedCategory = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoriesScreen()),
                    );
                    selected = selectedCategory;
                  },
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
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: Container(
                color: Colors.white,
                width: width,
                height: 60,
                child: GestureDetector(
                  onTap: () async{
                    var selectedOptions = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StateScreen()),
                    );
                    selectedOption= selectedOptions;
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        Text("Kullanım Durumu",
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
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: Container(
                color: Colors.white,
                width: width,
                height: 60,
                child: GestureDetector(
                  onTap: () async{
                    var selectedOptions = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SizeScreen()),
                    );
                    selectedSize= selectedOptions;
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        Text("Bedeni",
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
            ),






            Container(
              width: width,
              height: 100,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                child: TextField(
                  controller: productPriceController,
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
                    onPressed: () {
                      String uuid = Uuid().v1();
                      firestoreService.addProductToFirestore(
                        productTitleController.text,
                        productExpController.text,
                        productPriceController.text,
                        selectedSize,
                        selected,
                        selectedOption,
                        uuid,
                        files,

                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ürün başarıyla eklendi!'),
                          duration: Duration(seconds: 5),
                        ),
                      );

                      // Clear input fields
                      productTitleController.clear();
                      productExpController.clear();
                      productPriceController.clear();
                      selectedOption='';
                      selected = '';
                      selectedSize='';
                      setState(() {
                        files = null;
                      });
                    },
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

