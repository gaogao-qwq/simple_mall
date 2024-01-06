class GoodSwiper {
  String imgUrl = "";
  int goodId = 0;

  GoodSwiper(this.imgUrl, this.goodId);

  GoodSwiper.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
    goodId = json['goodId'];
  }
}