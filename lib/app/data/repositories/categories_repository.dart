import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wekeep/app/data/models/category_model.dart';
import 'package:wekeep/app/data/models/product_model.dart';
import 'package:wekeep/app/data/providers/firestorage_provider.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';

class CategoriesRepository {
  addCategory(CategoryModel categoryModel, String uid) async {
    await FirestoreDb.addCategory(categoryModel, uid);
  }

  categoryStream(String uid) {
    var productSnapshots = FirestoreDb.categoryStream(uid);
    return productSnapshots.map((QuerySnapshot query) {
      List<CategoryModel> categories = [];
      for (var category in query.docs) {
        final productModel =
            CategoryModel.fromDocumentSnapshot(documentSnapshot: category);
        categories.add(productModel);
      }
      return categories;
    });
  }

  deleteCategory(String documentId, String uid) async {
    await FirestoreDb.deleteCategory(documentId, uid);
  }
}
