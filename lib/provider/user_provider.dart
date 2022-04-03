import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../models/class/day_class.dart' show DateTileData, DayData;
import '../models/class/event_class.dart';
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
        day: DayData(
            month: 3,
            year: 2022,
            date: 30
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.AM,
        ),
        day: DayData(
            month: 3,
            year: 2022,
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
        day: DayData(
            month: 3,
            year: 2022,
            date: 30
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
            month: 3,
            year: 2022,
            date: 30
        ),
      ),
      title: "Study Coding",
    ),
    Event(
      color: EventColors.purple,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 2,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 2,
        ),
      ),
      title: "Tattoo",
    ),
    Event(
      color: EventColors.green,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 5,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 5,
        ),
      ),
      title: "Mom's Bday",
    ),
    Event(
      color: EventColors.red,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
            month: 4,
            year: 2022,
            date: 20
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
            month: 4,
            year: 2022,
            date: 20
        ),
      ),
      title: "Sarah at Gangnam",
    ),
    Event(
      color: EventColors.orange,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 30,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 30,
        ),
      ),
      title: "Team meeting",
    ),
    Event(
      color: EventColors.purple,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 5,
          year: 2022,
          date: 6,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 5,
          year: 2022,
          date: 6,
        ),
      ),
      title: "My bday",
    ),
    Event(
      color: EventColors.red,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 5,
          year: 2022,
          date: 31,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 5,
          year: 2022,
          date: 31,
        ),
      ),
      title: "Team meeting",
    ),
  ];

  List<Event> _thisMonthEvents = [];
  List<Event> get thisMonthEvents => [...this._thisMonthEvents];

  Color _color = EventColors.orange;
  Color get color => this._color;
  set color(Color c) => throw "error";

  // todo 서버에서 갖고올때는 이 코드 써서 갖고오면 될듯
  List<Event> _fetchThisMonthEvents({required SelectedMonth selectedMonth}){
    List<Event> _thisMonthEvents = [];
    selectedMonth.weekList.forEach((List<DateTileData> week) {
      week.forEach((DateTileData data) {
        if (selectedMonth.weekList.indexOf(week) == 0 && data.date < 32 && data.date > 24) {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.startTime.day.month == selectedMonth.month - 1 && e.startTime.day.date == data.date);
          _thisMonthEvents.addAll(_indices);
        } else if (selectedMonth.weekList.indexOf(week) == selectedMonth.weekList.length - 1 && data.date < 7) {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.startTime.day.month == selectedMonth.month + 1 && e.startTime.day.date == data.date);
          _thisMonthEvents.addAll(_indices);
        } else {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.startTime.day.month == selectedMonth.month && e.startTime.day.date == data.date);
          _thisMonthEvents.addAll(_indices);
        }
      });
    });
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