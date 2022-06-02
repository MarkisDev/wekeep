import 'package:get/get.dart';

import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/home/controllers/add_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddController>(
      () => AddController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
  }
}
