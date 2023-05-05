import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wekeep/app/modules/service/views/serviceDetails_view.dart';
import 'package:wekeep/app/ui/widgets/appBar.dart';

import '../controllers/service_controller.dart';

class ServiceView extends GetView<ServiceController> {
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      appBar: getAppBar(''),
      // body: Center(
      //     child: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(
      //         'Nearest Service Providers',
      //         style: TextStyle(fontSize: 21),
      //       ),
      //     ),
      //     Expanded(
      //       child: ListView(
      //         children: [
      //           GestureDetector(
      //             onTap: () {
      //               ServiceProvider serviceProvider = ServiceProvider(
      //                   name: 'Ramnagar Service Shop',
      //                   howFar: '2 km',
      //                   imgUrl:
      //                       'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
      //               Get.to(ServiceDetailsView(), arguments: serviceProvider);
      //             },
      //             child: Card(
      //               child: ListTile(
      //                 title: Text('Ramnagar Service shop'),
      //                 subtitle: Text('2 km away from you'),
      //                 trailing: Icon(Icons.directions),
      //               ),
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: () {
      //               ServiceProvider serviceProvider = ServiceProvider(
      //                   name: 'KR Puram Service Shop',
      //                   howFar: '5 km',
      //                   imgUrl:
      //                       'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
      //               Get.to(ServiceDetailsView(), arguments: serviceProvider);
      //             },
      //             child: Card(
      //               child: ListTile(
      //                 title: Text('KR Puram Service shop'),
      //                 subtitle: Text('5 km away from you'),
      //                 trailing: Icon(Icons.directions),
      //               ),
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: () {
      //               ServiceProvider serviceProvider = ServiceProvider(
      //                   name: 'Jaynagar Service Shop',
      //                   howFar: '10 km',
      //                   imgUrl:
      //                       'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
      //               Get.to(ServiceDetailsView(), arguments: serviceProvider);
      //             },
      //             child: Card(
      //               child: ListTile(
      //                 title: Text('Jaynagar Service shop'),
      //                 subtitle: Text('10 km away from you'),
      //                 trailing: Icon(Icons.directions),
      //               ),
      //             ),
      //           ),

      //         ],
      //       ),
      //     ),
      //   ],
      // )),
      body: Column(
        children: [
          Container(
            child: SvgPicture.asset('assets/images/service.svg'),
            height: height * 0.25,
            width: width * 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Nearest Service Providers',
              style: TextStyle(fontSize: 21),
            ),
          ),
          Obx(() {
            return Expanded(
              child: ListView.builder(
                  itemCount: controller.shops.length,
                  itemBuilder: (BuildContext context, int index) {
                    final _serviceProviderModel = controller.shops[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.3),
                      child: InkWell(
                        onTap: () {
                          Get.to(ServiceDetailsView(),
                              arguments: _serviceProviderModel);
                        },
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 0.2,
                              blurRadius: 12,
                              offset: Offset(0, 7),
                            )
                          ]),
                          child: GFListTile(
                            icon: Wrap(children: [
                              IconButton(
                                icon: Icon(Icons.phone),
                                onPressed: () async {
                                  var url =
                                      "tel:${_serviceProviderModel.phoneNum}";
                                  if (await canLaunchUrlString(url)) {
                                    await launchUrlString(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.directions),
                                onPressed: () async {
                                  MapsLauncher.launchCoordinates(
                                      _serviceProviderModel.coords.latitude,
                                      _serviceProviderModel.coords.longitude);
                                },
                              )
                            ]),
                            titleText: _serviceProviderModel.name,
                            subTitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                        "${_serviceProviderModel.address}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                        "${_serviceProviderModel.howFar.toString()} km away!"),
                                  )
                                ]),
                            // subTitleText:
                            //     "${_serviceProviderModel.howFar.toString()} km away!",
                          ),
                        ),
                      ),
                    );
                    // return GestureDetector(
                    //   onTap: () => {},
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Get.to(ServiceDetailsView(),
                    //           arguments: _serviceProviderModel);
                    //     },
                    //     child: Card(
                    //       child: ListTile(
                    //         title: Text(_serviceProviderModel.name),
                    //         subtitle: Text(
                    //             "${_serviceProviderModel.howFar.toString()} km away!"),
                    //         trailing: Icon(Icons.directions),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  }),
            );
          }),
        ],
      ),
    );
  }
}
