import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:wekeep/app/data/models/category_model.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/models/request_model.dart';
import 'package:wekeep/app/data/models/serviceProvider_model.dart';
import 'package:wekeep/app/data/models/user_models.dart';

import 'dart:async';

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
      'categoryId': productModel.categoryId,
      'categoryName': productModel.categoryName,
      'warrantyDate': productModel.warrantyDate,
      'purchaseDate': productModel.purchaseDate,
      'warrantyMonths': productModel.warrantyMonths,
      'notes': productModel.notes,
      'receiptUrl': productModel.receiptUrl,
      'productUrl': productModel.productUrl,
    });

    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .doc(productModel.categoryId)
        .update({
      'count': FieldValue.increment(1),
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> productStream(String uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('products')
        .snapshots();
  }

  static deleteProduct(ProductModel product, String uid) async {
    _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('products')
        .doc(product.productId.toString())
        .delete();

    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .doc(product.categoryId)
        .update({
      'count': FieldValue.increment(-1),
    });
  }

  //------------User Related Functions----------
  static addUser(UserModel userModel, String uid) async {
    await _firebaseFirestore.collection('users').doc(uid).set({
      'name': userModel.name,
      'email': userModel.email,
      'id': userModel.id,
      'photoUrl': userModel.photoUrl,
      'token': userModel.token
    });
  }

//--------------Category Related Functions
  static Stream<QuerySnapshot<Map<String, dynamic>>> categoryStream(
      String uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .snapshots();
  }

  static addCategory(CategoryModel categoryModel, String uid) async {
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .add({
      'name': categoryModel.name,
      'color': categoryModel.color,
      'count': 0,
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

// ------------ SERVICES --------------

  static Stream<List<DocumentSnapshot<Object?>>> getShops(GeoFirePoint center) {
    final geo = GeoFlutterFire();
    var collectionReference = _firebaseFirestore.collection('shops');
    double radius = 50;
    String field = 'location';
    List<ServiceProvider> shops = [];

    var stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);
    return stream;
  }

  static addRequest(RequestModel requestModel, String uid) async {
    await _firebaseFirestore
        .collection('shops')
        .doc(uid)
        .collection('requests')
        .add({
      'name': requestModel.name,
      'desc': requestModel.desc,
      'img': requestModel.img,
      'token': requestModel.token,
      'uid': requestModel.uid,
      'userName': requestModel.userName,
      'userPhotoUrl': requestModel.userPhotoUrl
    });
  }
}
