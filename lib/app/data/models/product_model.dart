import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? productId;
  String? notes;
  late String name;
  late String category;
  late int warrantyMonths;

  ProductModel(
      {required this.name,
      required this.category,
      required this.warrantyMonths,
      this.notes});

  /// Constructor to init variables from Firebase
  ProductModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    productId = documentSnapshot.id;
    name = documentSnapshot['name'];
    category = documentSnapshot['category'];
    warrantyMonths = documentSnapshot['warrantyMonths'];
    notes = documentSnapshot['notes'];
  }
}
