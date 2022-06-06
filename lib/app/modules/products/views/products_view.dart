import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/products/controllers/products_controller.dart';
import 'package:wekeep/app/modules/products/views/productDetails_view.dart';

class ProductsView extends GetView<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Welcome ${controller.auth.currentUser!.displayName.toString()}!',
            style: TextStyle(fontSize: 21),
          ),
        ),
        GetX<ProductsController>(
            init: Get.find<ProductsController>(),
            builder: (ProductsController productsController) {
              return Expanded(
                child: ListView.builder(
                    itemCount: productsController.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _productModel = productsController.products[index];
                      return GestureDetector(
                        onTap: () => {
                          Get.to(() => ProductDetailsView(),
                              arguments: _productModel)
                        },
                        child: Card(
                          child: ListTile(
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
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
                                                await productsController
                                                    .repository
                                                    .deleteProduct(
                                                        _productModel.productId
                                                            .toString(),
                                                        controller.auth
                                                            .currentUser!.uid);

                                                Get.snackbar(
                                                  'Success!',
                                                  'Deleted product!',
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  borderRadius: 20,
                                                  margin: EdgeInsets.all(15),
                                                  colorText: Colors.white,
                                                  duration:
                                                      Duration(seconds: 4),
                                                  isDismissible: true,
                                                  dismissDirection:
                                                      DismissDirection
                                                          .horizontal,
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
                                }),
                            title: Text(_productModel.name),
                            subtitle: Text(
                                'Expires in ${_productModel.warrantyMonths} months'),
                          ),
                        ),
                      );
                    }),
              );
            }),
      ],
    ));
  }
}