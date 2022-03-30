import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async => await Firebase.initializeApp();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signup({required String email, required String pw}) async {
    try {
      final UserCredential _userCredential = await this._auth.createUserWithEmailAndPassword(email: email, password: pw);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
  }
}

