import 'package:flutter/material.dart';

class PageInfo {
  final String title;
  final Widget page;
  final Icon activeIcon;
  final Icon inactiveIcon;

  const PageInfo(
      {required this.title,
      required this.page,
      required this.activeIcon,
      required this.inactiveIcon});
}
