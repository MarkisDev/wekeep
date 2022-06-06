import 'package:get/get.dart';
import 'package:wekeep/app/data/repositories/categories_repository.dart';
import 'package:wekeep/app/data/repositories/product_repository.dart';

import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/categories/controllers/categories_controller.dart';
import 'package:wekeep/app/modules/products/controllers/products_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProductsController>(
      () => ProductsController(repository: ProductRepository()),
    );
    Get.lazyPut<CategoriesController>(
      () => CategoriesController(repository: CategoriesRepository()),
    );
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
  }
}
