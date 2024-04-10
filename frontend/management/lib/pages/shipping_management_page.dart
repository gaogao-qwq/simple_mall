import 'package:flutter/material.dart';

class ShippingManagementPage extends StatelessWidget {
  const ShippingManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      key: ValueKey(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("发货管理"),
            ],
          ),
        ]
      ),
    );
  }
}
