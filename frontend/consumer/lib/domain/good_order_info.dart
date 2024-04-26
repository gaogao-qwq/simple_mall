import 'package:consumer/enum/order_state.dart';

class GoodOrderInfo {
  String id;
  String imgUrl;
  OrderState state;

  GoodOrderInfo({required this.id, required this.imgUrl, required this.state});

  factory GoodOrderInfo.fromJson(Map<String, dynamic> json) =>
    GoodOrderInfo(
      id: json["id"] as String,
      imgUrl: json["imgUrl"] as String,
      state: OrderState.fromOrdinal(json["state"] as int)
    );
}
