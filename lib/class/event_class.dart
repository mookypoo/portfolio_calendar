import 'dart:ui';

import 'package:portfolio_calendar/class/time_model.dart' show Time;
import 'package:uuid/uuid.dart';


import 'day_class.dart' show DayData;

class Event {
  final String uid = Uuid().v1(); // done at server
  final String title;
  final DayData day;
  final bool setTime;
  final Time startTime;
  final Time endTime;
  final Color color;
  final String? notes;

  Event({required this.setTime, required this.title, required this.day, required this.startTime, required this.endTime, this.notes, required this.color});

  Map<String, dynamic> toJsonAll(){
    return {
      "setTime": this.setTime,
      "eventUid": this.uid,
      "title": this.title,
      "day": this.day.toJson(),
      "startTime": this.startTime.toJson(),
      "endTime": this.endTime.toJson(),
      "color": this.color.value,
      "notes": this.notes,
    };
  }

  Map<String, String> toJsonUid(){
    return {"eventUid": this.uid};
  }
}


