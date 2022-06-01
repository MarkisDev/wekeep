import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/providers/firebase_provider.dart';

class HomeController extends GetxController {
  final productList = <ProductModel>[].obs;
  List<ProductModel> get products => productList.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    productList.bindStream(FirestoreDb.productStream());
  }

  @override
  void onClose() {}
}
