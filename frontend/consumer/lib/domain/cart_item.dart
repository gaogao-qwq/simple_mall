class CartItem {
  String id = "";
  int goodId = 0;
  String previewImgUrl = "";
  String goodName = "";
  String goodDescription = "";
  int stock = 0;
  String price = "";
  int count = 0;
  bool selected = false;

  CartItem(this.id, this.goodId, this.previewImgUrl, this.goodName, this.goodDescription, this.stock, this.price, this.count);

  CartItem.fromJson(Map<String, dynamic>json) {
    id = json["id"];
    goodId = json["goodId"];
    previewImgUrl = json["previewImgUrl"];
    goodName = json["goodName"];
    goodDescription = json["goodDescription"];
    stock = json["stock"];
    price = json["price"];
    count = json["count"];
  } 
}
