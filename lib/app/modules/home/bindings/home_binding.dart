import 'package:get/get.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<AuthenticationController>(() => AuthenticationController(),
        fenix: true);
  }
}
