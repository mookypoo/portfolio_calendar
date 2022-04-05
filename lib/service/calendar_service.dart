import '../class/day_class.dart' show DateTileData, DayData;
import '../class/selected_month.dart';

class CalendarService {
  DayData changeDay(DayData newDate) => DayData.newDay(newDate);

  SelectedMonth prevMonth({required int month, required int year}) {
    int _month;
    int _year = year;
    if (month == 1) {
      _month = 12;
      _year = year - 1;
    } else {
      _month = month - 1;
    }
    return SelectedMonth(year: _year, month: _month);
  }

  SelectedMonth nextMonth({required int month, required int year}) {
    int _month;
    int _year = year;
    if (month == 12) {
      _month = 1;
      _year = year + 1;
    } else {
      _month = month + 1;
    }
    return SelectedMonth(year: _year, month: _month);
  }

  static bool isSame({required DateTileData date1, required DayData date2}){
    if (date1.date == date2.date && date1.month == date2.month && date1.year == date2.year) {
      return true;
    } else {
      return false;
    }
  }

}
