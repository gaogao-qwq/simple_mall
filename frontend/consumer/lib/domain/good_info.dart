class GoodInfo {
  int id = 0;
  String name = "";
  String imgUrl = "";
  String price = "";
  int stock = 0;

  GoodInfo(this.id, this.name, this.imgUrl, this.price, this.stock);

  GoodInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgUrl = json['imgUrl'];
    price = json['price'];
    stock = json['stock'];
  }
}