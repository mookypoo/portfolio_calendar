import 'package:flutter/widgets.dart';

import '../models/day_class.dart' show Day;
import '../models/time_model.dart' show Time;

class TimeProvider with ChangeNotifier {
  Day date;
  String get dateText => this.date.textInfo();

  Time startTimeModel = Time()..hour += 1;
  Time endTimeModel = Time()..hour += 2;

  String get startTime => this.startTimeModel.time;
  String get endTime => this.endTimeModel.time;

  TimeProvider(this.date){
    print("time provider init");
  }

}