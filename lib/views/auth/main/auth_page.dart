import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/views/auth/main/android_auth.dart';
import 'package:portfolio_calendar/views/auth/main/ios_auth.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);
  static const String routeName = "/authPage";

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of(context, listen: false);

    return Platform.isAndroid
      ? AndroidAuth(authProvider: _authProvider,)
      : IosAuth();
  }
}
