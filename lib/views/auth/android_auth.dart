import 'package:flutter/material.dart';
import 'package:portfolio_calendar/models/auth_class.dart';
import 'package:portfolio_calendar/views/auth/android_components.dart';
import 'package:portfolio_calendar/views/auth/common_components.dart';

import '../../provider/auth_provider.dart';

class AndroidAuth extends StatefulWidget {
  const AndroidAuth({Key? key, required this.authProvider}) : super(key: key);
  final AuthProvider authProvider;

  @override
  State<AndroidAuth> createState() => _AndroidAuthState();
}

class _AndroidAuthState extends State<AndroidAuth> {
  TextEditingController _nameCt = TextEditingController();
  TextEditingController _emailCt = TextEditingController();
  TextEditingController _pw1Ct = TextEditingController();
  TextEditingController _pw2Ct = TextEditingController();

  FocusNode _nameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _pw1Focus = FocusNode();
  FocusNode _pw2Focus = FocusNode();

  @override
  void initState() {
    <TextEditingController>[this._nameCt, this._emailCt, this._pw1Ct, this._pw2Ct].forEach((TextEditingController ct) {
      ct.addListener(() {
        if (ct.text.trim().length == 1) this.setState(() {});
        if (ct.text.trim().isEmpty) this.setState(() {});
      });
    });
    <FocusNode>[this._nameFocus, this._emailFocus, this._pw1Focus, this._pw2Focus].forEach((FocusNode fn) {
      fn.addListener(() {
        if (!fn.hasPrimaryFocus) {
          if (fn == this._nameFocus) this.widget.authProvider.checkName(name: this._nameCt.text);
          if (fn == this._emailFocus) this.widget.authProvider.checkEmail(email: this._emailCt.text);
          if (fn == this._pw1Focus) this.widget.authProvider.checkPw(pw: this._pw1Ct.text.trim());
          if (fn == this._pw2Focus) this.widget.authProvider.confirmPw(pw: this._pw1Ct.text.trim(), pw2: this._pw2Ct.text.trim());
        } else {
          this.widget.authProvider.clearSubtexts();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    <TextEditingController>[this._nameCt, this._emailCt, this._pw1Ct, this._pw2Ct].forEach((TextEditingController ct) => ct.dispose());
    <FocusNode>[this._nameFocus, this._emailFocus, this._pw1Focus, this._pw2Focus].forEach((FocusNode fn) => fn.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: _size.height,
            width: _size.width,
            child: Stack(
              children: <Widget>[
                TopImage(),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Stack(
                    children: <Widget>[
                      BackgroundContainer(),
                      Positioned(
                        top: 10.0,
                        left: 0.0,
                        right: 0.0,
                        child: Icon(Icons.person, size: _size.width * 0.20,),
                      ),
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        top: 77.0,
                        child: this.widget.authProvider.isLoginPage
                          ? AndroidLoginWidget(
                              emailCt: this._emailCt,
                              pw1Ct: this._pw1Ct,
                              pw1Focus: this._pw1Focus,
                              emailFocus: this._emailFocus,
                              authProvider: this.widget.authProvider,
                            )
                          : AndroidSignUpWidget(
                              emailFocus: this._emailFocus,
                              nameFocus: this._nameFocus,
                              pw1Focus: this._pw1Focus,
                              pw2Focus: this._pw2Focus,
                              authProvider: this.widget.authProvider,
                              emailCt: this._emailCt,
                              nameCt: this._nameCt,
                              pw1Ct: this._pw1Ct,
                              pw2Ct: this._pw2Ct,
                            ),
                      ),
                      this.widget.authProvider.isLoginPage
                        ? LogInBottom(
                            onTapLogin: () async {
                              final bool _hasErrors = this.widget.authProvider.validate(email: this._emailCt.text.trim(), pw: this._pw1Ct.text.trim());
                              if (_hasErrors) return;
                              await this.widget.authProvider.firebaseSignIn(
                                data: LoginInfo(
                                  email: this._emailCt.text.trim(),
                                  pw: this._pw1Ct.text.trim(),
                                ),);
                            },
                            switchPage: () {
                              this.widget.authProvider.switchPage();
                              <TextEditingController>[this._nameCt, this._emailCt, this._pw1Ct, this._pw2Ct].forEach(
                                      (TextEditingController ct) => ct.clear());
                            },
                          )
                        : SignUpBottom(
                            switchPage: () {
                              this.widget.authProvider.switchPage();
                              <TextEditingController>[this._nameCt, this._emailCt, this._pw1Ct, this._pw2Ct].forEach(
                                      (TextEditingController ct) => ct.clear());
                            },
                            onTapSignUp: () async {
                              final bool _hasErrors = this.widget.authProvider.validate(
                                email: this._emailCt.text.trim(), pw: this._pw1Ct.text.trim(), name: this._nameCt.text, pw2: this._pw2Ct.text.trim(),
                              );
                              //if (_hasErrors) return;
                              await this.widget.authProvider.firebaseSignUp(
                                data: SignUpInfo(
                                  name: this._nameCt.text.trim(),
                                  isMale: this.widget.authProvider.isMale,
                                  email: this._emailCt.text.trim(),
                                  pw: this._pw1Ct.text.trim(),
                                ),
                              );
                            }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
