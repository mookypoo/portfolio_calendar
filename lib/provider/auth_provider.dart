import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio_calendar/service/firebase_service.dart';

import '../models/auth_class.dart' show SignUpInfo;
import '../service/auth_service.dart';

enum AuthState {
  loggedIn, loggedOut, await, error
}

class AuthProvider with ChangeNotifier {
  FirebaseService _firebaseService = FirebaseService();
  AuthService _authService = AuthService();

  AuthProvider(){
    print("auth provider init");
  }

  AuthState _authState = AuthState.loggedOut;
  AuthState get authState => this._authState;
  set authState(AuthState a) => throw "error";

  bool _pw1obscure = true;
  bool get pw1obscure => this._pw1obscure;
  set pw1obscure(bool b) => throw "error";

  bool _pw2obscure = true;
  bool get pw2obscure => this._pw2obscure;
  set pw2obscure(bool b) => throw "error";

  bool isLoginPage = false;

  String? _nameErrorText;
  String? get nameErrorText => this._nameErrorText;
  set nameErrorText(String? s) => throw "error";

  String? _emailErrorText;
  String? get emailErrorText => this._emailErrorText;
  set emailErrorText(String? s) => throw "error";

  bool _isMale = true;
  bool get isMale => this._isMale;
  set isMale(bool b) => throw "error";

  String? _pwErrorText;
  String? get pwErrorText => this._pwErrorText;
  set pwErrorText(String? s) => throw "error";

  String? _pw2ErrorText;
  String? get pw2ErrorText => this._pw2ErrorText;
  set pw2ErrorText(String? s) => throw "error";

  void clearSubtexts(){
    <String?>[this._pwErrorText, this._pw2ErrorText, this._emailErrorText, this._nameErrorText].forEach((String? s) => s = null);
    this._isMale = true;
    return;
  }

  void selectGender(bool isMale){
    this._isMale = isMale;
    this.notifyListeners();
    return;
  }

  void onTapRedEye(bool isPw1){
    if (isPw1) {
      this._pw1obscure = !this._pw1obscure;
    } else {
      this._pw2obscure = !this._pw2obscure;
    }
    this.notifyListeners();
    return;
  }

  void checkName({required String name}){
    this._nameErrorText = this._authService.checkName(name: name);
    this.notifyListeners();
    return;
  }

  void checkEmail({required String email}){
    this._emailErrorText = this._authService.checkEmail(email: email);
    this.notifyListeners();
    return;
  }

  void checkPw({required String pw}){
    this._pwErrorText = this._authService.checkPw(pw: pw);
    this.notifyListeners();
    return;
  }

  void confirmPw({required String pw, required String pw2}){
    this._pw2ErrorText = this._authService.confirmPw(pw: pw, pw2: pw2);
    this.notifyListeners();
    return;
  }

  bool hasErrors(){
    if ([this._nameErrorText, this._emailErrorText, this._pwErrorText, this._pw2ErrorText].any((String? s) => s != null)) return true;
    return false;
  }

  Future<String?> firebaseSignUp({required SignUpInfo data}) async {
    if (this.hasErrors()) return null;
    final _res1 = await this._firebaseService.signup(email: data.email, pw: data.pw);
    if (_res1.runtimeType == String) return _res1 as String;
    if (_res1.runtimeType == UserCredential) {
      final _res2 = await await this.firebaseSignIn(data: data);
      if (_res2.runtimeType == String) return _res2 as String;
    }
    return null;
  }

  Future<String?> firebaseSignIn({required SignUpInfo data}) async {
    final _res = await this._firebaseService.signIn(email: data.email, pw: data.pw);
    if (_res.runtimeType == String) return _res as String;
    if (_res.runtimeType == UserCredential) {
      final User? _user = (_res as UserCredential).user;
      if (_user != null && !_user.emailVerified) this._firebaseService.sendEmailVerification();
    }
    this._authState = AuthState.loggedIn;
    this.notifyListeners();
    return null;
  }

  Future<void> firebaseSignOut() async {
    await this._firebaseService.signOut();
    this._authState = AuthState.loggedOut;
    this.notifyListeners();
    return;
  }
}