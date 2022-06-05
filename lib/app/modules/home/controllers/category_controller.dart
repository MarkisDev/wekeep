import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wekeep/app/data/models/category_model.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';

class CategoryController extends GetxController {
  final categoryList = <CategoryModel>[].obs;
  final pickedColor = Color(0xffffffff).obs;
  final pickedCategoryName = ''.obs;
  var nameController = TextEditingController();

  List<CategoryModel> get categories => categoryList.value;

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

  List<Map<String, dynamic>> getCategories() {
    List<Map<String, dynamic>> newMap = [];
    for (var item in categoryList) {
      newMap.add({'value': item.name, 'label': item.name});
    }
    return newMap;
  }

  void changeColor(Color color) {
    pickedColor.value = color;
  }

  final count = 0.obs;
  @override
  void onInit() {
    final authenticationController = Get.find<AuthenticationController>();
    categoryList.bindStream(FirestoreDb.categoryStream(
        authenticationController.auth.currentUser!.uid));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
