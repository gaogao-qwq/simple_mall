import 'package:consumer/controller/user_detail_controller.dart';
import 'package:get/get.dart';

class CartProvider extends GetConnect {
  final uc = Get.put(UserDetailController());
}