import 'package:consumer/enum/order_state.dart';

class GoodOrderDetail {
  String id;
  int goodId;
  String imgUrl;
  String recipient;
  String phoneNumber;
  String address;
  OrderState state;

  GoodOrderDetail(
      {required this.id,
      required this.goodId,
      required this.imgUrl,
      required this.recipient,
      required this.phoneNumber,
      required this.address,
      required this.state});

  factory GoodOrderDetail.fromJson(Map<String, dynamic> json) =>
      GoodOrderDetail(
          id: json["id"] as String,
          goodId: json["goodId"] as int,
          imgUrl: json["imgUrl"] as String,
          recipient: json["recipient"] as String,
          phoneNumber: json["phoneNumber"] as String,
          address: json["address"] as String,
          state: OrderState.fromOrdinal(json["state"] as int));
}
