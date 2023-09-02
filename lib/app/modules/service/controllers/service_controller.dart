import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wekeep/app/data/repositories/service_repository.dart';
import 'package:wekeep/app/modules/home/controllers/home_controller.dart';

class ServiceController extends GetxController {
  final ServiceRepository repository;
  ServiceController({required this.repository});

  late final HomeController homeController;
  final geo = GeoFlutterFire();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var messageController = TextEditingController();
  var emailController = TextEditingController();
  var shopsList = [].obs;
  final center =
      GeoFlutterFire().point(latitude: 12.9633978, longitude: 77.58550823).obs;
  get shops => shopsList;

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var x = await Geolocator.getCurrentPosition();
    GeoFirePoint pos = geo.point(latitude: x.latitude, longitude: x.longitude);
    return pos;
  }

  getShopList() {
    return repository.getShops(center.value);
  }

  @override
  void onInit() {
    homeController = Get.find<HomeController>();
    shopsList.bindStream(repository.getShops(center.value));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
