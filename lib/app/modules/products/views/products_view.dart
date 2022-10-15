import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wekeep/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:wekeep/app/modules/products/controllers/products_controller.dart';
import 'package:wekeep/app/modules/products/views/productDetails_view.dart';
import 'package:wekeep/app/ui/theme/color_theme.dart';

class ProductsView extends GetView<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Center(
      child: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                          "Welcome ${controller.auth.currentUser!.displayName!.split(' ')[0].toString()}!",
                          style: TextStyle(
                              fontSize: 24,
                              // fontWeight: FontWeight,
                              color: Colors.white),
                        ),
                        GFAvatar(
                          shape: GFAvatarShape.standard,
                          backgroundImage: NetworkImage(
                              controller.auth.currentUser!.photoURL.toString()),
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
                            onPressed: () async {
                              await controller.logoutGoogle();
                            },
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
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            GetX<ProductsController>(
                init: Get.find<ProductsController>(),
                builder: (ProductsController productsController) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: productsController.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          final _productModel =
                              productsController.products[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
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
                                    onTap: () {
                                      Get.to(() => ProductDetailsView(),
                                          arguments: _productModel);
                                    },
                                    icon: GestureDetector(
                                      onTap: (() {
                                        Get.defaultDialog(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20),
                                            titlePadding:
                                                EdgeInsets.only(top: 10),
                                            title: '',
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: SvgPicture.asset(
                                                      'assets/images/delete.svg'),
                                                  height: height * 0.2,
                                                  width: width * 0.5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 18.0),
                                                  child: Text(
                                                    'All the content related to your product will be lost forever!',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .red)),
                                                          onPressed: () async {
                                                            Get.back(
                                                                closeOverlays:
                                                                    true);
                                                            await productsController
                                                                .repository
                                                                .deleteProduct(
                                                                    _productModel,
                                                                    controller
                                                                        .auth
                                                                        .currentUser!
                                                                        .uid);

                                                            Get.snackbar(
                                                              'Success!',
                                                              'Deleted product!',
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .BOTTOM,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              borderRadius: 20,
                                                              margin: EdgeInsets
                                                                  .all(15),
                                                              colorText:
                                                                  Colors.white,
                                                              duration:
                                                                  Duration(
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
                                                          child:
                                                              Text('Delete')),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                          kprimaryColor)),
                                                          child: Text('Cancel'))
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
                                    ),
                                    enabled: true,
                                    titleText: _productModel.name,
                                    subTitleText:
                                        'Expires in ${_productModel.warrantyMonths} months',
                                    avatar: GFAvatar(
                                      backgroundImage: NetworkImage(
                                        _productModel.receiptUrl.toString(),
                                      ),
                                      shape: GFAvatarShape.standard,
                                    )),
                              ),
                            ),
                          );
                        }),
                  );
                }),
          ],
        )),
      ),
    );
  }
}
