import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wekeep/app/data/models/request_model.dart';
import 'package:wekeep/app/data/models/serviceProvider_model.dart';
import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:wekeep/app/modules/service/controllers/service_controller.dart';

class RequestView extends GetView<ServiceController> {
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceModel = Get.arguments;

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Make request',
              style: TextStyle(fontSize: 21),
            ),
          ),
          Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is not valid!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    // TextFormField(
                    //   controller: controller.emailController,
                    //   decoration: const InputDecoration(labelText: 'Email'),
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Email is not valid!';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    TextFormField(
                      minLines: 3,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      controller: controller.messageController,
                      decoration: const InputDecoration(labelText: 'Message'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Message is not valid!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          RequestModel requestModel = RequestModel(
                              img:
                                  'https://lh3.googleusercontent.com/a/AATXAJwn7u2KvmoKJnNbsWclKbLCJEqDcGhI-iCq0mU-9Q=s96-c',
                              name: controller.nameController.text,
                              desc: controller.messageController.text);
                          controller.repository
                              .addRequest(requestModel, serviceModel.uid);
                          Get.snackbar(
                            'Success!',
                            'Sent request!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            borderRadius: 20,
                            margin: EdgeInsets.all(15),
                            colorText: Colors.white,
                            duration: Duration(seconds: 4),
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal,
                            forwardAnimationCurve: Curves.easeOutBack,
                          );
                          Get.offNamed('/service');
                        },
                        child: Text('Send'))
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
