import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wekeep/app/data/models/serviceProvider_model.dart';
import 'package:wekeep/app/data/repositories/service_repository.dart';

class ServiceController extends GetxController {
  final ServiceRepository repository;
  ServiceController({required this.repository});

  final geo = Geoflutterfire();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var messageController = TextEditingController();
  var emailController = TextEditingController();
  var shopsList = [].obs;
  final center =
      Geoflutterfire().point(latitude: 12.9633978, longitude: 77.58550823).obs;
  get shops => shopsList.value;

  Future<void> sendEmail() async {
    await FlutterEmailSender.send(Email(
        body: '${emailController.text}\n\n${messageController.text}',
        subject: 'Service Request by ${nameController.text}',
        recipients: ['rir20cs@cmrit.com']));
  }

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
