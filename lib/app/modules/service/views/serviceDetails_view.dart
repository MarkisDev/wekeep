import 'package:flutter/material.dart';
import 'package:wekeep/app/data/models/serviceProvider_model.dart';
import 'package:wekeep/app/global_widgets/appBar.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:wekeep/app/modules/service/views/request_view.dart';

class ServiceDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceModel = Get.arguments;
    return Scaffold(
      appBar: appBar,
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '${serviceModel.name}',
              style: TextStyle(fontSize: 21),
            ),
          ),
          Image.network(
            serviceModel.imgUrl,
            height: 250,
            width: 250,
          ),
          Card(
              child: ListTile(
                  title: Center(
                      child: Text("${serviceModel.howFar} from your location")),
                  trailing: Icon(Icons.directions),
                  onTap: () => MapsLauncher.launchCoordinates(
                      12.994266576691665, 77.67270786721555))),
          Card(
              child: ListTile(
            title: Center(child: Text("Avg price  - \u{20B9}1000")),
          )),
          ElevatedButton(
              onPressed: () {
                Get.to(RequestView());
              },
              child: Text('Send request')),
        ],
      )),
    );
  }
}