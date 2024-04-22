class CartItem {
  String id;
  int goodId;
  String previewImgUrl;
  String goodName;
  String goodDescription;
  int stock;
  String price;
  int count;
  int purchaseLimit;
  bool selected = false;
  DateTime addDate;

  CartItem(
      {required this.id,
      required this.goodId,
      required this.previewImgUrl,
      required this.goodName,
      required this.goodDescription,
      required this.stock,
      required this.price,
      required this.count,
      required this.purchaseLimit,
      required this.addDate});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        goodId: json["goodId"],
        previewImgUrl: json["previewImgUrl"],
        goodName: json["goodName"],
        goodDescription: json["goodDescription"],
        stock: json["stock"],
        price: json["price"],
        count: json["count"],
        purchaseLimit: json["purchaseLimit"],
        addDate: DateTime.fromMillisecondsSinceEpoch(json["addDate"] as int),
      );
}
