import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProvider {
  late String name;
  late double howFar;
  late String imgUrl;
  late GeoPoint coords;
  ServiceProvider(
      {required this.name,
      required this.howFar,
      required this.imgUrl,
      required this.coords});
}
