import 'package:consumer/enum/province.dart';

class Address {
  String id;
  String recipient;
  String phoneNumber;
  Province province;
  String detail;
  bool isDefault;
  bool selected;

  Address(
      {required this.id,
      required this.recipient,
      required this.phoneNumber,
      required this.province,
      required this.detail,
      required this.isDefault,
      this.selected = false});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      id: json["id"] as String,
      recipient: json["recipient"] as String,
      phoneNumber: json["phoneNumber"] as String,
      province: Province.fromCode(json["province"] as int),
      detail: json["detail"] as String,
      isDefault: json["isDefault"] as bool);

  Map<String, dynamic> toJson() => {
        "recipient": recipient,
        "phoneNumber": phoneNumber,
        "provinceCode": province.code,
        "detail": detail
      };
}
