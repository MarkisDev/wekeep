import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wekeep/app/core/values/constants.dart';
import 'package:wekeep/app/data/models/user_models.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth _auth = auth;
  final GoogleSignIn _googleSignIn = googleSignIn;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  // Logins user using GoogleSignIn
  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);
      // Firebase Auth User
      // final User? user = authResult.user;
      UserModel userModel = UserModel(
          name: googleSignInAccount!.displayName.toString(),
          email: googleSignInAccount.email,
          id: googleSignInAccount.id,
          photoUrl: googleSignInAccount.photoUrl.toString());
      await FirestoreDb.addUser(userModel, _auth.currentUser!.uid);
      await Get.toNamed('/home', arguments: _auth.currentUser!);
      return;
    } catch (e) {
      throw (e);
    }
  }

  /// Logs user out
  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.back();
  }
}
