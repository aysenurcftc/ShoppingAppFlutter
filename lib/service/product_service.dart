import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/service/auth.dart';

class FirestoreService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  AuthService auth = AuthService();

  // Adding image to Firebase Storage
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      String uniqueImageName = '${DateTime.now().millisecondsSinceEpoch}_${_auth.currentUser!.uid}.jpg';
      Reference ref = _storage.ref().child(childName).child(uniqueImageName);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Resim yüklenirken bir hata oluştu: $e');
      return '';
    }
  }

  Future<void> addProductToFirestore(
      String title,
      String description,
      double price,
      String category,
      String condition,
      String size,
      Uint8List? image,) async {
    try {
      String? userId = await auth.getCurrentUserId();
      if (userId != null) {
        String imageUrl = '';
        if (image != null) {
          imageUrl = await uploadImageToStorage('products', image);
        }

        // Reference to the users collection
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        // Reference to the user's products collection
        CollectionReference userProductsCollection =
        userDocRef.collection('products');

        // Add product to the user's products collection
        await userProductsCollection.add({
          'title': title,
          'description': description,
          'price': price,
          'size':size,
          'category': category,
          'condition': condition,
          'image': imageUrl,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      print('Ürün başarıyla eklendi.');
    } catch (e) {
      print('Ürün eklenirken bir hata oluştu: $e');
    }
  }


  Future<List<Product>> getUserProducts() async {
    try {
      String? userId = await auth.getCurrentUserId();
      if (userId != null) {
        // Kullanıcının ürünlerini içeren koleksiyon referansı
        CollectionReference productsCollection =
        FirebaseFirestore.instance.collection('users').doc(userId).collection('products');

        // Koleksiyondaki tüm belgeleri al
        QuerySnapshot querySnapshot = await productsCollection.get();

        // Belge verilerini çıkart ve Product listesine dönüştür
        List<Product> userProducts = querySnapshot.docs
            .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        return userProducts;
      }
    } catch (e) {
      print('Ürünleri çekerken bir hata oluştu: $e');
      return [];
    }
    return [];
  }









}




