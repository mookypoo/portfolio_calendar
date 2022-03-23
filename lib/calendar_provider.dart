import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/calendar_service.dart';

import 'calendar_models.dart';

class CalendarProvider with ChangeNotifier {
  CalendarService _calendarService = CalendarService();

  CalendarProvider(){
    this.calendarInit();
  }

  MonthAndWeeksModel? _selectedMonth;
  MonthAndWeeksModel? get selectedMonth => this._selectedMonth;
  set selectedMonth(MonthAndWeeksModel? l) => throw "error";

  void calendarInit() => this._selectedMonth = this._calendarService.init(month: DateTime.now().month, year: DateTime.now().year);

}