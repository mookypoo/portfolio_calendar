import 'day_class.dart' show DateTileData, week;

abstract class MonthAbstract {
  final int year = 2022;
  final int month = 1;

  final List<week> weekList = [];

  week _days({required int month, required int year}){
    week _days = [];
    final int _firstDay = DateTime.utc(year, month, 1).weekday;
    if (_firstDay != 7) {
      final int _pmLastDay = this._lastDate(month: month == 1 ? 12 : month - 1);
      for (int i = 0; i < _firstDay; i++) _days.insert(0, DateTileData(
          date: _pmLastDay - i,
          year: month - 1 == 0 ? year - 1 : year,
          month: month - 1 == 0 ? 12 : month -1),
      );
    }

    final int _tmLastDate = this._lastDate();
    int _tmLastDay = DateTime.utc(year, month, _tmLastDate).weekday;
    if (_tmLastDay == 7) _tmLastDay = 0;

    for (int i = 1; i < _tmLastDate + 1; i++) _days.add(DateTileData(date: i, month: month, year: year));
    if (_tmLastDay != 6) {
      for (int i = 1; i < 7 - _tmLastDay; i ++) _days.add(DateTileData(
        date: i,
        year: month + 1 == 13 ? year + 1 : year,
        month: month + 1 == 13 ? 1 : month + 1,
      ));
    }
    return _days;
  }

  List<week> weeks({required int month, required int year}){
    final week _days = this._days(month: month, year: year);
    List<week> _weeks = [];
    for (int i = 0; i < _days.length/7; i++) {
      _weeks.add(List.generate(7, (int index) => _days[7*i + index]));
    }
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
}