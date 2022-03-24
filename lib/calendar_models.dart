class DateDayModel {
  final int date; // 날짜
  final int day; // 요일
  DateDayModel({required this.date, required this.day});
}

class MonthModel {
  int year;
  int month;
  List<List<int?>> weeks = [];

  MonthModel({required this.month, required this.year}){
    this._init();
  }

  void _init(){
    final List<int?> _firstWeek = this._firstWeek();
    final DateDayModel _lastDay = this._lastDayOfMonth(month: this.month, year: this.year);
    final List<int?> _lastWeek = this._lastWeek(lastDay: _lastDay);
    this.weeks = this._weeks(firstWeek: _firstWeek, lastWeek: _lastWeek, lastDate: _lastDay.date);
    return;
  }

  List<int?> _firstWeek(){
    final int _firstDay = DateTime.utc(this.year, this.month, 1).weekday;
    if (_firstDay == 7) return [1, 2, 3, 4, 5, 6, 7];

    List<int?> _firstWeek = []..length = 7;
    final int _lastDateOfPrevMonth = this._lastDate(month: this.month == 1 ? 12 : this.month - 1);
    for (int i = 0; i < 7; i++){
      if (i < _firstDay) _firstWeek[i] = _lastDateOfPrevMonth - (_firstDay - i) + 1;
      if (i >= _firstDay) _firstWeek[i] = 1 + (i - _firstDay);
    }
    return _firstWeek;
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

  DateDayModel _lastDayOfMonth({required int month, required int year}){
    final int _lastDate = this._lastDate();
    final int _lastDay = DateTime.utc(year, month, _lastDate).weekday;
    return DateDayModel(date: _lastDate, day: _lastDay);
  }

  List<int?> _lastWeek({required DateDayModel lastDay}){
    if (lastDay.day == 6) return [];
    int _lastDay = lastDay.day;
    if (lastDay.day == 7) _lastDay = 0;
    List<int?> _lastWeek = []..length = 7;
    for (int i = 0; i < 7; i++) {
      if (i <= _lastDay) _lastWeek[i] = lastDay.date - (_lastDay - i);
      if (i > _lastDay) _lastWeek[i] = i - _lastDay;
    }

    return _lastWeek;
  }

  List<List<int?>> _weeks({required List<int?> firstWeek, required List<int?> lastWeek, required int lastDate}){
    List<List<int?>> _weeks = [firstWeek];
    final int _firstSat = firstWeek[6] as int;

    if (lastWeek.isEmpty) {
      for (int i = 0; i < (lastDate - (_firstSat))/7; i++) {
        int _sunday = (_weeks[i][6] as int) + 1;
        _weeks.add(List.generate(7, (int a) => _sunday + a));
      }
    } else {
      for (int i = 0; i < ((lastWeek[0]! - 1) - (_firstSat))/7; i++) {
        int _sunday = (_weeks[i][6] as int) + 1;
        _weeks.add(List.generate(7, (int a) => _sunday + a));
      }
      _weeks.add(lastWeek);
    }
    return _weeks;
  }

  void prevMonth(){
    this.year = this.month == 1 ? this.year - 1 : this.year;
    this.month = this.month == 1 ? 12 : this.month - 1;
    this._init();
    return;
  }

  void nextMonth(){
    this.year = this.month == 12 ? this.year + 1 : this.year;
    this.month = this.month == 12 ? 1 : this.month + 1;
    this._init();
    return;
  }

  bool isThisMonth(int index, int date){
    if (index == 0) {
      if (date > 7) return false;
    }
    if (index == 4 || index == 5) {
      if (date < 7) return false;
    }
    return true;
  }
}
