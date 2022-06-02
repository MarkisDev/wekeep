import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';

class HomeController extends GetxController {
  final productList = <ProductModel>[].obs;

// Getter to get all the products from the list
  List<ProductModel> get products => productList.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    final authenticationController = Get.find<AuthenticationController>();
    productList.bindStream(FirestoreDb.productStream(
        authenticationController.auth.currentUser!.uid));
  }

  @override
  void onClose() {}
}
