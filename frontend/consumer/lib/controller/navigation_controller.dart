import 'package:consumer/pages/home_page.dart';
import 'package:consumer/pages/my_page.dart';
import 'package:consumer/pages/shopping_cart_page.dart';
import 'package:get/get.dart';

const navigations = [HomePage(), ShoppingCartPage(), MyPage()];

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
    Get.off(
      navigations[index],
      transition: Transition.noTransition,
    );
  }

  bool isDestinationSelected(int index) {
    return currentIndex.value == index;
  }
}
