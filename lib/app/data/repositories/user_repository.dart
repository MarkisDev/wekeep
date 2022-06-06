import 'package:wekeep/app/data/models/user_models.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';

class UserRepository {
  addUser(UserModel userModel, String uid) async {
    await FirestoreDb.addUser(userModel, uid);
  }
}
