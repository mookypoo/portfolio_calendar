import 'dart:ui';

import 'package:portfolio_calendar/models/time_model.dart' show Time;
import 'package:portfolio_calendar/repos/variables.dart';

import 'day_class.dart' show DayData;


class EventTime {
  final DayData day;
  final Time time;

  EventTime({required this.day, required this.time});
}

class Event {
  final String title;
  final EventTime startTime;
  final EventTime endTime;

  final Color color;

  final String? notes;

  Event({required this.endTime, required this.startTime, this.color = EventColors.orange, this.notes, required this.title});
}


