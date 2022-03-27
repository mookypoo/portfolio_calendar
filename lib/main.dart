import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_calendar/provider/calendar_provider.dart';
import 'package:portfolio_calendar/provider/time_provider.dart';
import 'package:portfolio_calendar/repos/variables.dart';
import 'package:portfolio_calendar/views/add_event/add_event_page.dart';
import 'package:portfolio_calendar/views/main/main_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(PortfolioCalendar());

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
          return MaterialPageRoute(
            builder: (BuildContext context) => ChangeNotifierProvider<TimeProvider>(
              create: (_) => TimeProvider(context.read<CalendarProvider>().selectedDate),
              child: AddEventPage(),
            ),
            settings: RouteSettings(name: AddEventPage.routeName),
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
        ChangeNotifierProvider<CalendarProvider>(create: (_) => CalendarProvider()),
      ],
      child: Platform.isAndroid ? this._androidApp() : this._iosApp(),
    );
  }
}

