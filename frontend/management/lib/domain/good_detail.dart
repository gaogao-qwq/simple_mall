class GoodDetail {
  int id = 0;
  String name = "";
  String previewImgUrl = "";
  List<String> detailImgUrl = [];
  String description = "";
  String price = "";
  int stock = 0;

  GoodDetail(this.id, this.name, this.previewImgUrl, this.detailImgUrl, this.description, this.price, this.stock);

  GoodDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    previewImgUrl = json['previewImgUrl'];
    detailImgUrl = (json['detailImgUrl'] as List).map((e) => e as String).toList();
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
  }
}
