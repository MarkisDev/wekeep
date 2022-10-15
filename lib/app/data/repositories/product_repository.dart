import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/providers/firestorage_provider.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';

class ProductRepository {
  addProduct(ProductModel productModel, String uid) async {
    await FirestoreDb.addProduct(productModel, uid);
  }

  productStream(String uid) {
    var productSnapshots = FirestoreDb.productStream(uid);
    return productSnapshots.map((QuerySnapshot query) {
      List<ProductModel> products = [];
      for (var product in query.docs) {
        final productModel =
            ProductModel.fromDocumentSnapshot(documentSnapshot: product);
        products.add(productModel);
      }
      return products;
    });
  }

  deleteProduct(ProductModel product, String uid) async {
    await FirestoreDb.deleteProduct(product, uid);
  }
}
