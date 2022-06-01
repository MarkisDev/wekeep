import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/models/user_models.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final productList = <ProductModel>[].obs;
  final uid = ''.obs;

  // ---------------Section to manage form ------------
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var notesController = TextEditingController();
  var categoryController = TextEditingController();
  var warrantyMonthsController = TextEditingController();

// Getter to get all the products from the list
  List<ProductModel> get products => productList.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    productList.bindStream(FirestoreDb.productStream(uid.value));
  }

  @override
  void onClose() {
    nameController.dispose();
    categoryController.dispose();
    notesController.dispose();
    warrantyMonthsController.dispose();
  }
}
