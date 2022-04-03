import 'package:portfolio_calendar/models/class/calendar_class.dart';

import 'event_class.dart' show Event;
typedef week = List<DateTileData>;

abstract class DayAbstract extends Calendar {
  final int year = 2022;
  final int month = 1;
  final int date = 1; // 날짜
  int? weekday = 1; // 요일

  void changeWeekday() => this.weekday = 0;

  String convertWeekday({required int weekday}){
    switch (weekday) {
      case 0: return "Sun";
      case 1: return "Mon";
      case 2: return "Tue";
      case 3: return "Wed";
      case 4: return "Thu";
      case 5: return "Fri";
      case 6: return "Sat";
    }
    return "day";
  }
}

class DayData extends DayAbstract {
  @override
  final int year;

  @override
  final int month;

  @override
  final int date;

  @override
  final int? weekday;

  factory DayData.newDay(DayData newDate){
    return DayData(year: newDate.year, month: newDate.month, date: newDate.date,);
  }

  DayData({required this.date, required this.month, required this.year})
      : this.weekday = DateTime(year, month, date).weekday {
    if (this.weekday == 7) super.changeWeekday();
  }

  DayData.today() : this(date: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year);

  String textInfo(){
    assert(this.weekday != null, "weekday is null");
    final String _day = super.convertWeekday(weekday: this.weekday ?? 1);
    final String _month = this.monthToString(month: this.month);
    return "$_day, ${this.date} $_month";
  }

  String monthToString({required int month}){
    switch (month) {
      case 1: return "Jan";
      case 2: return "Feb";
      case 3: return "Mar";
      case 4: return "Apr";
      case 5: return "May";
      case 6: return "June";
      case 7: return "July";
      case 8: return "Aug";
      case 9: return "Sep";
      case 10: return "Oct";
      case 11: return "Nov";
      case 12: return "Dec";
    }
    return "month";
  }

}

class DateTileData extends DayData {
  @override
  final int year;

  @override
  final int month;

  @override
  final int date;

  @override
  int? weekday;

  List<Event> startEvents = [];
  List<Event> endEvents = [];

  DateTileData({required this.date, required this.month, required this.year, List<Event>? events})
      : super(date: date, year: year, month: month) {
    if (events != null) this._events(events: events);
  }

  void _events({required List<Event> events}){
    for (int i = 0; i < events.length; i++){
      if (events[i].startTime.day.date == this.date && events[i].startTime.day.month == this.month) this.startEvents.add(events[i]);
      if (events[i].endTime.day.date == this.date && events[i].startTime.day.month == this.month) this.endEvents.add(events[i]);
    }
    return;
  }

  factory DateTileData.withEvents({required DateTileData data, required List<Event> events}){
    return DateTileData(date: data.date, month: data.month, year: data.year, events: events);
  }

}