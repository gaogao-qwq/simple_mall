import 'package:consumer/api/address_provider.dart';
import 'package:consumer/domain/address.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final addrp = Get.put(AddressProvider());

  var addresses = <Address>[].obs;

  @override
  void onInit() async {
    addresses.value = await addrp.getAddresses();
    super.onInit();
  }

  void clearAddresses() {
    addresses.clear();
  }
}
