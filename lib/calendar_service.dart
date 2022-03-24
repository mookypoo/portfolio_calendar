import 'calendar_models.dart';

class CalendarService {

  MonthModel changeToPrevMonth({required MonthModel data, required int year}) {
    if (data.month == 1) {
      return MonthModel(month: 12, year: year -1);
    } else {
      return MonthModel(month: data.month - 1, year: year);
    }
  }
}