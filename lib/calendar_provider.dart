import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/calendar_service.dart';

import 'calendar_models.dart';

class CalendarProvider with ChangeNotifier {
  CalendarService _calendarService = CalendarService();

  MonthModel _selectedMonth = MonthModel(
    month: DateTime.now().month,
    year: DateTime.now().year,
  );
  MonthModel get selectedMonth => this._selectedMonth;
  set selectedMonth(MonthModel l) => throw "error";

  void prevMonth(){
    this._selectedMonth.prevMonth();
    this.notifyListeners();
    return;
  }

  void nextMonth(){
    this._selectedMonth.nextMonth();
    this.notifyListeners();
    return;
  }
}