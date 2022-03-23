import 'calendar_models.dart';

class CalendarService {

  MonthAndWeeksModel changeToPrevMonth({required MonthAndWeeksModel data, required int year}) {
    if (data.month == 1) {
      return MonthAndWeeksModel(month: 12, year: year -1);
    } else {
      return MonthAndWeeksModel(month: data.month - 1, year: year);
    }
  }
}