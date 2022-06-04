import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/home/views/add_view.dart';
import 'package:wekeep/app/modules/home/views/category_view.dart';
import 'package:wekeep/app/modules/home/views/home_view.dart';

import '../controllers/home_controller.dart';

class MainView extends GetView<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    // TODO : Make auth global!!!!!!
    return Scaffold(
        bottomNavigationBar: GetX<HomeController>(
            init: Get.find<HomeController>(),
            builder: (HomeController homeController) {
              return BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Business',
                  ),
                ],
                selectedItemColor: Colors.amber[800],
                currentIndex: homeController.tabIndex.value,
                onTap: homeController.changeTabIndex,
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddView());
          },
          child: Icon(Icons.add),
        ),
        appBar: appBar,
        body: GetX<HomeController>(
          init: Get.find<HomeController>(),
          builder: (HomeController homeController) {
            return IndexedStack(
              index: homeController.tabIndex.value,
              children: [HomeView(), CategoryView()],
            );
          },
        ));
  }
}
