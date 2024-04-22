import 'package:consumer/api/address_provider.dart';
import 'package:consumer/controller/address_contrller.dart';
import 'package:consumer/domain/address.dart';
import 'package:consumer/enum/province.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class AddressFormController extends GetxController {
  final addrp = Get.put(AddressProvider());
  final addrc = Get.put(AddressController());

  final formKey = GlobalKey<FormState>();
  var address = Address(
          id: "",
          recipient: "",
          phoneNumber: "",
          province: Province.beijing,
          detail: "",
          isDefault: false)
      .obs;

  Future<void> addAddress() async {
    final response = await addrp.addAddress(address.value);
    if (response == null || !HttpStatus(response.code).isOk) {
      Get.rawSnackbar(title: "Oops", message: "添加地址失败");
      return;
    }
    await addrc.fetchAddresses();
    Get.back();
  }
}

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addrfc = Get.put(AddressFormController());

    Widget addressForm = Center(
        child: Card(
            margin: const EdgeInsets.all(8),
            child: Form(
                key: addrfc.formKey,
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "收货人姓名"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "请输入收货人姓名";
                            }
                            if (value.length > 20) {
                              return "收货人姓名过长";
                            }
                            return null;
                          },
                          onChanged: (value) =>
                              addrfc.address.value.recipient = value,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "收货人手机号"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "请输入收货人手机号";
                            }
                            if (value.length > 20) {
                              return "收货人手机号过长";
                            }
                            return null;
                          },
                          onChanged: (value) =>
                              addrfc.address.value.phoneNumber = value,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField(
                          hint: const Text("收货地区"),
                          items: List.generate(
                              Province.values.length,
                              (idx) => DropdownMenuItem(
                                    value: Province.values[idx],
                                    child: Text(Province.values[idx].fullname),
                                  )),
                          validator: (value) =>
                              value == null ? "请选择收货地区" : null,
                          onChanged: (value) =>
                              addrfc.address.value.province = value!,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "详细地址"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "请输入详细地址";
                            }
                            if (value.length > 100) {
                              return "提供的地址过长";
                            }
                            return null;
                          },
                          onChanged: (value) =>
                              addrfc.address.value.detail = value,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () async {
                              if (!addrfc.formKey.currentState!.validate()) {
                                return;
                              }
                              await addrfc.addAddress();
                            },
                            child: const Text("添加"),
                          ),
                        )
                      ],
                    )))));

    return Scaffold(
      appBar: AppBar(title: const Text("添加收货地址")),
      body: addressForm,
    );
  }
}
