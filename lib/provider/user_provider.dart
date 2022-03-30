import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../models/day_class.dart' show Day;
import '../models/event_model.dart';
import '../models/selected_month.dart';
import '../models/time_model.dart' show Period, Time;
import '../repos/variables.dart' show EventColors;

class UserProvider with ChangeNotifier {
  SelectedMonth selectedMonth;

  UserProvider(this.selectedMonth){
    print("user provider init");
    this._thisMonthEvents = this._fetchThisMonthEvents(selectedMonth: this.selectedMonth);
  }

  List<Event> _userEvents = [
    Event(
      color: EventColors.yellow,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.AM,
        ),
        day: Day(
            month: 3,
            year: 2022,
            weekday: 3,
            date: 30
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.AM,
        ),
        day: Day(
            month: 3,
            year: 2022,
            weekday: 3,
            date: 30
        ),
      ),
      title: "기몌수 홍대",
    ),
    Event(
      color: EventColors.green,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: Day(
          month: 3,
          year: 2022,
          weekday: 3,
          date: 30
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: Day(
            month: 3,
            year: 2022,
            weekday: 3,
            date: 30
        ),
      ),
      title: "Study Coding",
    ),
  ];

  List<Event> _thisMonthEvents = [];
  List<Event> get thisMonthEvents => [...this._thisMonthEvents];

  Color _color = EventColors.orange;
  Color get color => this._color;
  set color(Color c) => throw "error";

  List<Event> _fetchThisMonthEvents({required SelectedMonth selectedMonth}){
    List<Event> _thisMonthEvents = [];
    for (int i = 0; i < this._userEvents.length; i++){
      if (this._userEvents[i].startTime.day.year == selectedMonth.year) {
        if (this._userEvents[i].startTime.day.month == selectedMonth.month) {
          _thisMonthEvents.add(this._userEvents[i]);
        }
      }
    }
    return _thisMonthEvents;
  }

  void changeColor(Color c){
    this._color = c;
    this.notifyListeners();
    return;
  }

  void addEvent({required String title, required EventTime startTime, required EventTime endTime}){
    final Event _newEvent = Event(title: title, startTime: startTime, color: this.color, endTime: endTime);
    this._thisMonthEvents.add(_newEvent);
    this.notifyListeners();
    return;
  }

}