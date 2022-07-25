import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/repositories/service_repository.dart';
import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/service/controllers/service_controller.dart';

class ProductDetailsView extends GetView<AuthenticationController> {
  final ProductModel _productModel = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Image.network(
                    _productModel.receiptUrl.toString(),
                    fit: BoxFit.fitWidth,
                  ),
                  height: 300,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(fontSize: 21),
                            ),
                            Text(
                              '${_productModel.name}',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Category',
                              style: TextStyle(fontSize: 21),
                            ),
                            Text(
                              '${_productModel.categoryName}',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Warranty Months',
                              style: TextStyle(fontSize: 21),
                            ),
                            Text(
                              '${_productModel.warrantyMonths}',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Notes',
                              style: TextStyle(fontSize: 21),
                            ),
                            Text(
                              '${_productModel.notes}',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Update'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Get.defaultDialog(
                              title: 'Are you sure?',
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red)),
                                      onPressed: () async {
                                        Get.back(closeOverlays: true);
                                        Get.offNamed('/home');
                                        await FirestoreDb.deleteProduct(
                                            _productModel.productId.toString(),
                                            controller.auth.currentUser!.uid);

                                        Get.snackbar(
                                          'Success!',
                                          'Deleted product!',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          borderRadius: 20,
                                          margin: EdgeInsets.all(15),
                                          colorText: Colors.white,
                                          duration: Duration(seconds: 4),
                                          isDismissible: true,
                                          dismissDirection:
                                              DismissDirection.horizontal,
                                          forwardAnimationCurve:
                                              Curves.easeOutBack,
                                        );
                                      },
                                      child: Text('Yes')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('Cancel'))
                                ],
                              ));
                        },
                        child: Text('Delete'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.yellow),
                        ),
                        onPressed: () async {
                          final serviceController = Get.put(ServiceController(
                              repository: ServiceRepository()));
                          serviceController.center.value =
                              await serviceController.getLocation();
                          Get.toNamed('/service');
                        },
                        child: Text(
                          'Request Service',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ]));
  }
}
