import 'package:flutter/material.dart';

import '../../provider/notification_provider.dart';
import '../../provider/time_provider.dart';

class AndroidNotification extends StatelessWidget {
  const AndroidNotification({Key? key, required this.notificationProvider, required this.timeProvider}) : super(key: key);
  final NotificationProvider notificationProvider;
  final TimeProvider timeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Material(
        child: Text(this.timeProvider.startTime),
      ),
    );
  }
}
