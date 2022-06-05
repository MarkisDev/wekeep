import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wekeep/app/data/models/category_model.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';

import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/home/controllers/category_controller.dart';
import 'package:wekeep/app/modules/home/views/add_view.dart';
import 'package:wekeep/app/modules/home/views/category_view.dart';
import 'package:wekeep/app/modules/home/views/home_view.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../controllers/home_controller.dart';

class MainView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        Get.find<CategoryController>();
    // TODO : Make auth global!!!!!!
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.tabIndex.value == 0
                ? Get.to(() => AddView())
                : Get.defaultDialog(
                    title: 'Add category',
                    content: categoryForm(categoryController),
                  );
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Category',
                ),
              ],
              selectedItemColor: Colors.amber[800],
              currentIndex: controller.tabIndex.value,
              onTap: controller.changeTabIndex,
            )),
        appBar: appBar,
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [HomeView(), CategoryView()],
          ),
        ));
  }
}
