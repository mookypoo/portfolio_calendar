import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/views/add_event/android_add_event.dart';
import 'package:portfolio_calendar/views/add_event/ios_add_event.dart';
import 'package:provider/provider.dart';

import '../../provider/time_provider.dart';

class AddEventPage extends StatelessWidget {
  const AddEventPage({Key? key}) : super(key: key);
  static const String routeName = "/addEventPage";

  @override
  Widget build(BuildContext context) {
    TimeProvider _timeProvider = Provider.of<TimeProvider>(context);

    return Platform.isAndroid
        ? AndroidAddEvent(timeProvider: _timeProvider,)
        : IosAddEvent();
  }
}
