import 'package:portfolio_calendar/models/calendar_class.dart';

import '../repos/variables.dart' show Today;

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

class DateModel extends DayAbstract {
  @override
  int date;

  @override
  int weekday;

  int month;
  int year;

  DateModel({required this.date, required this.weekday, required this.month, required this.year}){
    if (this.weekday == 7) super.changeWeekday();
  }

  DateModel.withWeekIndex({required this.date, required this.weekday, required this.month, required this.year, required int weekIndex}){
    if (weekIndex == 0 && this.date > 7) this.month =- 1;
    if (weekIndex > 3 && this.date < 7) this.month += 1;
  }

  DateModel.today() : this(date: DateTime.now().day, month: DateTime.now().month, weekday: DateTime.now().weekday, year: DateTime.now().year);

  void changeData(DateModel data){
    this.date = data.date;
    this.weekday = data.weekday;
    this.month = data.month;
    this.year = data.year;
  }

  String textInfo(){
    final String _day = super.convertWeekday(weekday: this.weekday);
    final String _month = this.convertMonth(month: this.month);
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

  void changeMonth({required int month, required int year}){
    if (month == Today.today.month) {
      this.changeData(Today.today);
    } else {
      this.month = month;
      this.date = 1;
      this.year = year;
    }
  }

  int _lastDate({int? month}){
    switch (month ?? this.month) {
      case 1: return 31;
      case 2: return 28;
      case 3: return 31;
      case 4: return 30;
      case 5: return 31;
      case 6: return 30;
      case 7: return 31;
      case 8: return 31;
      case 9: return 30;
      case 10: return 31;
      case 11: return 30;
      case 12: return 31;
      default: return 31;
    }
  }

  int prevDate({required int date, required int month}){
    if (date == 1) {
      return this._lastDate(month: month);
    } else {
      return date - 1;
    }
  }

  int nextDate({required int date, required int month}){
    final int _tmLastDate = this._lastDate(month: month);
    if (_tmLastDate == date) {
      return 1;
    } else {
      return date + 1;
    }
  }

  int prevDay({required int day}){
    if (day == 0) {
      return 6;
    } else {
      return day-1;
    }
  }

  int nextDay({required int day}){
    if (day == 6) {
      return 0;
    } else {
      return day+1;
    }
  }

  int prevMonth({required int month}){
    if (month == 1) {
      return 12;
    } else {
      return month-1;
    }
  }

  int nextMonth({required int month}){
    if (month == 12) {
      return 1;
    } else {
      return month + 1;
    }
  }

  //String nextDay({required int day}) => super.convertWeekday(weekday: day == 6 ? 0 : day+1);
}

class DateTileModel extends DateModel {
  @override
  final int date;

  @override
  final int weekday;

  int weekIndex;
  int month;
  int year;

  DateTileModel({required this.date, required this.weekday, required this.month, required this.year, required this.weekIndex})
    : super.withWeekIndex(date: date, year: year, weekIndex: weekIndex, month: month, weekday: year);

  bool isSame({required DateTileModel date1, required DateModel date2}){
    if (date1.date == date2.date && date1.month == date2.month && date1.year == date2.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isThisMonth(){
    if (this.weekIndex == 0) {
      if (this.date > 7) return false;
    }
    if (this.weekIndex == 4 || this.weekIndex == 5) {
      if (this.date < 7) return false;
    }
    return true;
  }
}