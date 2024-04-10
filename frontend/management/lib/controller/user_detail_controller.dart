import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:management/domain/user_detail.dart';

class UserDetailController extends GetxController {
  final box = GetStorage();

  var username = "".obs;
  var accessToken = "".obs;
  var refreshToken = "".obs;

  @override
  void onInit() {
    username.value = box.read("username") ?? "";
    accessToken.value = box.read("accessToken") ?? "";
    refreshToken.value = box.read("refreshToken") ?? "";
    super.onInit();
  }

  bool get isLogin {
    return username.isNotEmpty &&
      accessToken.isNotEmpty && 
      refreshToken.isNotEmpty;
  }

  void saveUser(UserDetail userDetail) {
    username.value = userDetail.username;
    accessToken.value = userDetail.accessToken;
    refreshToken.value = userDetail.refreshToken;
    box.write("username", userDetail.username);
    box.write("accessToken", userDetail.accessToken);
    box.write("refreshToken", userDetail.refreshToken);
  }

  void removeUser() {
    username.value = "";
    accessToken.value = "";
    refreshToken.value = "";
    box.remove("username");
    box.remove("accessToken");
    box.remove("refreshToken");
  }
}
