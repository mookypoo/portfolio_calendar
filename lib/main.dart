import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_calendar/calendar_provider.dart';
import 'package:portfolio_calendar/views/main/main_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(PortfolioCalendar());

class PortfolioCalendar extends StatelessWidget {
  const PortfolioCalendar({Key? key}) : super(key: key);

  Widget _androidApp(){
    return MaterialApp(
      home: MainPage(),
    );
  }

  Widget _iosApp(){
    return CupertinoApp();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
      ],
      child: Platform.isAndroid ? this._androidApp() : this._iosApp(),
    );
  }
}

