import 'package:get/get.dart';
import 'package:wekeep/app/data/repositories/product_repository.dart';
import 'package:wekeep/app/data/repositories/service_repository.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/service/controllers/service_controller.dart';
import 'package:wekeep/app/modules/service/views/serviceDetails_view.dart';

import '../controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(
      () => ProductsController(repository: ProductRepository()),
      fenix: true,
    );
  }
}
