import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/views/add_event/android_add_event.dart';
import 'package:portfolio_calendar/views/add_event/ios_add_event.dart';
import 'package:provider/provider.dart';

import '../../provider/add_event_provider.dart';
import '../../provider/time_provider.dart';
import '../../provider/user_provider.dart';

class AddEventPage extends StatelessWidget {
  const AddEventPage({Key? key}) : super(key: key);
  static const String routeName = "/addEventPage";

  @override
  Widget build(BuildContext context) {
    TimeProvider _timeProvider = Provider.of<TimeProvider>(context);
    UserProvider _userProvider = Provider.of<UserProvider>(context, listen: false);
    AddEventProvider _addEventProvider = Provider.of<AddEventProvider>(context);

    return Platform.isAndroid
        ? AndroidAddEvent(timeProvider: _timeProvider, userProvider: _userProvider, addEventProvider: _addEventProvider,)
        : IosAddEvent();
  }
}
