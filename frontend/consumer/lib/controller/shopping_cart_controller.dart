import 'package:consumer/api/cart_provider.dart';
import 'package:consumer/domain/cart_item.dart';
import 'package:get/get.dart';

class ShoppingCartController extends GetxController {
  final cp = Get.put(CartProvider());

  final cartList = <CartItem>[].obs;

  void clearCartItems() {
    cartList.clear();
  }

  Future<List<CartItem>> fetchCartItems() async {
    cartList.value = await cp.getCartItems();
    return cartList;
  }

  Future<void> addGoodToCart(int goodId) async {
    var response = await cp.addItemToCart(goodId);
    if (response == null) {
      Get.snackbar(
        "Oops",
        "加入购物车失败",
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!response.success) {
      Get.snackbar(
        "Oops",
        response.message,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    await fetchCartItems();
  }

  Future<void> removeGoodFromCart(int goodId) async {
    var response = await cp.removeItemFromCart(goodId);
    if (response == null) {
      Get.snackbar(
        "Oops",
        "移除购物车失败",
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!response.success) {
      Get.snackbar(
        "Oops",
        response.message,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> setGoodCountInCart(String cartItemId, int count) async {
    var response = await cp.setCartItemCount(cartItemId, count);
    if (response == null) {
      Get.rawSnackbar(title: "Oops", message: "更改购物车中商品数量失败");
      return;
    }
    if (!response.success) {
      Get.rawSnackbar(title: "Oops", message: response.message);
      return;
    }
    cartList.firstWhere((e) => e.id == cartItemId).count = count;
    cartList.refresh();
  }
}
