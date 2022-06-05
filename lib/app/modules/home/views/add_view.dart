import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/home/controllers/add_controller.dart';
import 'package:wekeep/app/modules/home/controllers/category_controller.dart';
import '../controllers/home_controller.dart';
import 'package:select_form_field/select_form_field.dart';

class AddView extends GetView<AddController> {
  final authenticationController = Get.find<AuthenticationController>();
  final categoryController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
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
                keyboardType: TextInputType.number,
                controller: controller.warrantyMonthsController,
                decoration: const InputDecoration(labelText: 'Warranty Months'),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Warranty Months is not valid!';
                  } else {
                    return null;
                  }
                },
              ),
              // TextFormField(
              //   controller: controller.categoryController,
              //   decoration: const InputDecoration(labelText: 'Category'),
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Category is not valid!';
              //     } else {
              //       return null;
              //     }
              //   },
              // ),
              GetX<CategoryController>(
                  init: Get.find<CategoryController>(),
                  builder: (CategoryController categoryController) {
                    return SelectFormField(
                      type: SelectFormFieldType.dropdown, // or can be dialog
                      initialValue: 'Phone',
                      labelText: 'Category',
                      items: categoryController.getCategories(),
                      onChanged: (val) =>
                          categoryController.pickedCategoryName.value = val,
                    );
                  }),

              TextFormField(
                controller: controller.notesController,
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
              Obx(() => TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Receipt Image',
                        hintText: controller.recieptHintText.value,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () async {
                            controller.recieptHintText.value = 'Image uploaded';
                            controller.recieptImagePath.value =
                                await controller.selectImage();
                            print(controller.recieptImagePath.value);
                          },
                        )),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      final recieptUrl = await controller.uploadImage(
                          'receipts', controller.recieptImagePath.value);
                      final productModel = ProductModel(
                          name: controller.nameController.text,
                          category: categoryController.pickedCategoryName.value,
                          warrantyMonths: int.parse(
                              controller.warrantyMonthsController.text),
                          notes: controller.notesController.text,
                          receiptUrl: recieptUrl);
                      await FirestoreDb.addProduct(productModel,
                          authenticationController.auth.currentUser!.uid);
                      Get.offNamed('/home');
                      Get.snackbar(
                        'Success!',
                        'Added product!',
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
                    }
                  },
                  child: Text('Add'))
            ]),
          ),
        )
      ]),
    );
  }
}
