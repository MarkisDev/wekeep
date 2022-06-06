import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/providers/firestorage_provider.dart';
import 'package:wekeep/app/data/repositories/product_repository.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';

class ProductsController extends GetxController {
  final ProductRepository repository;
  ProductsController({required this.repository});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var notesController = TextEditingController();
  var warrantyMonthsController = TextEditingController();
  final authenticationController = Get.find<AuthenticationController>();
  var recieptImagePath = ''.obs;
  final recieptHintText = ''.obs;

  final productList = <ProductModel>[].obs;
// Getter to get all the products from the list
  List<ProductModel> get products => productList.value;

  @override
  void onInit() {
    super.onInit();
    final authenticationController = Get.find<AuthenticationController>();
    productList.bindStream(repository
        .productStream(authenticationController.auth.currentUser!.uid));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    notesController.dispose();
    warrantyMonthsController.dispose();
  }

  /// Returns selected Image path
  Future<String> selectImage() async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage =
          await picker.pickImage(source: ImageSource.camera, maxWidth: 1920);
      final String fileName = path.basename(pickedImage!.path);

      return pickedImage.path;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  /// Returns upload Image url
  Future<String> uploadImage(String folderName, String imgPath) async {
    File imageFile = File(imgPath);
    String fileName = path.basename(imageFile.path);
    String downloadUrl = await FirestorageDb.uploadImage(
        authenticationController.auth.currentUser!.uid,
        folderName,
        fileName,
        imageFile);
    return downloadUrl;
  }
}
