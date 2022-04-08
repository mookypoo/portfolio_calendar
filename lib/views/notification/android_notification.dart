import 'package:flutter/material.dart';

import '../../provider/notification_provider.dart';
import '../../provider/time_provider.dart';

class AndroidNotification extends StatelessWidget {
  const AndroidNotification({Key? key, required this.notificationProvider, required this.timeProvider}) : super(key: key);
  final NotificationProvider notificationProvider;
  final TimeProvider timeProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(this.timeProvider.startTime),
      ),
    );
  }
}
