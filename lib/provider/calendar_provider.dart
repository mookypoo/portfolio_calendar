
import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/service/calendar_service.dart';

import '../models/class/day_class.dart' show DateTileData, DayData, week;
import '../models/selected_month.dart';
import '../repos/variables.dart' show Today;

class CalendarProvider with ChangeNotifier {
  CalendarService _calendarService = CalendarService();

  CalendarProvider(){
    print("calendar provider init");
  }

  DayData _selectedDate = DayData.today();
  DayData get selectedDate => this._selectedDate;
  set selectedDate(DayData d) => throw "error";

  SelectedMonth _selectedMonth = SelectedMonth(
    month: DateTime.now().month,
    year: DateTime.now().year,
  );
  SelectedMonth get selectedMonth => this._selectedMonth;
  set selectedMonth(SelectedMonth s) => throw "error";

  String get monthString => this._selectedDate.monthToString(month: this.month);
  set monthString(String s) => throw "error";

  int get month => this._selectedMonth.month;
  set month(int i) => throw "error";

  int get year => this._selectedMonth.year;
  set year(int i) => throw "error";

  List<week> get weekList => [...this._selectedMonth.weekList];

  void nextMonth(){
    this._selectedMonth = this._calendarService.nextMonth(month: this.month, year: this.year);
    this._changeSelectedDate(month: this.month, year: this.year);
    this.notifyListeners();
    return;
  }

  void prevMonth(){
    this._selectedMonth = this._calendarService.prevMonth(month: this.month, year: this.year);
    this._changeSelectedDate(month: this.month, year: this.year);
    this.notifyListeners();
    return;
  }

  void _changeSelectedDate({required int month, required int year}){
    if (month == Today.today.month) {
      this._selectedDate = this._calendarService.changeDay(Today.today);
    } else {
      this._selectedDate = DayData(date: 1, month: month, year: this.year);
    }
    return;
  }

  void selectDate(DateTileData newDate){
    this._selectedDate = this._calendarService.changeDay(newDate);
    this.notifyListeners();
    return;
  }
}