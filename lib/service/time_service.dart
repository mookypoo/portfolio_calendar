import '../provider/time_provider.dart' show Period;

class TimeService {

  List<int> hours({required int startHour}){
    List<int> hours = [];
    for (int i = 0; i < 12; i++) {
      int _nextHour = startHour + i;
      if (_nextHour > 12) _nextHour = this.convertHour(hour: _nextHour);
      hours.add(_nextHour);
    }
    return hours;
  }

  int convertHour({required int hour}){
    if (hour == 13) return 1;
    if (hour == 14) return 2;
    if (hour == 15) return 3;
    if (hour == 16) return 4;
    if (hour == 17) return 5;
    if (hour == 18) return 6;
    if (hour == 19) return 7;
    if (hour == 20) return 8;
    if (hour == 21) return 9;
    if (hour == 22) return 10;
    if (hour == 23) return 11;
    return 12;
  }

  Period convertPeriod({required Period period}){
    if (period == Period.AM) {
      return Period.PM;
    } else {
      return Period.AM;
    }
  }

  List<int> minutes({required int currentMinute}){
    List<int> _minutes = [];
    for (int i = 0; i < 12; i++) {
      int _nextMinute = currentMinute + 5 * i;
      if (_nextMinute >= 60) _nextMinute = _nextMinute - 60;
      _minutes.add(_nextMinute);
    }
    return _minutes;
  }
}