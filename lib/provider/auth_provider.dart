import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio_calendar/service/firebase_service.dart';

import '../models/auth_class.dart';
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

  AuthState _authState = AuthState.await;
  AuthState get authState => this._authState;
  set authState(AuthState a) => throw "error";

  bool _pw1obscure = true;
  bool get pw1obscure => this._pw1obscure;
  set pw1obscure(bool b) => throw "error";

  bool _pw2obscure = true;
  bool get pw2obscure => this._pw2obscure;
  set pw2obscure(bool b) => throw "error";

  bool _isTosChecked = true;
  bool get isTosChecked => this._isTosChecked;
  set isTosChecked(bool b) => throw "error";

  bool _isLoginPage = false;
  bool get isLoginPage => this._isLoginPage;
  set isLoginPage(bool b) => throw "error";

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

  void switchPage(){
    this._isLoginPage = !this._isLoginPage;
    this.clearSubtexts();
    this.notifyListeners();
    return;
  }

  void clearSubtexts(){
    this._pw2ErrorText = null;
    this._emailErrorText = null;
    this._nameErrorText = null;
    this._isMale = true;
    this._pwErrorText = null;
    this.notifyListeners();
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
    if (!this._isLoginPage) this._pwErrorText = this._authService.checkPw(pw: pw);
    if (this._isLoginPage && pw == "") this._pwErrorText = "비밀번호를 입력해주세요.";
    this.notifyListeners();
    return;
  }

  void confirmPw({required String pw, required String pw2}){
    this._pw2ErrorText = this._authService.confirmPw(pw: pw, pw2: pw2);
    this.notifyListeners();
    return;
  }

  void checkTos(){
    this._isTosChecked = !this._isTosChecked;
    this.notifyListeners();
    return;
  }

  bool _hasErrors(){
    if ([this._nameErrorText, this._emailErrorText, this._pwErrorText, this._pw2ErrorText].any((String? s) => s != null)) return true;
    return false;
  }

  Future<void> firebaseSignUp({required SignUpInfo data}) async {
    //if (this._hasErrors()) return;
    final SignUpInfo data = SignUpInfo(email: "sookim482@gmail.com", name: "Soo Kim", pw: "calendar123", isMale: false);
    final _res1 = await this._firebaseService.signup(email: data.email, pw: data.pw);
    if (_res1.runtimeType == String) {
      _res1 as String;
      if (_res1.contains("이메일")) this._emailErrorText = _res1;
      if (_res1.contains("비밀번호")) this._pwErrorText = _res1;
    }
    if (_res1.runtimeType == UserCredential) {
      await this.firebaseSignIn(data: data);
      await this._firebaseService.sendAuthInfo(user: _res1 as UserCredential, name: data.name, isMale: data.isMale);
    }
    this.notifyListeners();
    return;
  }

  Future<void> firebaseSignIn({required AuthAbstract data}) async {
    final _res = await this._firebaseService.signIn(email: data.email, pw: data.pw);
    print(_res);
    if (_res.runtimeType == String) {
      _res as String;
      if (_res.contains("비밀번호")) this._pwErrorText = _res;
      if (_res.contains("가입")) this._emailErrorText = _res;
    }
    if (_res.runtimeType == UserCredential) {
      final User? _user = (_res as UserCredential).user;
      if (_user != null) {
        if (!_user.emailVerified) await this._firebaseService.sendEmailVerification();
        this._authState = AuthState.loggedIn;
        this.clearSubtexts();
      }
    }
    this.notifyListeners();
    return null;
  }

  Future<void> firebaseSignOut() async {
    await this._firebaseService.signOut();
    this._authState = AuthState.loggedOut;
    this.notifyListeners();
    return;
  }

  bool validate({String? name, required String email, required String pw, String? pw2}){
    this.checkEmail(email: email);
    this.checkPw(pw: pw);
    if (name != null) this.checkName(name: name);
    if (pw2 != null) this.confirmPw(pw: pw, pw2: pw2);
    if (this._hasErrors()) return true;
    return false;
  }
}