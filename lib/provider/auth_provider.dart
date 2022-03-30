import 'package:flutter/foundation.dart';
import 'package:portfolio_calendar/service/firebase_service.dart';

enum AuthState {
  loggedIn, loggedOut, await, error
}

class AuthProvider with ChangeNotifier {
  FirebaseService _firebaseService = FirebaseService();

  AuthProvider(){
    print("auth provider init");
  }

  AuthState _authState = AuthState.loggedOut;
  AuthState get authState => this._authState;
  set authState(AuthState a) => throw "error";

  bool isLoginPage = false;

  void firebaseLogin({required String email, required String pw}){
    this._firebaseService.signup(email: email, pw: pw);
  }
}