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
      String price,
      String size,
      String category,
      String condition,
      String uid,
      Uint8List? image,
      ) async {
    try {
      String? userId = await auth.getCurrentUserId();
      if (userId != null) {
        String imageUrl = '';
        if (image != null) {
          imageUrl = await uploadImageToStorage('products', image);
        }
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        CollectionReference userProductsCollection =
        userDocRef.collection('products');

        // Add product to the user's products collection
        DocumentReference productDocRef = await userProductsCollection.add({
          'title': title,
          'description': description,
          'price': price,
          'size': size,
          'category': category,
          'condition': condition,
          'image': imageUrl,
          'uid': uid,
          'timestamp': FieldValue.serverTimestamp(),
          'isLiked': false,
          'likedBy': [],
        });

        print('Ürün başarıyla eklendi. Product ID: ${productDocRef.id}');
      }
    } catch (e) {
      print('Ürün eklenirken bir hata oluştu: $e');
    }
  }


  Future<List<Product>> getUserProducts() async {
    try {
      String? userId = await auth.getCurrentUserId();
      if (userId != null) {
        CollectionReference productsCollection =
        FirebaseFirestore.instance.collection('users').doc(userId).collection('products');

        QuerySnapshot querySnapshot = await productsCollection.get();

        List<Product> userProducts = querySnapshot.docs
            .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        return userProducts;
      }
    } catch (e) {
      print('Ürünleri çekerken bir hata oluştu: $e');
      print('Hata ayrıntıları: ${e.toString()}');
      return [];
    }
    return [];
  }


  Future<List<Product>> getAllUsersProducts() async {
    try {
      // Tüm kullanıcıları içeren koleksiyon referansı
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      QuerySnapshot usersSnapshot = await usersCollection.get();
      List<Product> allUsersProducts = [];

      for (QueryDocumentSnapshot userDoc in usersSnapshot.docs) {
        String userId = userDoc.id;
        CollectionReference productsCollection = usersCollection.doc(userId).collection('products');
        QuerySnapshot productsSnapshot = await productsCollection.get();

        List<Product> userProducts = productsSnapshot.docs
            .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        allUsersProducts.addAll(userProducts);
      }

      return allUsersProducts;
    } catch (e) {
      print('Ürünleri çekerken bir hata oluştu: $e');
      return [];
    }
  }









}




