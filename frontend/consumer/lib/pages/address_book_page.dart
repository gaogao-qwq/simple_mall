import 'package:consumer/controller/address_contrller.dart';
import 'package:consumer/domain/address.dart';
import 'package:consumer/pages/add_address_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressBookPage extends StatelessWidget {
  const AddressBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addrc = Get.put(AddressController());

    Widget manageAddressPopupButton = PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.add_circle),
                    SizedBox(width: 8),
                    Text("添加收货地址")
                  ],
                ),
                onTap: () => Get.to(const AddAddressPage()),
              ),
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.check_box),
                    SizedBox(width: 8),
                    Text("管理收货地址")
                  ],
                ),
                onTap: () => addrc.isSelectMode.value = true,
              ),
            ]);

    Widget addressPopupMenuButton(Address address) => PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.local_shipping),
                    SizedBox(width: 8),
                    Text("设为默认收货地址")
                  ],
                ),
                onTap: () async => addrc.setDefaultAddress(address.id),
              ),
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 8),
                    Text("删除")
                  ],
                ),
                onTap: () async => addrc.removeAddress(address.id),
              ),
            ]);

    Widget addressListView = Obx(() => Column(
        children: List.generate(
            addrc.addresses.length,
            (idx) => Card(
                  child: ListTile(
                      leading: addrc.isSelectMode.value
                          ? Obx(() => Checkbox(
                                value: addrc.addresses[idx].selected,
                                onChanged: (value) =>
                                    addrc.toggleAddressSelect(idx, value!),
                              ))
                          : const Icon(Icons.info),
                      title: Text(
                          "${addrc.addresses[idx].recipient} ${addrc.addresses[idx].phoneNumber}"),
                      subtitle: Row(
                        children: [
                          Text(
                            "${addrc.addresses[idx].province.fullname} ${addrc.addresses[idx].detail}",
                          ),
                          const SizedBox(width: 8),
                          addrc.addresses[idx].isDefault
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 1),
                                      decoration: BoxDecoration(
                                          color: context
                                              .theme.colorScheme.surfaceVariant,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                        "默认",
                                        style: TextStyle(
                                            color: context.theme.colorScheme
                                                .onSurfaceVariant),
                                      )))
                              : const SizedBox.shrink(),
                        ],
                      ),
                      trailing: addrc.isSelectMode.value
                          ? const SizedBox.shrink()
                          : addressPopupMenuButton(addrc.addresses[idx])),
                ))));

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: addrc.isSelectMode.value
                ? Text("已选${addrc.selectCount}项")
                : const Text("我的地址薄"),
            leading: addrc.isSelectMode.value
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => addrc.isSelectMode.value = false)
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
            actions: [
              addrc.isSelectMode.value
                  ? IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: "删除选中地址",
                      onPressed: () {},
                    )
                  : manageAddressPopupButton
            ],
          ),
          body: addressListView,
        ));
  }
}
