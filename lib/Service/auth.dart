import 'package:firebase_auth/firebase_auth.dart';
import '../Provider/error_provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return result.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ErrorProvider.message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        ErrorProvider.message = "Wrong password provided for that user";
      } else {
        ErrorProvider.message = "Something went wrong , please try again";
      }
      return null;
    } catch (e) {
      ErrorProvider.message = "$e";
      return null;
    }
  }

  Future<String?> signOut() async {
    await _auth.signOut().catchError((error, stackrace) {
      ErrorProvider.message = "Logout failed";
      return null;
    });
    return _auth.currentUser?.uid;
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final cred = EmailAuthProvider.credential(
          email: user?.email ?? "", password: currentPassword);
      await user?.reauthenticateWithCredential(cred);
      await user?.updatePassword(newPassword).then((value) {
        AuthService().signOut();
      });
    } on FirebaseException catch (e) {
      ErrorProvider.message = e.code;
    } catch (e) {
      ErrorProvider.message = "Something went wrong , please try again";
    }
  }
}
