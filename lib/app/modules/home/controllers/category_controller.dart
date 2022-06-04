import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CategoryController extends GetxController {
  Color? getColorFromHex(String? hexColor) {
    hexColor = hexColor?.replaceAll("#", "");
    if (hexColor?.length == 6) {
      hexColor = "FF" + hexColor!;
      getColorFromHex(hexColor);
    }
    if (hexColor?.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
