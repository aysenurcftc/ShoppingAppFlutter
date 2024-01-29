import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:senior_project/models/products.dart';
import 'package:senior_project/models/users.dart' as model;
import 'package:senior_project/service/auth.dart';
import 'package:uuid/uuid.dart';





class ProductService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthService auth = AuthService();



  Future<void> addOrder(String userId, Map<String, dynamic> order) async {
    try {
      await _firestore.collection('users').doc(userId).collection('orders').add(order);
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Stream<QuerySnapshot> getOrdersStream(String userId) {
    try {
      return _firestore.collection('users').doc(userId).collection('orders').snapshots();
    } catch (e) {
      print('Hata oluştu: $e');
      throw e;
    }
  }

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
      String profImage,
      String productQuantity,
      String name,
      ) async {
    try {

      String? userId = await auth.getCurrentUserId();
      if (userId != null) {
        String imageUrl = '';
        if (image != null) {
          imageUrl = await uploadImageToStorage('products', image);
        }

        String productId = Uuid().v4();

        CollectionReference userProductsCollection = FirebaseFirestore.instance.collection('products');
        Product product = Product(
            title: title,
            productId: productId,
            description: description,
            price: price,
            size: size,
            category: category,
            condition: condition,
            uid: userId,
            image: imageUrl,
            timestamp: DateTime.now(),
            profImage: profImage,
            productQuantity : productQuantity,
            name: name,
            likes: [],
            saveProducts : [],
        );

        await userProductsCollection.doc(productId).set(product.toJson());
        print('Ürün başarıyla eklendi. Product ID:');

      }
    } catch (e) {

      print('Ürün eklenirken bir hata oluştu: $e');

    }
  }



  Future<List<Product>> getUserProducts() async {
    try {
      String userId = _auth.currentUser!.uid;
      CollectionReference productsCollection = _firestore.collection('products');

      QuerySnapshot querySnapshot = await productsCollection
          .where('uid', isEqualTo: userId) // Sadece mevcut kullanıcının ürünlerini al
          .get();

      List<Product> userProducts = querySnapshot.docs
          .map((doc) => Product.fromSnap(doc))
          .toList();
      return userProducts;
    } catch (e) {
      print('Ürünleri çekerken bir hata oluştu: $e');
      print('Hata ayrıntıları: ${e.toString()}');
      return [];
    }
  }




  Future<List<Product>> getAllUsersProducts() async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      QuerySnapshot usersSnapshot = await usersCollection.get();
      List<Product> allUsersProducts = [];

      for (QueryDocumentSnapshot userDoc in usersSnapshot.docs) {
        String userId = userDoc.id;
        CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
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






  /*
  Stream<List<Product>> streamAllUsersProducts() {
    return _firestore.collection('users').snapshots().asyncMap(
          (snapshot) async {
        List<Product> allUsersProducts = [];

        for (QueryDocumentSnapshot userDoc in snapshot.docs) {
          String userId = userDoc.id;
          CollectionReference productsCollection = _firestore.collection('products');

          // Use `await` here to get the products snapshot
          QuerySnapshot productsSnapshot = await productsCollection.get();

          List<Product> userProducts = productsSnapshot.docs
              .map((doc) => Product.fromSnap(doc))
              .toList();
          allUsersProducts.addAll(userProducts);
        }

        return allUsersProducts;
      },
    );
  }*/


  Stream<List<Product>> streamAllUsersProducts() {
    return FirebaseFirestore.instance.collection('products').snapshots().asyncMap(
          (snapshot) async {
        List<Product> allUsersProducts = [];

        for (QueryDocumentSnapshot productDoc in snapshot.docs) {
          Product product = Product.fromSnap(productDoc);
          allUsersProducts.add(product);
        }

        return allUsersProducts;
      },
    );
  }




  Future<String> likeProduct(String productId, String uid, List likes) async {
    String res = "Some error occurred";

    try {
      if (likes.contains(uid)) {
        _firestore.collection('products').doc(productId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('products').doc(productId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  Future<String> saveProducts(String productId, String uid, List saveProducts) async {
    String res = "Some error occurred";

    try {
      if (saveProducts.contains(uid)) {
        _firestore.collection('products').doc(productId).update({
          'saveProducts': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('products').doc(productId).update({
          'saveProducts': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /*
  Future<String> likePost(String productId, String uid, List likes) async {
    String res = "Some error occurred";

    try {
      if (likes.contains(uid)) {
        _firestore.collection('products').doc(productId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('products').doc(productId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }*/


  Future<String> postComment(String productId, String text, String uid, String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('products')
            .doc(productId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  // Delete Post
  Future<String> deletePost(String productId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('products').doc(productId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> deleteComment(String commentId, String productId) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .collection('comments')
        .doc(commentId)
        .delete();
  }


  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
      await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }


  Future<void> updateProductQuantity(String productId, int newQuantity) async {
    await _firestore.collection('products').doc(productId).update({
      'productQuantity': newQuantity.toString(),
    });
  }








 }




