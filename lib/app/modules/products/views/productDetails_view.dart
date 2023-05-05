import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/repositories/service_repository.dart';
import 'package:wekeep/app/ui/theme/color_theme.dart';
import 'package:wekeep/app/ui/widgets/appBar.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/service/controllers/service_controller.dart';

class ProductDetailsView extends GetView<AuthenticationController> {
  final ProductModel _productModel = Get.arguments;
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kprimaryColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.topCenter,
                            image: new NetworkImage(
                              _productModel.productUrl.toString(),
                            ),
                          ),
                        ),
                      )),
                  height: height * 0.3,
                  decoration: BoxDecoration(
                      color: kprimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Row(
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Text(
                //                 'Product Name',
                //                 style: TextStyle(fontSize: 21),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.only(top: 5.0),
                //                 child: Text(
                //                   "Phone",
                //                   style: TextStyle(fontSize: 18),
                //                 ),
                //               )
                //             ],
                //           )
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Text(
                //                 'Category Name',
                //                 style: TextStyle(fontSize: 21),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.only(top: 5.0),
                //                 child: Text(
                //                   "Phone",
                //                   style: TextStyle(fontSize: 18),
                //                 ),
                //               )
                //             ],
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // ),

                GFAccordion(
                  title: 'Product Details',
                  collapsedTitleBackgroundColor: Colors.grey.shade200,
                  contentChild: Column(
                    children: [
                      GFListTile(
                        titleText: 'Product Name',
                        subTitleText: _productModel.name,
                      ),
                      GFListTile(
                        titleText: 'Category Name',
                        subTitleText: _productModel.categoryName,
                      ),
                      GFListTile(
                        titleText: 'Purchase Date',
                        subTitleText: _productModel.purchaseDate,
                      ),
                      GFListTile(
                        titleText: 'Warranty Expiry Date',
                        subTitleText: _productModel.warrantyDate,
                      ),
                      GFListTile(
                        titleText: 'Warranty Months',
                        subTitleText: '${_productModel.warrantyMonths}',
                      ),
                      GFListTile(
                        titleText: 'Notes',
                        description: Text(_productModel.notes.toString()),
                      ),
                    ],
                  ),
                ),
                GFAccordion(
                    title: 'Service History',
                    collapsedTitleBackgroundColor: Colors.grey.shade200),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              'Update',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Color(0xff1557c0), Color(0xff2382f7)],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        height: height * 0.10,
                        width: width * 0.25,
                      ),
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              titlePadding: EdgeInsets.only(top: 10),
                              title: '',
                              content: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
                                        'assets/images/delete.svg'),
                                    height: height * 0.2,
                                    width: width * 0.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Text(
                                      'All the content related to your product will be lost forever!',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
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
                                              await FirestoreDb.deleteProduct(
                                                  _productModel,
                                                  controller
                                                      .auth.currentUser!.uid);
                                              Get.snackbar(
                                                'Success!',
                                                'Deleted product!',
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
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
                                            child: Text('Delete')),
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        kprimaryColor)),
                                            child: Text('Cancel'))
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Color(0xffff0000), Color(0xffb50000)],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          height: height * 0.10,
                          width: width * 0.25,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final serviceController = Get.put(ServiceController(
                              repository: ServiceRepository()));
                          serviceController.center.value =
                              await serviceController.getLocation();
                          Get.toNamed('/service');
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.update,
                                color: Colors.white,
                              ),
                              Text(
                                'Service',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xffedc531),
                                  Color(0xffc9a227),
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          height: height * 0.10,
                          width: width * 0.25,
                        ),
                      ),
                    ],
                  ),
                )
                // Center(
                //   child: Container(
                //     padding: EdgeInsets.all(10.0),
                //     child: Image.network(
                //       _productModel.receiptUrl.toString(),
                //       fit: BoxFit.fitWidth,
                //     ),
                //     height: 300,
                //   ),
                // ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Container(
                //       padding: EdgeInsets.all(10.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           Column(
                //             children: [
                //               Text(
                //                 'Name',
                //                 style: TextStyle(fontSize: 21),
                //               ),
                //               Text(
                //                 '${_productModel.name}',
                //                 style: TextStyle(fontSize: 18),
                //               )
                //             ],
                //           ),
                //           Column(
                //             children: [
                //               Text(
                //                 'Category',
                //                 style: TextStyle(fontSize: 21),
                //               ),
                //               Text(
                //                 '${_productModel.categoryName}',
                //                 style: TextStyle(fontSize: 18),
                //               )
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       padding: EdgeInsets.all(10.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           Column(
                //             children: [
                //               Text(
                //                 'Warranty Months',
                //                 style: TextStyle(fontSize: 21),
                //               ),
                //               Text(
                //                 '${_productModel.warrantyMonths}',
                //                 style: TextStyle(fontSize: 18),
                //               )
                //             ],
                //           ),
                //           Column(
                //             children: [
                //               Text(
                //                 'Notes',
                //                 style: TextStyle(fontSize: 21),
                //               ),
                //               Text(
                //                 '${_productModel.notes}',
                //                 style: TextStyle(fontSize: 18),
                //               )
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //     Column(
                //       children: [
                //         ElevatedButton(
                //           onPressed: () {},
                //           child: Text('Update'),
                //         ),
                //         ElevatedButton(
                //           onPressed: () async {
                //             Get.defaultDialog(
                //                 title: 'Are you sure?',
                //                 content: Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceEvenly,
                //                   children: [
                //                     ElevatedButton(
                //                         style: ButtonStyle(
                //                             backgroundColor:
                //                                 MaterialStateProperty.all(
                //                                     Colors.red)),
                //                         onPressed: () async {
                //                           Get.back(closeOverlays: true);
                //                           Get.offNamed('/home');
                //                           await FirestoreDb.deleteProduct(
                //                               _productModel,
                //                               controller.auth.currentUser!.uid);

                //                           Get.snackbar(
                //                             'Success!',
                //                             'Deleted product!',
                //                             snackPosition: SnackPosition.BOTTOM,
                //                             backgroundColor: Colors.red,
                //                             borderRadius: 20,
                //                             margin: EdgeInsets.all(15),
                //                             colorText: Colors.white,
                //                             duration: Duration(seconds: 4),
                //                             isDismissible: true,
                //                             dismissDirection:
                //                                 DismissDirection.horizontal,
                //                             forwardAnimationCurve:
                //                                 Curves.easeOutBack,
                //                           );
                //                         },
                //                         child: Text('Yes')),
                //                     ElevatedButton(
                //                         onPressed: () {
                //                           Get.back();
                //                         },
                //                         child: Text('Cancel'))
                //                   ],
                //                 ));
                //           },
                //           child: Text('Delete'),
                //         ),
                //         ElevatedButton(
                //           style: ButtonStyle(
                //             backgroundColor:
                //                 MaterialStateProperty.all(Colors.yellow),
                //           ),
                //           onPressed: () async {
                //             final serviceController = Get.put(ServiceController(
                //                 repository: ServiceRepository()));
                //             serviceController.center.value =
                //                 await serviceController.getLocation();
                //             Get.toNamed('/service');
                //           },
                //           child: Text(
                //             'Request Service',
                //             style: TextStyle(color: Colors.black),
                //           ),
                //         ),
                //   ],
                // )
                //   ],
                // )
              ]),
        ));
  }
}
