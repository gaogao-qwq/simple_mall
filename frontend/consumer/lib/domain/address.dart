import 'package:consumer/enum/province.dart';

class Address {
  String recipient;
  String phoneNumber;
  Province province;
  String detail;

  Address(
      {required this.recipient,
      required this.phoneNumber,
      required this.province,
      required this.detail});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      recipient: json["recipient"] as String,
      phoneNumber: json["phoneNumber"] as String,
      province: Province.fromCode(json["province"] as int),
      detail: json["detail"] as String);

  Map<String, dynamic> toJson() => {
        "recipient": recipient,
        "phoneNumber": phoneNumber,
        "province": province.code,
        "detail": detail
      };
}
