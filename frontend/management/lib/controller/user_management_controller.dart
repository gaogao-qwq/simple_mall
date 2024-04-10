import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/api/user_provider.dart';
import 'package:management/domain/user_info.dart';

class UserDataSource extends DataTableSource {
  var userInfos = <UserInfo>[].obs;
  var dataCount = 0.obs;
  var selected = <bool>[].obs;

  void setData(List<UserInfo> userInfos, int dataCount) {
    this.dataCount.value = dataCount;
    this.userInfos.value = userInfos;
    selected.value = List
      .generate(userInfos.length, (_) => false);
    notifyListeners();
  }

  void selectAll(bool isSelected) {
    selected.value = selected
      .map((e) => isSelected).toList();
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= dataCount.value) return null;
    int infoIndex = index % userInfos.length;
    return DataRow(
      selected: selected[infoIndex],
      onSelectChanged: (value) {
        selected[infoIndex] = value ?? false;
        notifyListeners();
      },
      cells: List.generate(
        UserInfo.memberCount,
        (idx) => DataCell(
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Text(
              userInfos[infoIndex].toStrings().elementAt(idx),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataCount.value;

  @override
  int get selectedRowCount =>
    selected.where((selected) => selected).length;
}

class UserManagementController extends GetxController {
  final up = Get.put(UserProvider());

  var dataSource = UserDataSource().obs;
  var pageSize = 10.obs;
  var currPage = 0.obs;

  @override
  void onInit() async {
    dataSource.value.setData(
      await up.getUsers(currPage.value, pageSize.value),
      await up.getCount()
    );
    super.onInit();
  }

  void selectAll(bool selected) =>
    dataSource.value.selectAll(selected);

  Future<void> toPage(int page) async {
    currPage.value = page;
    dataSource.value.setData(
      await up.getUsers(currPage.value, pageSize.value),
      await up.getCount());
  }
}
