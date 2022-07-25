import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wekeep/app/data/models/category_model.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/models/serviceProvider_model.dart';
import 'package:wekeep/app/data/models/user_models.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
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
      'warrantyMonths': productModel.warrantyMonths,
      'notes': productModel.notes,
      'receiptUrl': productModel.receiptUrl,
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

  static Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getShops(
      GeoFirePoint center) {
    final geo = Geoflutterfire();
    var collectionReference = _firebaseFirestore.collection('shops');
    double radius = 50;
    String field = 'location';
    List<ServiceProvider> shops = [];

    var stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);
    // stream.listen((List<DocumentSnapshot> documentList) {
    //   print("ok ${documentList}");
    //   documentList.forEach((DocumentSnapshot document) {
    //     var loc = document['location']['geopoint'];
    //     GeoFirePoint pos =
    //         geo.point(latitude: loc.latitude, longitude: loc.longitude);
    //     double k = pos.kmDistance(lat: center.latitude, lng: center.longitude);
    //     ServiceProvider prov = ServiceProvider(
    //         name: document['shopName'],
    //         howFar: k,
    //         imgUrl:
    //             'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
    //     shops.add(prov);
    //     print(shops);
    //   });
    // });
    return stream;
  }
}
