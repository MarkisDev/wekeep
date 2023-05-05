import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String img;
  String desc;
  String name;
  String uid;
  String token;
  String userName;
  String userPhotoUrl;

  RequestModel(
      {required this.img,
      required this.name,
      required this.desc,
      required this.uid,
      required this.token,
      required this.userName,
      required this.userPhotoUrl});
}
