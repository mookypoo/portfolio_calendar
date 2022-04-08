import 'package:flutter/foundation.dart';

import '../class/day_class.dart' show DayData;
import '../class/time_model.dart';

class NotificationProvider with ChangeNotifier{
  NotificationProvider(this.day, this.time){
    print("notification provider init");
  }

  DayData day;
  Time time;
}