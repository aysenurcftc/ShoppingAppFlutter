

class PurchasedItem {
  final String title;
  final String category;
  final double price;

  final String image;
  final String productId;
  final String productQuantity;
  final int  count;


  PurchasedItem({
    required this.title,
    required this.category,
    required this.price,
    required this.image,
    required this.productId,
    required this.productQuantity,
    required this.count,

  });

  static PurchasedItem fromJson(Map<String, dynamic> data) {
    return PurchasedItem(
      title: data["title"],
      category: data["category"],
      price: data["price"],
      image: data["image"],
      productId:  data["productId"],
      productQuantity:  data["productQuantity"],
      count:  data["count"],

    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "category": category,
    "price": price,
    "image": image,
    "productId" : productId,
    "productQuantity" : productQuantity,
    "count" : count,

  };
}