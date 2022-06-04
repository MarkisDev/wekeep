import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';

class HomeController extends GetxController {
  final productList = <ProductModel>[].obs;
  final tabIndex = 0.obs;
// Getter to get all the products from the list
  List<ProductModel> get products => productList.value;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

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
