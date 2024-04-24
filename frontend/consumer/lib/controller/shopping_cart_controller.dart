import 'package:consumer/api/cart_provider.dart';
import 'package:consumer/domain/cart_item.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartController extends GetxController {
  final cp = Get.put(CartProvider());

  final cartList = <CartItem>[].obs;

  @override
  void onInit() async {
    cartList.value = await cp.getCartItems();
    super.onInit();
  }

  Decimal get totalPrice => cartList
      .where((e) => e.selected == true)
      .map((e) => Decimal.tryParse(e.price)! * Decimal.fromInt(e.count))
      .fold(Decimal.zero, (prev, curr) => prev + curr);

  List<CartItem> get selectedCartItems =>
      cartList.where((e) => e.selected == true).toList();

  bool get isSelectAll => cartList.every((e) => e.selected == true);

  int get selectCount => cartList.where((e) => e.selected).length;

  void toggleSelect(int index, bool select) {
    cartList[index].selected = select;
    cartList.refresh();
  }

  void toggleSelectAll() {
    bool isSelect = !isSelectAll;
    for (var e in cartList) {
      e.selected = isSelect;
    }
    cartList.refresh();
  }

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
      Get.rawSnackbar(title: "Oops", message: "加入购物车失败");
      return;
    }
    if (!response.success) {
      Get.rawSnackbar(title: "Oops", message: response.message);
    }
    await fetchCartItems();
    Get.rawSnackbar(title: "操作成功", message: "商品已加入购物车");
  }

  Future<void> removeGoodFromCart(String cartItemId) async {
    var response = await cp.removeItemFromCart(cartItemId);
    if (response == null) {
      Get.rawSnackbar(title: "Oops", message: "移除购物车失败");
      return;
    }
    if (!response.success) {
      Get.rawSnackbar(title: "Oops", message: response.message);
    }
    cartList.removeWhere((e) => e.id == cartItemId);
    cartList.refresh();
  }

  Future<void> setGoodCountInCart(CartItem cartItem, int count) async {
    if (count < 0) return;
    if (count == 0) {
      Get.dialog(AlertDialog(
        title: const Text("确认"),
        content: const Text("是否要从购物车中删除该商品"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("取消"),
          ),
          FilledButton(
            onPressed: () async {
              removeGoodFromCart(cartItem.id);
              Get.back();
            },
            child: const Text("删除"),
          )
        ],
      ));
      return;
    }
    if (count > cartItem.purchaseLimit) {
      Get.rawSnackbar(title: "Oops", message: "商品数量超过该商品单次限购数量");
      return;
    }
    var response = await cp.setCartItemCount(cartItem.id, count);
    if (response == null) {
      Get.rawSnackbar(title: "Oops", message: "更改购物车中商品数量失败");
      return;
    }
    if (!response.success) {
      Get.rawSnackbar(title: "Oops", message: response.message);
      return;
    }
    cartList.firstWhere((e) => e.id == cartItem.id).count = count;
    cartList.refresh();
  }
}
