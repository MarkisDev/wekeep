import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/models/user_models.dart';

class FirestoreDb {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  //-------Product Related Functions-----------
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

  static Stream<List<ProductModel>> productStream(String uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
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

  //------------User Related Functions----------
  static addUser(UserModel userModel, String uid) async {
    await _firebaseFirestore.collection('users').doc(uid).add({
      'name': userModel.name,
      'email': userModel.email,
      'id': userModel.id,
      'photoUrl': userModel.photoUrl,
    });
  }
}
