import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:wekeep/app/modules/home/views/add_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddView());
        },
        child: Icon(Icons.add),
      ),
      appBar: appBar,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Welcome Get.arguments.displayName.toString()'),
          Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text('Phone'),
                      subtitle: Text('Expires on 23/02/22'),
                    ),
                  );
                }),
          )
        ],
      )),
    );
  }
}
