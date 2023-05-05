import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';

import 'package:wekeep/app/ui/widgets/appBar.dart';
import 'package:wekeep/app/modules/categories/views/categories_view.dart';
import 'package:wekeep/app/modules/products/views/add_view.dart';
import 'package:wekeep/app/modules/products/views/products_view.dart';
import 'package:wekeep/app/ui/theme/color_theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO : Make auth global!!!!!!
    return Scaffold(
        // backgroundColor: kprimaryColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kprimaryColor,
          onPressed: () {
            controller.tabIndex.value == 0
                ? Get.to(() => AddView(), arguments: Get.arguments)
                : categoryForm();
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
                  icon: Icon(Icons.menu_open_outlined),
                  label: 'Category',
                ),
              ],
              selectedItemColor: Colors.black,
              currentIndex: controller.tabIndex.value,
              onTap: controller.changeTabIndex,
            )),
        appBar: AppBar(
          // title: Text('Home'),
          centerTitle: true,
          backgroundColor: kprimaryColor,
          elevation: 0,
        ),
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [ProductsView(), CategoriesView()],
          ),
        ));
  }
}
