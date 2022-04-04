import '../models/time_model.dart' show Period;

class TimeService {

  List<int> hours({required int startHour}){
    List<int> hours = [];
    for (int i = 0; i < 12; i++) {
      int _nextHour = this.convertHour(hour: startHour + i);
      hours.add(_nextHour);
    }
    return hours;
  }

  int convertHour({required int hour}){
    if (hour < 12 && hour > 0) return hour;
    if (hour == 13 || hour == -11) return 1;
    if (hour == 14 || hour == -10) return 2;
    if (hour == 15 || hour == -9) return 3;
    if (hour == 16 || hour == -8) return 4;
    if (hour == 17 || hour == -7) return 5;
    if (hour == 18 || hour == -6) return 6;
    if (hour == 19 || hour == -5) return 7;
    if (hour == 20 || hour == -4) return 8;
    if (hour == 21 || hour == -3) return 9;
    if (hour == 22 || hour == -2) return 10;
    if (hour == 23 || hour == -1) return 11;
    if (hour == 24 || hour == 0) return 12;
    return hour;
  }

  Period convertPeriod({required Period period}){
    if (period == Period.AM) return Period.PM;
    if (period == Period.PM) return Period.AM;
    return period;
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