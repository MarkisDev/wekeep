import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:get/get.dart';
import 'package:wekeep/app/data/models/category_model.dart';
import 'package:wekeep/app/data/providers/firestorage_provider.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/home/controllers/category_controller.dart';
import 'package:wekeep/app/modules/home/controllers/home_controller.dart';
import 'package:wekeep/app/modules/home/views/product_view.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController =
        Get.find<AuthenticationController>();
    return Obx(() => Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: controller.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _categoryModel = controller.categories[index];
                      return GestureDetector(
                        onTap: () => {},
                        child: Card(
                          child: ListTile(
                            leading: Container(
                              color: controller
                                  .getColorFromHex(_categoryModel.color),
                              height: 50,
                              width: 50,
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  await FirestoreDb.deleteCategory(
                                      _categoryModel.categoryId.toString(),
                                      authenticationController
                                          .auth.currentUser!.uid);
                                  Get.snackbar(
                                    'Success!',
                                    'Deleted category!',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    borderRadius: 20,
                                    margin: EdgeInsets.all(15),
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 4),
                                    isDismissible: true,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    forwardAnimationCurve: Curves.easeOutBack,
                                  );
                                }),
                            title: Text(_categoryModel.name!),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}

class categoryForm extends GetView<AuthenticationController> {
  categoryForm(this.categoryController);
  late final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: categoryController.nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                icon: Icon(Icons.account_box),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                      content: ColorPicker(
                    pickerColor: categoryController.pickedColor.value,
                    onColorChanged: categoryController.changeColor,
                  ));
                },
                child: Text('Choose color')),
            ElevatedButton(
                onPressed: () async {
                  CategoryModel categoryModel = CategoryModel(
                      '#${categoryController.pickedColor.value.value.toRadixString(16)}',
                      categoryController.nameController.text);
                  await FirestoreDb.addCategory(
                      categoryModel, controller.auth.currentUser!.uid);
                  Get.snackbar(
                    'Success!',
                    'Added Category!',
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
                },
                child: Text('Add Category'))
          ],
        ),
      ),
    );
  }
}
