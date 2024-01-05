class CartItem {
  int goodId = 0;
  String previewImgUrl = "";
  String goodName = "";
  String goodDescription = "";
  int stock = 0;
  String price = "";
  int count = 0;

  CartItem(this.goodId, this.previewImgUrl, this.goodName, this.goodDescription, this.stock, this.price, this.count);

  CartItem.fromJson(Map<String, dynamic>json) {
    goodId = json["goodId"];
    previewImgUrl = json["previewImgUrl"];
    goodName = json["goodName"];
    goodDescription = json["goodDescription"];
    stock = json["stock"];
    price = json["price"];
    count = json["count"];
  } 
}
