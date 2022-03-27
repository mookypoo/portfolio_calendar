import 'dart:ui';

import 'package:portfolio_calendar/models/time_model.dart' show Time;
import 'package:portfolio_calendar/repos/variables.dart';

class Event {
  Time startTime;
  Time endTime;

  Color color;

  String? notes;

  Event({required this.endTime, required this.startTime, this.color = EventColors.orange, this.notes});
}



