import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/providers/firestorage_provider.dart';
import 'package:wekeep/app/data/repositories/product_repository.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  var productImagePath = ''.obs;
  final productHintText = ''.obs;

  final purchaseDate = DateTime.now().obs;
  final warrantyDate = DateTime.now().obs;

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

  String stringDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  int monthsUntil(DateTime future) {
    final now = DateTime.now();
    final difference = future.difference(now);
    return (difference.inDays / 30).round();
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

  Future<void> scheduleReminders(
      String message, DateTime targetDate, String playerId) async {
    final now = DateTime.now();

    await _scheduleReminder(
      playerId,
      DateTime.now().toUtc(),
      "${message} expires now! (this is a test to show how it will look!)",
    );
    // Check if the target date is in the future
    if (targetDate.isAfter(now)) {
      // Schedule a reminder a day before
      if (targetDate.difference(now).inDays >= 1) {
        await _scheduleReminder(
          playerId,
          targetDate.subtract(Duration(days: 1)),
          "${message} expires in a day!",
        );
      }

      // Schedule a reminder a week before
      if (targetDate.difference(now).inDays >= 7) {
        await _scheduleReminder(
          playerId,
          targetDate.subtract(Duration(days: 7)),
          "${message} expires in a week!",
        );
      }

      // Schedule a reminder a month before
      if (targetDate.difference(now).inDays >= 30) {
        await _scheduleReminder(
          playerId,
          targetDate.subtract(Duration(days: 30)),
          "${message} expires in a month!",
        );
      }
    }
  }

  Future<void> _scheduleReminder(
      String playerId, DateTime targetDate, String message) async {
    // Create a notification content
    final content = OSCreateNotification(
      playerIds: [playerId],
      heading: "Reminder",
      content: message,
      sendAfter: targetDate,
    );

    // Schedule the notification
    await OneSignal.shared.postNotification(content);
  }
}
