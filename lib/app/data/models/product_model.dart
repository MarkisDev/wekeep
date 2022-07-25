import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? productId;
  String? notes;
  String? receiptUrl;
  late String name;
  late String categoryId;
  late String categoryName;
  late int warrantyMonths;

  ProductModel(
      {required this.name,
      required this.categoryName,
      required this.categoryId,
      required this.warrantyMonths,
      this.receiptUrl,
      this.notes});

  /// Constructor to init variables from Firebase
  ProductModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    productId = documentSnapshot.id;
    name = documentSnapshot['name'];
    categoryId = documentSnapshot['categoryId'];
    categoryName = documentSnapshot['categoryName'];
    warrantyMonths = documentSnapshot['warrantyMonths'];
    notes = documentSnapshot['notes'];
    receiptUrl = documentSnapshot['receiptUrl'];
  }
}
