import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? productId;
  String? notes;
  String? receiptUrl;
  String? productUrl;

  late String name;
  late String categoryId;
  late String categoryName;
  late int warrantyMonths;
  late String purchaseDate;
  late String warrantyDate;
  ProductModel(
      {required this.name,
      required this.categoryName,
      required this.categoryId,
      required this.purchaseDate,
      required this.warrantyDate,
      required this.warrantyMonths,
      this.receiptUrl,
      this.productUrl,
      this.notes});

  /// Constructor to init variables from Firebase
  ProductModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    productId = documentSnapshot.id;
    name = documentSnapshot['name'];
    categoryId = documentSnapshot['categoryId'];
    categoryName = documentSnapshot['categoryName'];
    warrantyMonths = documentSnapshot['warrantyMonths'];
    warrantyDate = documentSnapshot['warrantyDate'];
    purchaseDate = documentSnapshot['purchaseDate'];
    notes = documentSnapshot['notes'];
    receiptUrl = documentSnapshot['receiptUrl'];
    productUrl = documentSnapshot['productUrl'];
  }
}
