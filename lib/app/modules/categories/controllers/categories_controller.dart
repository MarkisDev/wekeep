import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wekeep/app/data/models/category_model.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:wekeep/app/data/repositories/categories_repository.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';

class CategoriesController extends GetxController {
  final CategoriesRepository repository;

  CategoriesController({required this.repository});

  final categoryList = <CategoryModel>[].obs;
  final pickedColor = Color(0x1d1d1d).obs;
  final categoryChanged = false.obs;
  final pickedCategoryId = ''.obs;
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
      newMap.add({'value': item.categoryId, 'label': item.name});
    }
    return newMap;
  }

  void changeColor(Color color) {
    pickedColor.value = color;
    categoryChanged.value = true;
  }

  final count = 0.obs;
  @override
  void onInit() {
    final authenticationController = Get.find<AuthenticationController>();
    categoryList.bindStream(repository
        .categoryStream(authenticationController.auth.currentUser!.uid));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
