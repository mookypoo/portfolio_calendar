import 'class/day_class.dart' show DateTileData;

abstract class MonthAbstract {
  int year = 2022;
  int month = 1;
  List<List<DateTileData>> days = [];
  List<List<int>> weekList = [];

  List<DateTileData> _days({required int month, required int year}){
    List<DateTileData> _days = [];
    final int _firstDay = DateTime.utc(year, month, 1).weekday;
    if (_firstDay != 7) {
      final int _pmLastDay = this._lastDate(month: month == 1 ? 12 : month - 1);
      for (int i = 0; i < _firstDay; i++) _days.insert(0, DateTileData(date: _pmLastDay - i, ));
    }

    final int _tmLastDate = this._lastDate();
    final int _tmLastDay = DateTime.utc(year, month, _tmLastDate).weekday;

    for (int i = 1; i < _tmLastDate + 1; i++) _days.add(i);
    if (_tmLastDay != 6) {
      for (int i = 1; i < 7 - _tmLastDay; i ++) _days.add(i);
    }
    return _days;
  }

  List<List<int>> _weeks({required int month, required int year}){
    final List<int> _days = this._days(month: month, year: year);
    List<List<int>> _weeks = [];
    for (int i = 0; i < _days.length/7; i++) {
      _weeks.add(List.generate(7, (int index) => _days[7*i + index]));
    }
    this.weekList = _weeks;
    return _weeks;
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

  void fetchDateTileData({required int month, required int year}){
    List<List<int>> _weeks = this._weeks(month: month, year: year);

    List<List<DateTileData>> _dateTileDays = [];
    _weeks.forEach((List<int> week) {
      week.forEach((int date) {
        if (_weeks.indexOf(week) == 0 && date < 32) {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.startTime.day.month == month.month - 1 && e.startTime.day.date == date);
          _thisMonthEvents.addAll(_indices);
        } else if (month.weekList.indexOf(week) == month.weekList.length - 1 && date < 7) {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.startTime.day.month == month.month + 1 && e.startTime.day.date == date);
          _thisMonthEvents.addAll(_indices);
        } else {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.startTime.day.month == month.month && e.startTime.day.date == date);
          _thisMonthEvents.addAll(_indices);
        }
      });
    });
  }

}