import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async => await Firebase.initializeApp();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Object?> signup({required String email, required String pw}) async {
    try {
      final UserCredential _userCredential = await this._auth.createUserWithEmailAndPassword(email: email, password: pw);
      return _userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") return "이미 가입한 이메일입니다.";
      if (e.code == "invalid-email") return "잘못된 이메일 주소입니다.";
      if (e.code == "weak-password") return "더 강화된 비밀번호를 사용하세요.";
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Object?> signIn({required String email, required String pw}) async {
    try {
      final UserCredential _userCredential = await this._auth.signInWithEmailAndPassword(email: email, password: pw);
      return _userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") return "아직 가입하지 않은 이메일입니다.";
      if (e.code == "invalid-email") return "잘못된 이메일 주소입니다.";
      if (e.code == "wrong-password") return "잘못된 비밀번호입니다.";
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> sendEmailVerification() async {
    final User? _user = this._auth.currentUser;
    if (_user != null && !_user.emailVerified) await _user.sendEmailVerification();
    return;
  }

  Future<void> signOut() async {
    try {
      await this._auth.signOut();
    } catch (e) {
      print(e);
    }
    return;
  }
}

