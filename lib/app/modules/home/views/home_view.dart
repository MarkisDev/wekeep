import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:wekeep/app/modules/categories/views/categories_view.dart';
import 'package:wekeep/app/modules/products/views/add_view.dart';
import 'package:wekeep/app/modules/products/views/products_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO : Make auth global!!!!!!
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.tabIndex.value == 0
                ? Get.to(() => AddView())
                : Get.defaultDialog(
                    title: 'Add category',
                    content: categoryForm(),
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
            children: [ProductsView(), CategoriesView()],
          ),
        ));
  }
}
