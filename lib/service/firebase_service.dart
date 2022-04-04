import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio_calendar/repos/connect.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async => await Firebase.initializeApp();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Connect _connect = Connect();

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

  Future<void> sendAuthInfo({required UserCredential user, required String name, required bool isMale}) async {
    try {
      assert(user.user != null, "user is null!");
      final Map<String, dynamic> _body = {
        "email": user.user?.email,
        "signUpDate": user.user?.metadata.creationTime.toString(),
        "userUid": user.user?.uid,
        "name": name,
        "isMale": isMale,
        "method": "firebase",
      };
      final Map<String, dynamic> _res = await this._connect.reqPostServer(path: "/users/signUp", cb: (ReqModel rm) {}, body: _body);
      if (_res["userUid"] == user.user?.uid) return;
      throw "couldn't save auth data";
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
      if (e.code == "too-many-reqests") return "가능한 로그인 시도 횟수를 초과했습니다.";
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

  Future<void> logAuth({required String userUid, required bool isLogin}) async {
    try {
      final Map<String, dynamic> _body = {
        "userUid": userUid,
        "loginTime": isLogin ? DateTime.now().toString() : null,
        "logoutTime": !isLogin ? DateTime.now().toString() : null,
      };
      print(_body);
      var _res = await this._connect.reqPostServer(path: "users/log", cb: (ReqModel rm) {}, body: _body);
      print("logAuth");
      print(_res);
    } catch (e) {
      print(e);
    }
  }
}

