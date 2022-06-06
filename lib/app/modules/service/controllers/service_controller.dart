import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ServiceController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var messageController = TextEditingController();
  var emailController = TextEditingController();

  Future<void> sendEmail() async {
    await FlutterEmailSender.send(Email(
        body: '${emailController.text}\n\n${messageController.text}',
        subject: 'Service Request by ${nameController.text}',
        recipients: ['rir20cs@cmrit.com']));
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
