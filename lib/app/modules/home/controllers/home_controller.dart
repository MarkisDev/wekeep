import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:wekeep/app/data/repositories/user_repository.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';

class HomeController extends GetxController {
  final tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
