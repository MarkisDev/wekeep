import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var notesController = TextEditingController();
  var categoryController = TextEditingController();
  var warrantyMonthsController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    categoryController.dispose();
    notesController.dispose();
    warrantyMonthsController.dispose();
  }
}
