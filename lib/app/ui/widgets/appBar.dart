import 'package:flutter/material.dart';
import 'package:wekeep/app/ui/theme/color_theme.dart';

AppBar getAppBar(String title) {
  final AppBar appBar = AppBar(
    title: Text(title),
    centerTitle: true,
    backgroundColor: kprimaryColor,
    elevation: 0,
  );
  return appBar;
}
