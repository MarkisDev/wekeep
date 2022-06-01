import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name;
  late String email;
  late String id;
  late String photoUrl;

  UserModel(
      {required this.name,
      required this.email,
      required this.id,
      required this.photoUrl});
}
