import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/views/notification/android_notification.dart';
import 'package:portfolio_calendar/views/notification/ios_notification.dart';
import 'package:provider/provider.dart';

import '../../provider/notification_provider.dart';
import '../../provider/time_provider.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);
  static const String routeName = "/notificationPage";

  @override
  Widget build(BuildContext context) {
    NotificationProvider _notificationProvider = Provider.of<NotificationProvider>(context);
    TimeProvider _timeProvider = Provider.of<TimeProvider>(context);

    return Platform.isAndroid
      ? AndroidNotification(notificationProvider: _notificationProvider, timeProvider: _timeProvider,)
      : IosNotification();
  }
}
