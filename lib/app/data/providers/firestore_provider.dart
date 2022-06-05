import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wekeep/app/data/models/category_model.dart';
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
      'receiptUrl': productModel.receiptUrl,
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

  static deleteProduct(String documentId, String uid) {
    _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('products')
        .doc(documentId)
        .delete();
  }

  //------------User Related Functions----------
  static addUser(UserModel userModel, String uid) async {
    await _firebaseFirestore.collection('users').doc(uid).set({
      'name': userModel.name,
      'email': userModel.email,
      'id': userModel.id,
      'photoUrl': userModel.photoUrl,
    });
  }

//--------------Category Related Functions
  static Stream<List<CategoryModel>> categoryStream(String uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .snapshots()
        .map((QuerySnapshot query) {
      List<CategoryModel> products = [];
      for (var product in query.docs) {
        final productModel =
            CategoryModel.fromDocumentSnapshot(documentSnapshot: product);
        products.add(productModel);
      }
      return products;
    });
  }

  static addCategory(CategoryModel categoryModel, String uid) async {
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .add({
      'name': categoryModel.name,
      'color': categoryModel.color,
    });
  }

  static deleteCategory(String documentId, String uid) {
    _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .doc(documentId)
        .delete();
  }
}
