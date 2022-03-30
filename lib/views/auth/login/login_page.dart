import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/views/auth/login/android_login.dart';
import 'package:portfolio_calendar/views/auth/login/ios_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
      ? AndroidLogin()
      : IosLogin();
  }
}
