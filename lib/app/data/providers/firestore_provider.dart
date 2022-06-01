import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:get/get.dart';

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

  static Stream<List<ProductModel>> productStream(RxString uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid.value)
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProductModel> products = [];
      for (var product in query.docs) {
        final productModel =
            ProductModel.fromDocumentSnapshot(documentSnapshot: product);
        products.add(productModel);
      }
      return products;
    });
  }

  static deleteTodo(String documentId, String uid) {
    _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('products')
        .doc(documentId)
        .delete();
  }
}
