import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wekeep/app/data/models/product_model.dart';

class FirestoreDb {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static addProduct(ProductModel productModel, String uid) async {
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('products')
        .add({
      'name': productModel.name,
      'category': productModel.category,
      'warrantyMonths': productModel.warrantyMonths,
      'notes': productModel.notes,
    });
  }
}
