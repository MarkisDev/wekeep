import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wekeep/app/data/models/category_model.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';

import '../../../ui/theme/color_theme.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    final AuthenticationController authenticationController =
        Get.find<AuthenticationController>();
    return Obx(() => Center(
          child: Column(
            children: [
              Container(
                height: height * 0.2,
                decoration: BoxDecoration(
                    color: kprimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Welcome ${authenticationController.auth.currentUser!.displayName!.split(' ')[0].toString()}!",
                            style: TextStyle(
                                fontSize: 24,
                                // fontWeight: FontWeight,
                                color: Colors.white),
                          ),
                          GFAvatar(
                            shape: GFAvatarShape.standard,
                            backgroundImage: NetworkImage(
                                authenticationController
                                    .auth.currentUser!.photoURL
                                    .toString()),
                            size: 30,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GFButton(
                              onPressed: () {},
                              icon: Icon(Icons.logout),
                              color: Colors.white,
                              text: ('Logout'),
                              textColor: Colors.black,
                            ),
                            GFButton(
                              onPressed: () {},
                              color: Color(0xff1d1d1d),
                              text: ('Support'),
                              icon: Icon(
                                Icons.support_agent_outlined,
                                color: Colors.white,
                              ),
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              (controller.categories.length == 0)
                  ? Column(
                      children: [
                        Container(
                          child: SvgPicture.asset('assets/images/empty2.svg'),
                          height: height * 0.4,
                          width: width * 0.5,
                        ),
                        Text(
                          'To get started, add a new category!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: controller.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final _categoryModel = controller.categories[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(12, 15, 12, 10),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 0.2,
                                          blurRadius: 12,
                                          offset: Offset(0, 7),
                                        )
                                      ]),
                                  child: GFListTile(
                                      onTap: () {},
                                      icon: (_categoryModel.count == 0)
                                          ? GestureDetector(
                                              onTap: (() {
                                                Get.defaultDialog(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    titlePadding:
                                                        EdgeInsets.only(
                                                            top: 10),
                                                    title: '',
                                                    content: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: SvgPicture.asset(
                                                              'assets/images/delete.svg'),
                                                          height: height * 0.2,
                                                          width: width * 0.5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18.0),
                                                          child: Text(
                                                            'All the content related to your product will be lost forever!',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 12.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(Colors
                                                                              .red)),
                                                                  onPressed:
                                                                      () async {
                                                                    await controller.repository.deleteCategory(
                                                                        _categoryModel
                                                                            .categoryId
                                                                            .toString(),
                                                                        authenticationController
                                                                            .auth
                                                                            .currentUser!
                                                                            .uid);
                                                                    Get.back();

                                                                    Get.snackbar(
                                                                      'Success!',
                                                                      'Deleted category!',
                                                                      snackPosition:
                                                                          SnackPosition
                                                                              .BOTTOM,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      borderRadius:
                                                                          20,
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              15),
                                                                      colorText:
                                                                          Colors
                                                                              .white,
                                                                      duration: Duration(
                                                                          seconds:
                                                                              4),
                                                                      isDismissible:
                                                                          true,
                                                                      dismissDirection:
                                                                          DismissDirection
                                                                              .horizontal,
                                                                      forwardAnimationCurve:
                                                                          Curves
                                                                              .easeOutBack,
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                      'Delete')),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(
                                                                              kprimaryColor)),
                                                                  child: Text(
                                                                      'Cancel'))
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              }),
                                              child: Icon(
                                                Icons.delete_outline,
                                                size: 28,
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: (() {
                                                Get.defaultDialog(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    titlePadding:
                                                        EdgeInsets.only(
                                                            top: 10),
                                                    title: '',
                                                    content: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: SvgPicture.asset(
                                                              'assets/images/notify.svg'),
                                                          height: height * 0.2,
                                                          width: width * 0.5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18.0),
                                                          child: Text(
                                                            'You have one or more products in this category, so it cannot be deleted!',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 12.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(
                                                                              kprimaryColor)),
                                                                  child: Text(
                                                                      'Okay!'))
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              }),
                                              child: Icon(
                                                Icons.disabled_by_default,
                                                size: 28,
                                              ),
                                            ),
                                      enabled: true,
                                      titleText: _categoryModel.name!,
                                      subTitleText:
                                          '${_categoryModel.count} products in this category!',
                                      avatar: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: GFAvatar(
                                          shape: GFAvatarShape.circle,
                                          backgroundColor:
                                              controller.getColorFromHex(
                                                  _categoryModel.color),
                                          size: 22,
                                        ),
                                      )),
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
  final CategoriesController categoriesController =
      Get.find<CategoriesController>();
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: SvgPicture.asset('assets/images/addCategory.svg'),
                height: height * 0.2,
              ),
              TextFormField(
                controller: categoriesController.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GFButton(
                        type: GFButtonType.outline2x,
                        color: kprimaryColor,
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: kprimaryColor,
                            fontWeight: FontWeight.w500),
                        onPressed: () {
                          Get.defaultDialog(
                              content: Obx(() => ColorPicker(
                                    pickerColor:
                                        categoriesController.pickedColor.value,
                                    onColorChanged:
                                        categoriesController.changeColor,
                                  )));
                        },
                        child: (categoriesController.categoryChanged == false)
                            ? Expanded(child: Text('Choose color'))
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Choose color'),
                                  GFAvatar(
                                    backgroundColor:
                                        categoriesController.pickedColor.value,
                                    size: 14,
                                  ),
                                ],
                              )),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    if (categoriesController.nameController.text.isEmpty) {
                      Get.snackbar(
                        'Error!',
                        'Enter a category name!',
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
                    } else {
                      CategoryModel categoryModel = CategoryModel(
                          '#${categoriesController.pickedColor.value.value.toRadixString(16)}',
                          categoriesController.nameController.text);
                      await categoriesController.repository.addCategory(
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
                    }
                  },
                  child: Text('Add Category'))
            ],
          ),
        ),
      ),
    );
  }
}
