import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_calendar/provider/auth_provider.dart';
import 'package:portfolio_calendar/provider/calendar_provider.dart';
import 'package:portfolio_calendar/provider/time_provider.dart';
import 'package:portfolio_calendar/provider/user_provider.dart';
import 'package:portfolio_calendar/repos/variables.dart';
import 'package:portfolio_calendar/service/firebase_service.dart';
import 'package:portfolio_calendar/views/add_event/add_event_page.dart';
import 'package:portfolio_calendar/views/auth/login/login_page.dart';
import 'package:portfolio_calendar/views/auth/main/auth_page.dart';
import 'package:portfolio_calendar/views/main/main_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown, DeviceOrientation.portraitUp,
  ]);
  runApp(PortfolioCalendar());
}

class PortfolioCalendar extends StatelessWidget {
  const PortfolioCalendar({Key? key}) : super(key: key);

  Widget _iosApp(){
    return CupertinoApp();
  }

  Widget _androidApp(){
    return MaterialApp(
      theme: ThemeData(
        splashFactory: InkRipple.splashFactory,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: MyColors.primary),
          bodyText2: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, ),
        ),
        iconTheme: IconThemeData(color: MyColors.primary),
        switchTheme: SwitchThemeData(),
      ),

      onGenerateRoute: (RouteSettings route) {
        if (route.name == AddEventPage.routeName) {
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => MultiProvider(
              providers: [
                ChangeNotifierProvider<TimeProvider>(
                  create: (BuildContext context) => TimeProvider(context.read<CalendarProvider>().selectedDate),
                ),
              ],
              child: AddEventPage(),
            ),
            settings: RouteSettings(name: AddEventPage.routeName),
          );
        }
        if (route.name == AuthPage.routeName) {
          return MaterialPageRoute(
            builder: (_) => LoginPage(),
            settings: RouteSettings(name: AuthPage.routeName),
          );
        }
      },
      home: MainPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<CalendarProvider>(create: (_) => CalendarProvider()),
        ChangeNotifierProxyProvider<CalendarProvider, UserProvider>(
          create: (BuildContext context) => UserProvider(Provider.of<CalendarProvider>(context, listen: false).selectedMonth),
          update: (_, CalendarProvider calendar, __) => UserProvider(calendar.selectedMonth),
        ),
      ],
      child: Platform.isAndroid ? this._androidApp() : this._iosApp(),
    );
  }
}

