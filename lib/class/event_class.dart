import 'dart:ui';

import 'package:portfolio_calendar/class/time_model.dart' show Time;
import 'package:uuid/uuid.dart';


import 'day_class.dart' show DayData;

class Event {
  final String uid = Uuid().v1();
  final String title;
  final DayData day;
  final Time startTime;
  final Time endTime;
  final Color color;
  final String? notes;

  Event({required this.title, required this.day, required this.startTime, required this.endTime, this.notes, required this.color});

  Map<String, dynamic> toJsonAll(){
    return {
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


