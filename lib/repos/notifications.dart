import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings androidInit = const AndroidInitializationSettings('todo_icon');
  final IOSInitializationSettings iosInit = const IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  Future<void> init() async {
    await notificationsPlugin.initialize(
      InitializationSettings(android: androidInit, iOS: iosInit,),
      onSelectNotification: this.selectNotification,
    );
  }

  void selectNotification(String? payload){

    if (payload != null) {
      print(payload);
    }
    print("select notification");
  }
}