import 'package:management/enum/gender.dart';

class UserInfo {
  int id = 0;
  String username = "";
  Gender gender = Gender.male;
  String rolename = "";
  bool enable = false;

  UserInfo(this.id, this.username, this.gender,
    this.rolename, this.enable);

  static int get memberCount => 5;

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    gender = Gender.values
      .firstWhere((e) => e.index == json['gender']);
    rolename = json['rolename'];
    enable = json['enable'];
  }

  List<String> toStrings() => [
    id.toString(),
    username,
    gender.toString(),
    rolename,
    enable.toString()
  ];
}
