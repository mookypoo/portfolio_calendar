import '../models/day_class.dart' show DateTileData, Day;
import '../models/selected_month.dart';

class CalendarService {
  Day changeDay(Day newDate) => Day.newDay(newDate);

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

  static bool isSame({required DateTileData date1, required Day date2}){
    if (date1.date == date2.date && date1.month == date2.month && date1.year == date2.year) {
      return true;
    } else {
      return false;
    }
  }

  static bool isThisMonth({required DateTileData data}){
    if (data.weekIndex == 0) {
      if (data.date > 7) return false;
    }
    if (data.weekIndex == 4 || data.weekIndex == 5) {
      if (data.date < 7) return false;
    }
    return true;
  }

}

