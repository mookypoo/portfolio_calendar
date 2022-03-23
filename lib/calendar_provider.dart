import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/calendar_service.dart';

import 'calendar_models.dart';

class CalendarProvider with ChangeNotifier {
  CalendarService _calendarService = CalendarService();

  MonthAndWeeksModel _selectedMonth = MonthAndWeeksModel(
    month: DateTime.now().month,
    year: DateTime.now().year,
  );
  MonthAndWeeksModel get selectedMonth => this._selectedMonth;
  set selectedMonth(MonthAndWeeksModel l) => throw "error";

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