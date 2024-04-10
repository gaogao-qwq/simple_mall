import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/api/good_provider.dart';
import 'package:management/domain/good_info.dart';

class GoodDataSource extends DataTableSource {
  var goodInfos = <GoodInfo>[].obs;
  var dataCount = 0.obs;
  var selected = <bool>[].obs;

  void setData(List<GoodInfo> goodInfos, int dataCount) {
    this.goodInfos.value = goodInfos;
    this.dataCount.value = dataCount;
    selected.value = List
      .generate(goodInfos.length, (_) => false);
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
    int infoIndex = index % goodInfos.length;
    return DataRow(
      selected: selected[infoIndex],
      onSelectChanged: (value) {
        selected[infoIndex] = value ?? false;
        notifyListeners();
      },
      cells: List.generate(
        GoodInfo.memberCount,
        (idx) => DataCell(
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Text(
              goodInfos[infoIndex].toStrings().elementAt(idx),
              overflow: TextOverflow.ellipsis
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
  int get selectedRowCount => selected
    .where((x) => x).length;
}

class GoodManagementController extends GetxController {
  final gp = Get.put(GoodProvider());

  var dataSource = GoodDataSource().obs;
  var pageSize = 10.obs;
  var currPage = 0.obs;

  @override
  void onInit() async {
    dataSource.value.setData(
      await gp.getGoods(currPage.value, pageSize.value),
      await gp.getCount()
    );
    super.onInit();
  }

  void selectAll(bool selected) =>
    dataSource.value.selectAll(selected);

  Future<void> toPage(int page) async {
    currPage.value = page;
    dataSource.value.setData(
      await gp.getGoods(currPage.value, pageSize.value),
      await gp.getCount()
    );
  }
}
