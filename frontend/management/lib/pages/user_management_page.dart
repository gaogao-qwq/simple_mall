import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/controller/user_management_controller.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final umc = Get.put(UserManagementController());

    final dataColumns = [
      const DataColumn(
        label: Text("用户ID")
      ),
      const DataColumn(
        label: Text("用户名")
      ),
      const DataColumn(
        label: Text("性别")
      ),
      const DataColumn(
        label: Text("身份组")
      ),
      const DataColumn(
        label: Text("启用状态")
      ),
    ];

    return Column(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Obx(() => PaginatedDataTable(
            header: const Text("用户管理"),
            source: umc.dataSource.value,
            rowsPerPage: umc.pageSize.value,
            columns: dataColumns,
            showCheckboxColumn: true,
            showFirstLastButtons: true,
            onPageChanged: (index) =>
              umc.toPage(index % (umc.pageSize.value - 1)),
            onSelectAll: (value) => umc.selectAll(value!),
          )),
        ),
      ],
    );
  }
}
