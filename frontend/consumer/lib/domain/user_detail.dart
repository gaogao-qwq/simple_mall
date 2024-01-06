class UserDetail {
  String username = "";
  String accessToken = "";
  String refreshToken = "";

  UserDetail(this.username, this.accessToken, this.refreshToken);

  UserDetail.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}