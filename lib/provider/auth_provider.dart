import 'package:firebase_auth/firebase_auth.dart' show UserCredential, User;
import 'package:flutter/foundation.dart';
import 'package:portfolio_calendar/service/firebase_service.dart';

import '../class/auth_class.dart';
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

  String? _userUid;
  String? get userUid => this._userUid;
  set userUid(String? s) => throw "error";

  AuthState _authState = AuthState.loggedIn;
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
  }

  void clearSubtexts(){
    this._pw2ErrorText = null;
    this._emailErrorText = null;
    this._nameErrorText = null;
    this._isMale = true;
    this._pwErrorText = null;
    this.notifyListeners();
  }

  void selectGender(bool isMale){
    this._isMale = isMale;
    this.notifyListeners();
  }

  void onTapRedEye(bool isPw1){
    if (isPw1) this._pw1obscure = !this._pw1obscure;
    if (!isPw1) this._pw2obscure = !this._pw2obscure;
    this.notifyListeners();
  }

  void checkName({required String name}){
    this._nameErrorText = this._authService.checkName(name: name);
    this.notifyListeners();
  }

  void checkEmail({required String email}){
    this._emailErrorText = this._authService.checkEmail(email: email);
    this.notifyListeners();
  }

  void checkPw({required String pw}){
    if (!this._isLoginPage) this._pwErrorText = this._authService.checkPw(pw: pw);
    if (this._isLoginPage && pw == "") this._pwErrorText = "비밀번호를 입력해주세요.";
    this.notifyListeners();
  }

  void confirmPw({required String pw, required String pw2}){
    this._pw2ErrorText = this._authService.confirmPw(pw: pw, pw2: pw2);
    this.notifyListeners();
  }

  void checkTos(){
    this._isTosChecked = !this._isTosChecked;
    this.notifyListeners();
  }

  bool _hasErrors(){
    if ([this._nameErrorText, this._emailErrorText, this._pwErrorText, this._pw2ErrorText].any((String? s) => s != null)) return true;
    return false;
  }

  // todo exception handling when can't save auth info to server
  Future<bool> firebaseSignUp({required SignUpInfo data}) async {
    //if (this._hasErrors()) return false;
    final SignUpInfo data = SignUpInfo(email: "sookim482@gmail.com", name: "Soo Kim", pw: "calendar123", isMale: false);
    bool _success = false;
    final _res1 = await this._firebaseService.signup(email: data.email, pw: data.pw);
    if (_res1.runtimeType == String) {
      _res1 as String;
      if (_res1.contains("이메일")) this._emailErrorText = _res1;
      if (_res1.contains("비밀번호")) this._pwErrorText = _res1;
    }
    if (_res1.runtimeType == UserCredential) {
      _res1 as UserCredential;
      final String? _res2 = await this._firebaseService.sendAuthInfo(user: _res1, name: data.name, isMale: data.isMale);
      if (_res2 == _res1.user?.uid) {
        await this.firebaseSignIn(data: data);
        _success = true;
      }
    }
    this.notifyListeners();
    return _success;
  }

  Future<void> firebaseSignIn({required AuthAbstract data}) async {
    final _res = await this._firebaseService.signIn(email: data.email, pw: data.pw);
    if (_res.runtimeType == String) {
      _res as String;
      if (_res.contains("비밀번호")) this._pwErrorText = _res;
      if (_res.contains("가입")) this._emailErrorText = _res;
      if (_res.contains("가능한")) this._pwErrorText = _res;
    }
    if (_res.runtimeType == UserCredential) {
      print(_res);
      final User? _user = (_res as UserCredential).user;
      if (_user != null) {
        if (!_user.emailVerified) await this._firebaseService.sendEmailVerification();
        this._userUid = _user.uid;
        this.clearSubtexts();
        await this._authService.logAuth(userUid: _user.uid, isLogin: true);
        this._authState = AuthState.loggedIn;
      }
    }
    this.notifyListeners();
    return null;
  }

  Future<void> firebaseSignOut({required String? userUid}) async {
    assert(userUid != null, "userUid is null");
    await this._firebaseService.signOut();
    this._authState = AuthState.loggedOut;
    await this._authService.logAuth(userUid: userUid!, isLogin: false);
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