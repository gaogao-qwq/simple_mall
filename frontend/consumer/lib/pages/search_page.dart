import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const TextField(
          decoration: InputDecoration(
            hintText: "搜索",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            isDense: true,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}