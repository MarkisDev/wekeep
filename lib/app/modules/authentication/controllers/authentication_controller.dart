import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wekeep/app/data/models/user_models.dart';
import 'package:wekeep/app/data/providers/firestore_provider.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
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
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await auth.signInWithCredential(credential);
      final token = await firebaseMessaging.getToken();
      // Firebase Auth User
      // final User? user = authResult.user;

      UserModel userModel = UserModel(
          name: googleSignInAccount!.displayName.toString(),
          email: googleSignInAccount.email,
          id: googleSignInAccount.id,
          photoUrl: googleSignInAccount.photoUrl.toString(),
          token: token.toString());
      await FirestoreDb.addUser(userModel, auth.currentUser!.uid);
      await Get.offNamed('/home', arguments: userModel);
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
