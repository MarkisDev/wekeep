import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/categories/controllers/categories_controller.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:wekeep/app/modules/products/controllers/products_controller.dart';

class AddView extends GetView<ProductsController> {
  final authenticationController = Get.find<AuthenticationController>();
  final categoriesController = Get.find<CategoriesController>();
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
              //   controller: controller.categoriesController,
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
              GetX<CategoriesController>(
                  init: Get.find<CategoriesController>(),
                  builder: (CategoriesController categoriesController) {
                    List<Map<String, dynamic>> categoriesMap =
                        categoriesController.getCategories();
                    return SelectFormField(
                        type: SelectFormFieldType.dropdown, // or can be dialog
                        labelText: 'Category',
                        initialValue: 'Choose a category!',
                        items: categoriesMap,
                        onChanged: (val) {
                          for (final m in categoriesMap) {
                            if (m['value'] == val) {
                              categoriesController.pickedCategoryName.value =
                                  m['label'];
                            }
                          }
                          categoriesController.pickedCategoryId.value = val;
                        });
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
                          categoryId:
                              categoriesController.pickedCategoryId.value,
                          categoryName:
                              categoriesController.pickedCategoryName.value,
                          warrantyMonths: int.parse(
                              controller.warrantyMonthsController.text),
                          notes: controller.notesController.text,
                          receiptUrl: recieptUrl);
                      await controller.repository.addProduct(productModel,
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
