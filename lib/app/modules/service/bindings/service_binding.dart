import 'package:get/get.dart';
import 'package:wekeep/app/data/repositories/service_repository.dart';

import '../controllers/service_controller.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceController>(
      () => ServiceController(repository: ServiceRepository()),
      fenix: true,
    );
  }
}
