import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wekeep/app/modules/service/views/serviceDetails_view.dart';

import '../controllers/service_controller.dart';

class ServiceView extends GetView<ServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ServiceView'),
        centerTitle: true,
      ),
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
      body: Center(
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: ListView.builder(
                    itemCount: controller.shops.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _serviceProviderModel = controller.shops[index];
                      return GestureDetector(
                        onTap: () => {},
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ServiceDetailsView(),
                                arguments: _serviceProviderModel);
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(_serviceProviderModel.name),
                              subtitle:
                                  Text(_serviceProviderModel.howFar.toString()),
                              trailing: Icon(Icons.directions),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
