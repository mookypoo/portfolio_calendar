import 'calendar_models.dart';

class CalendarService {
  MonthAndWeeksModel init({required int month, required int year}){
    final DateAndDayModel _firstDayOfMonth = this._getFirstDayOfMonth(month: month, year: year);
    final DateAndDayModel _lastDayOfMonth = this._getLastDayOfMonth(month: month, year: year);
    final List<int?> _firstWeek = this._getFirstWeek(firstDayOfMonth: _firstDayOfMonth, selectedMonth: month);
    final List<int?> _lastWeek = this._getLastWeek(lastDayOfMonth: _lastDayOfMonth);
    List<int> _allWeeks = this._getWeeks(firstWeek: _firstWeek, lastWeek: _lastWeek, lastDayOfMonth: _lastDayOfMonth);
    List<List<int?>> _month = [_firstWeek];
    for (int i=0; i< (_allWeeks.length)/7 + 1; i++) {
      _month.add(_allWeeks.sublist(0, 7));
      _allWeeks.removeRange(0, 7);
    }
    if (_lastWeek.isEmpty) {
      return MonthAndWeeksModel(month: month, weeks: _month);
    }
    _month.add(_lastWeek);
    return MonthAndWeeksModel(month: month, weeks: _month);
  }

  DateAndDayModel _getFirstDayOfMonth({required int month, required int year}){
    final int _day = DateTime.utc(year, month, 1).weekday;
    return new DateAndDayModel(date: 1, day: _day);
  }

  DateAndDayModel _getLastDayOfMonth({required int month, required int year}){
    final int _lastDate = this._getLastDate(month: month);
    final int _lastDay = DateTime.utc(year, month, _lastDate).weekday;
    return new DateAndDayModel(date: _lastDate, day: _lastDay);
  }

  List<int?> _getFirstWeek({required DateAndDayModel firstDayOfMonth, required int selectedMonth}){
    final int _firstDay = firstDayOfMonth.day;
    if (_firstDay == 7) return [1, 2, 3, 4, 5, 6, 7];
    List<int?> _firstWeek = []..length = 7;
    for (int i = 0; i < 7; i++) {
      if (i < _firstDay) {
        _firstWeek[i] = this._getLastDate(month: selectedMonth - 1) + i - 1;
      } else {
        _firstWeek[i] = i - 1;
      }
    }
    return _firstWeek;
  }

  List<int?> _getLastWeek({required DateAndDayModel lastDayOfMonth}){
    final int _lastDay = lastDayOfMonth.day;
    if (_lastDay == 7) return [];
    List<int?> _lastWeek = []..length = 7;
    for (int i = 0; i < 7; i++){
      if (i <= _lastDay) {
        _lastWeek[_lastDay - i] = lastDayOfMonth.date - i;
      } else {
        _lastWeek[i] = i - _lastDay;
      }
    }
    return _lastWeek;
  }

  List<int> _getWeeks({required List<int?> firstWeek, required List<int?> lastWeek, required DateAndDayModel lastDayOfMonth}){
    List<int> _weeks = [];
    int? _lastDay;
    if (lastWeek.isEmpty) {
      _lastDay = lastDayOfMonth.date;
    } else {
      _lastDay = lastWeek[0]!;
    }
    for (int i = 0; i < _lastDay - firstWeek[6]!; i++) {
      _weeks.add(firstWeek[6]! + i + 1);
    }
    return _weeks;
  }

  int _getLastDate({required int month}){
    switch (month) {
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

}