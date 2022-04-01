import 'package:portfolio_calendar/models/class/calendar_class.dart';

import 'event_class.dart' show Event;

abstract class DayAbstract extends Calendar {
  int date = 1; // 날짜
  int weekday = 1; // 요일

  int changeWeekday() => this.weekday = 0;

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

class Day extends DayAbstract {
  @override
  int date;

  @override
  int weekday;

  int selectedMonth;
  int year;

  factory Day.newDay(Day newDate){
    return Day(year: newDate.year, weekday: newDate.weekday, selectedMonth: newDate.selectedMonth, date: newDate.date);
  }

  Day({required this.date, required this.weekday, required this.selectedMonth, required this.year}){
    if (this.weekday == 7) super.changeWeekday();
  }

  Day.withWeekIndex({required this.date, required this.weekday, required this.selectedMonth, required this.year, required int weekIndex}){
    if (weekIndex == 0 && this.date > 7) this.selectedMonth =- 1;
    if (weekIndex > 3 && this.date < 7) this.selectedMonth += 1;
  }

  Day.today() : this(date: DateTime.now().day, selectedMonth: DateTime.now().month, weekday: DateTime.now().weekday, year: DateTime.now().year);

  String textInfo(){
    final String _day = super.convertWeekday(weekday: this.weekday);
    final String _month = this.convertMonth(month: this.selectedMonth);
    return "$_day, ${this.date} $_month";
  }

  String convertMonth({required int month}){
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

class DateTileData extends Day {
  @override
  final int date;

  @override
  final int weekday;

  int weekIndex;
  int selectedMonth;
  int year;

  List<Event> startEvents = [];
  List<Event> endEvents = [];

  DateTileData({required this.date, required this.weekday, required this.selectedMonth, required this.year, required this.weekIndex, required List<Event> events})
    : super.withWeekIndex(date: date, year: year, weekIndex: weekIndex, selectedMonth: selectedMonth, weekday: year) {
        this._events(events: events);
      }

  void _events({required List<Event> events}){
    for (int i = 0; i < events.length; i++){
      if (events[i].startTime.day.date == this.date) this.startEvents.add(events[i]);
      if (events[i].endTime.day.date == this.date) this.endEvents.add(events[i]);
    }
    return;
  }

}