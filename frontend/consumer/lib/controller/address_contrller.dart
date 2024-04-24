import 'package:consumer/api/address_provider.dart';
import 'package:consumer/domain/address.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final addrp = Get.put(AddressProvider());

  var isSelectMode = false.obs;
  var addresses = <Address>[].obs;

  @override
  void onInit() async {
    addresses.value = await addrp.getAddresses();
    super.onInit();
  }

  int get selectCount => addresses.where((e) => e.selected).length;

  Address? get defaultAddress {
    var defaultAddress = addresses.where((e) => e.isDefault);
    return defaultAddress.isEmpty ? null : defaultAddress.first;
  }

  void setSelectMode(bool enable) {
    if (!enable) {
      for (var e in addresses) {
        e.selected = false;
      }
    }
    isSelectMode.value = enable;
  }

  Future<void> fetchAddresses() async {
    addresses.value = await addrp.getAddresses();
    addresses.refresh();
  }

  void toggleAddressSelect(int index, bool value) {
    addresses[index].selected = value;
    addresses.refresh();
  }

  void clearAddresses() {
    addresses.clear();
    addresses.refresh();
  }

  Future<void> removeAddress(String addressId) async {
    var response = await addrp.removeAddress(addressId);
    if (response == null || response.success == false) {
      Get.rawSnackbar(title: "Oops", message: "删除收货地址失败");
      return;
    }
    addresses.removeWhere((e) => e.id == addressId);
    addresses.refresh();
  }

  Future<void> removeSelectedAddresses() async {
    List<String> addressIds =
        addresses.where((e) => e.selected).map((e) => e.id).toList();
    var response = await addrp.removeAddresses(addressIds);
    if (response == null || response.success == false) {
      Get.rawSnackbar(title: "Oops", message: "删除收货地址失败");
      return;
    }
    addresses.removeWhere((e) => addressIds.contains(e.id));
    addresses.refresh();
  }

  Future<void> setDefaultAddress(String addressId) async {
    var response = await addrp.setDefaultAddress(addressId);
    if (response == null || response.success == false) {
      Get.rawSnackbar(title: "Oops", message: "设置默认收货地址失败");
      return;
    }
    for (var e in addresses) {
      e.isDefault = e.id == addressId ? true : false;
    }
    addresses.refresh();
  }
}
