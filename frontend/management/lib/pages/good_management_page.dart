import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/controller/good_management_controller.dart';

class GoodManagementPage extends StatelessWidget {
  const GoodManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gmc = Get.put(GoodManagementController());

    final dataColumns = [
      const DataColumn(
        label: Text("商品ID"),
      ),
      const DataColumn(
        label: Text("商品名"),
      ),
      const DataColumn(
        label: Text("商品预览图URL"),
      ),
      const DataColumn(
        label: Text("商品价格"),
      ),
      const DataColumn(
        label: Text("商品库存"),
      ),
    ];

    return Column(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Obx(() => PaginatedDataTable(
            header: const Text("商品管理"),
            source: gmc.dataSource.value,
            rowsPerPage: gmc.pageSize.value,
            columns: dataColumns,
            showCheckboxColumn: true,
            showFirstLastButtons: true,
            onPageChanged: (index) =>
              gmc.toPage(index % (gmc.pageSize.value - 1)),
            onSelectAll: (value) => gmc.selectAll(value!),
          )),
        ),
      ],
    );
  }
}
