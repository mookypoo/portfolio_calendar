abstract class TimeAbstract {
  int hour = DateTime.now().hour;
  String minute = DateTime.now().minute.toString().padLeft(2, "0");
  String amPM = "AM";

  void convertHour(){
    if (this.hour == 13) this.hour = 1;
    if (this.hour == 14) this.hour = 2;
    if (this.hour == 15) this.hour = 3;
    if (this.hour == 16) this.hour = 4;
    if (this.hour == 17) this.hour = 5;
    if (this.hour == 18) this.hour = 6;
    if (this.hour == 19) this.hour = 7;
    if (this.hour == 20) this.hour = 8;
    if (this.hour == 21) this.hour = 9;
    if (this.hour == 22) this.hour = 10;
    if (this.hour == 23) this.hour = 11;
    if (this.hour == 24) this.hour = 12;
    this._convertAMPM();
    return;
  }

  void _convertAMPM(){
    if (this.amPM == "AM") this.amPM = "PM";
    if (this.amPM == "PM") this.amPM = "AM";
    return;
  }

}

class Time extends TimeAbstract {
  @override
  int hour = DateTime.now().hour;

  @override
  String minute = "00";

  @override
  String amPM = "AM";

  Time(){
    if (this.hour > 12) {
      super.convertHour();
      this.amPM = "PM";
    }
  }

  String get time => "${this.hour}:${this.minute} ${this.amPM}";
}