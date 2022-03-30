enum Period {
  AM, PM,
}

abstract class TimeAbstract {
  final int hour = DateTime.now().hour;
  final int minute = DateTime.now().minute;
  final Period period = Period.AM;

  // void convertHour(){
  //   if (this.hour == 13) this.hour = 1;
  //   if (this.hour == 14) this.hour = 2;
  //   if (this.hour == 15) this.hour = 3;
  //   if (this.hour == 16) this.hour = 4;
  //   if (this.hour == 17) this.hour = 5;
  //   if (this.hour == 18) this.hour = 6;
  //   if (this.hour == 19) this.hour = 7;
  //   if (this.hour == 20) this.hour = 8;
  //   if (this.hour == 21) this.hour = 9;
  //   if (this.hour == 22) this.hour = 10;
  //   if (this.hour == 23) this.hour = 11;
  //   if (this.hour == 24) this.hour = 12;
  //   this._convertAMPM();
  //   return;
  // }
  //
  // void _convertAMPM() => this.period = Period.PM;

}

class Time extends TimeAbstract {
  @override
  final int hour;

  @override
  final int minute;

  @override
  Period period;

  Time({required this.hour, required this.minute, required this.period});

  String get time => "${this.hour}:${this.minute.toString().padLeft(2, "0")} ${this.period.toString().substring(7)}";
}