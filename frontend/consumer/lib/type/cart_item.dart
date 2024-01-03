class CartItem {
  int goodId = 0;
  String previewImgUrl = "";
  String goodName = "";
  String goodDescription = "";
  int stock = 0;
  String price = "";

  CartItem(this.goodId, this.previewImgUrl, this.goodName, this.goodDescription, this.stock, this.price);

  CartItem.fromJson(Map<String, dynamic>json) {
    goodId = json["goodId"];
    previewImgUrl = json["previewImgUrl"];
    goodName = json["goodName"];
    goodDescription = json["goodDescription"];
    stock = json["stock"];
    price = json["price"];
  } 
}
