import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  late String color;
  String? categoryId;
  String? name;

  CategoryModel(this.color, this.name);

  /// Constructor to init variables from Firebase
  CategoryModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    color = documentSnapshot['color'];
    name = documentSnapshot['name'];
    categoryId = documentSnapshot.id;
  }
}
