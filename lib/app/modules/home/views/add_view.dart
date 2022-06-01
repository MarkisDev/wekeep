import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/global_widgets/appBar.dart';
import '../controllers/home_controller.dart';

class AddView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.uid.value = Get.arguments;
    return Scaffold(
      appBar: appBar,
      body: Column(children: [
        Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Center(child: Text('Enter product details')),
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
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Warranty Months'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Warranty Months is not valid!';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Category'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Category is not valid!';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Notes'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Notes is not valid!';
                  } else {
                    return null;
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    final productModel = ProductModel(
                        name: controller.nameController.text,
                        category: controller.categoryController.text,
                        warrantyMonths:
                            controller.warrantyMonthsController.text,
                        notes: controller.notesController.text);
                  },
                  child: Text('Add'))
            ]),
          ),
        )
      ]),
    );
  }
}
