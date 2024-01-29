

class basketProduct {
  late String title;
  late String description;
  late String price;
  late String size;
  late String category;
  late String condition;
  late String uid;
  late String productId;
  late String image;
  late String productQuantity;

  late int count;




  // Constructor
  basketProduct({
    required this.title,
    required this.description,
    required this.price,
    required this.size,
    required this.category,
    required this.condition,
    required this.uid,
    required this.productId,
    required this.image,
    required this.productQuantity,
    required this.count,


  });

  basketProduct.fromMap(Map<String, dynamic> data) {
    title = data['title'] ?? '';
    description = data['description'] ?? '';
    price = data['price'] ?? '';
    category = data['category'] ?? '';
    condition = data['condition'] ?? '';
    size = data['size'] ?? '';
    uid = data['uid'] ?? '';
    productId = data['productId'] ?? "";
    image = data['image'] ?? '';
    productQuantity = data["productQuantity"] ?? '';
    count = data["count"] ?? 0;

  }



}