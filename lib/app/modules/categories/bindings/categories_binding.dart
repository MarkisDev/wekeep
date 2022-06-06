import 'package:get/get.dart';
import 'package:wekeep/app/data/repositories/categories_repository.dart';

import '../controllers/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(
      () => CategoriesController(repository: CategoriesRepository()),
    );
  }
}
