import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/provider/calendar_provider.dart';
import 'package:portfolio_calendar/views/main/android_main.dart';
import 'package:portfolio_calendar/views/main/ios_main.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../provider/user_provider.dart';
import '../auth/auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    CalendarProvider _calendarProvider = Provider.of<CalendarProvider>(context);
    UserProvider _userProvider = Provider.of<UserProvider>(context);

    if (_authProvider.authState == AuthState.loggedOut) return AuthPage();

    return Platform.isAndroid ? AndroidMain(calendarProvider: _calendarProvider, userProvider: _userProvider, authProvider: _authProvider,) : IosMain();
  }
}
