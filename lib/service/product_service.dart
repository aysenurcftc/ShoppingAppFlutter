import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/models/users.dart' as model;
import 'package:senior_project/service/auth.dart';




class ProductService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthService auth = AuthService();



// get user details
  Future<model.Users> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.Users.fromSnap(documentSnapshot);
  }


  Future<model.Users> getUserData() async {
    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot documentSnapshot =
      await _firestore.collection('users').doc(currentUser.uid).get();

      return model.Users.fromSnap(documentSnapshot);
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle the error as needed
      throw e;
    }
  }

// Add other authentication-related methods if needed



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
            .map((doc) => Product.fromSnap(doc))
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
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      QuerySnapshot usersSnapshot = await usersCollection.get();
      List<Product> allUsersProducts = [];

      for (QueryDocumentSnapshot userDoc in usersSnapshot.docs) {
        String userId = userDoc.id;
        CollectionReference productsCollection = usersCollection.doc(userId).collection('products');
        QuerySnapshot productsSnapshot = await productsCollection.get();

        List<Product> userProducts = productsSnapshot.docs
            .map((doc) => Product.fromSnap(doc))
            .toList();
        allUsersProducts.addAll(userProducts);
      }

      return allUsersProducts;
    } catch (e) {
      print('Ürünleri çekerken bir hata oluştu: $e');
      return [];
    }
  }


  Future<void> likeProduct(String productIdentifier, bool isLiked) async {
    try {
      String? userId = await auth.getCurrentUserId();

      if (userId != null) {
        DocumentReference userDocRef = FirebaseFirestore.instance.collection(
            'users').doc(userId);


        List<dynamic> userLikes = (await userDocRef.get()).get('like') ?? [];

        QuerySnapshot productQuerySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('products')
            .where('uid', isEqualTo: productIdentifier)
            .limit(1)
            .get();

        if (productQuerySnapshot.docs.isNotEmpty) {
          DocumentSnapshot productDocument = productQuerySnapshot.docs.first;
          DocumentReference productDocRef = productDocument.reference;

          // Ürün dokümanını güncelle
          await productDocRef.update({'isLiked': !isLiked});

          if (isLiked) {
            userLikes.remove(productIdentifier);
            print('Ürün beğenisi kaldırıldı.');
          } else {
            userLikes.add(productIdentifier);
            print('Ürün beğenildi.');
          }
          // Kullanıcı koleksiyonundaki 'like' alanını güncelle
          await userDocRef.update({'like': userLikes});
        }
      }
    } catch (e) {
      print('Ürünü beğenirken bir hata oluştu: $e');
    }
  }














}




