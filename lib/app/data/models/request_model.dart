import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String img;
  String desc;
  String name;

  RequestModel({required this.img, required this.name, required this.desc});
}
