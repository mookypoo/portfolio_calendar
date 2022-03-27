import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/provider/calendar_provider.dart';
import 'package:portfolio_calendar/views/main/android_main.dart';
import 'package:portfolio_calendar/views/main/ios_main.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CalendarProvider _calendarProvider = Provider.of(context);

    return Platform.isAndroid ? AndroidMain(calendarProvider: _calendarProvider,) : IosMain();
  }
}
