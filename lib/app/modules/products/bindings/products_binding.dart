import 'package:get/get.dart';
import 'package:wekeep/app/data/repositories/product_repository.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';

import '../controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(
      () => ProductsController(repository: ProductRepository()),
    );
  }
}
