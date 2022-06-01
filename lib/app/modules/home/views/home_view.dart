import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:wekeep/app/modules/home/views/add_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO : Make auth global!!!!!!
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddView(), arguments: Get.arguments.uid);
        },
        child: Icon(Icons.add),
      ),
      appBar: appBar,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Welcome ${Get.arguments.displayName.toString()}!',
              style: TextStyle(fontSize: 21),
            ),
          ),
          GetX<HomeController>(
              init: Get.put<HomeController>(HomeController()),
              builder: (HomeController homeController) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: homeController.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final _productModel = homeController.products[index];
                        return Card(
                          child: ListTile(
                            title: Text(_productModel.name),
                            subtitle: Text(
                                'Expires in ${_productModel.warrantyMonths} months'),
                          ),
                        );
                      }),
                );
              }),
        ],
      )),
    );
  }
}
