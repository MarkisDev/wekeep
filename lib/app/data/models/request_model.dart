import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String img;
  String desc;
  String name;
  String uid;
  String token;

  RequestModel(
      {required this.img,
      required this.name,
      required this.desc,
      required this.uid,
      required this.token});
}
