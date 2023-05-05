import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/ui/widgets/appBar.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/categories/controllers/categories_controller.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:wekeep/app/modules/products/controllers/products_controller.dart';
import 'package:wekeep/app/ui/theme/color_theme.dart';
import 'package:intl/intl.dart';

class AddView extends GetView<ProductsController> {
  final authenticationController = Get.find<AuthenticationController>();
  final categoriesController = Get.find<CategoriesController>();
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      appBar: getAppBar(''),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Center(child: Text('Enter product details')),
                  Container(
                    child: SvgPicture.asset('assets/images/addProduct.svg'),
                    height: height * 0.3,
                    width: width * 0.5,
                  ),
                  Text(
                    'Enter the new product details!',
                    style: TextStyle(fontSize: 21),
                  ),
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
                  //   keyboardType: TextInputType.number,
                  //   controller: controller.warrantyMonthsController,
                  //   decoration:
                  //       const InputDecoration(labelText: 'Warranty Months'),
                  //   inputFormatters: <TextInputFormatter>[
                  //     FilteringTextInputFormatter.digitsOnly,
                  //   ],
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Warranty Months is not valid!';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.alarm),
                          label: Text('Purchase date'),
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: controller.purchaseDate.value,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            if (newDate == null) return;
                            controller.purchaseDate.value = newDate;
                          },
                        ),
                        Obx(() => Text(
                              controller
                                  .stringDate(controller.purchaseDate.value),
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                            )),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.alarm),
                          label: Text('Warranty Expiry date'),
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: controller.warrantyDate.value,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            if (newDate == null) return;
                            controller.warrantyDate.value = newDate;
                          },
                        ),
                        Obx(() => Text(
                              controller
                                  .stringDate(controller.warrantyDate.value),
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                            )),
                      ]),
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
                            autovalidate: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Notes is not valid!';
                              } else {
                                return null;
                              }
                            },
                            enabled: (categoriesMap.length == 0) ? false : true,
                            type: SelectFormFieldType
                                .dropdown, // or can be dialog
                            labelText: (categoriesMap.length == 0)
                                ? 'Add a category first!'
                                : 'Category',
                            initialValue: 'Choose a category!',
                            items: categoriesMap,
                            onChanged: (val) {
                              for (final m in categoriesMap) {
                                if (m['value'] == val) {
                                  categoriesController
                                      .pickedCategoryName.value = m['label'];
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
                                controller.recieptHintText.value =
                                    'Image uploaded';
                                controller.recieptImagePath.value =
                                    await controller.selectImage();
                                print(controller.recieptImagePath.value);
                              },
                            )),
                      )),

                  Obx(() => TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'Product Image',
                            hintText: controller.productHintText.value,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () async {
                                controller.productHintText.value =
                                    'Image uploaded';
                                controller.productImagePath.value =
                                    await controller.selectImage();
                              },
                            )),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kprimaryColor),
                            minimumSize: MaterialStateProperty.all(
                                Size(double.infinity, 40))),
                        onPressed: () async {
                          if (categoriesController.categoryList.length != 0 &&
                              controller.formKey.currentState!.validate()) {
                            final recieptUrl = await controller.uploadImage(
                                'receipts', controller.recieptImagePath.value);
                            final productUrl = await controller.uploadImage(
                                'products', controller.productImagePath.value);
                            final productModel = ProductModel(
                                warrantyDate: controller
                                    .stringDate(controller.warrantyDate.value),
                                purchaseDate: controller
                                    .stringDate(controller.purchaseDate.value),
                                name: controller.nameController.text,
                                categoryId:
                                    categoriesController.pickedCategoryId.value,
                                categoryName: categoriesController
                                    .pickedCategoryName.value,
                                warrantyMonths: controller
                                    .monthsUntil(controller.warrantyDate.value),
                                notes: controller.notesController.text,
                                receiptUrl: recieptUrl,
                                productUrl: productUrl);
                            await controller.repository.addProduct(productModel,
                                authenticationController.auth.currentUser!.uid);
                            await controller.scheduleReminders(
                              controller.nameController.text,
                              controller.warrantyDate.value,
                              controller
                                  .authenticationController.userModel.token
                                  .toString(),
                            );

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
                            controller.nameController.clear();
                            controller.notesController.clear();
                            controller.warrantyMonthsController.clear();
                          } else {
                            Get.snackbar(
                              'Error!',
                              'Please fix all the errors!',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
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
                        child: Text('Add new product')),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
