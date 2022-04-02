import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/service/time_service.dart';

import '../models/class/day_class.dart' show DayData;
import '../models/class/event_class.dart' show EventTime;
import '../models/time_model.dart' show Period, Time;

class TimeProvider with ChangeNotifier {
  bool _isStartExpanded = false;
  bool get isStartExpanded => this._isStartExpanded;
  set isStartExpanded(bool b) => throw "error";

  bool _isEndExpanded = false;
  bool get isEndExpanded => this._isEndExpanded;
  set isEndExpanded(bool b) => throw "error";

  TimeService _timeService = TimeService();

  DayData day;
  String get dateText => this.day.textInfo();

  int _startMinute = 00;
  int get startMinute => this._startMinute;
  set startMinute(int i) => throw "error";

  int _startHour = DateTime.now().hour + 1;
  int get startHour => this._startHour;
  set startHour(int i) => throw "error";

  Period _startPeriod = Period.AM;
  Period get startPeriod => this._startPeriod;
  set startPeriod(Period p) => throw "error";

  String get startTime => "${this._startHour}:${this._startMinute.toString().padLeft(2, "0")} ${this._startPeriod.toString().substring(7)}";
  set startTime(String s) => throw "error";

  int _endMinute = 00;
  int get endMinute => this._endMinute;
  set endMinute(int i) => throw "error";

  int _endHour = DateTime.now().hour + 2;
  int get endHour => this._endHour;
  set endHour(int i) => throw "error";

  Period _endPeriod = Period.AM;
  Period get endPeriod => this._endPeriod;
  set endPeriod(Period p) => throw "error";

  String get endTime => "${this._endHour}:${this._endMinute.toString().padLeft(2, "0")} ${this._endPeriod.toString().substring(7)}";
  set endTime(String s) => throw "error";

  List<int> _minuteList = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
  List<int> get minuteList => [...this._minuteList];
  set minuteList(List<int> l) => throw "error";

  final List<String> periodList = [Period.AM.toString().substring(7), Period.PM.toString().substring(7)];
  set periodList(List<String> l) => throw "error";

  List<int> _hours = [];
  List<int> get hours => [...this._hours];
  set hours(List<int> l) => throw "error";

  EventTime get startData => this._startData();
  EventTime get endData => this._endData();

  TimeProvider(this.day){
    print("time provider init");
    this._init();
  }

  void _init(){
    if (this._startHour > 12) this._convertStart();
    if (this._endHour > 12) this._convertEnd();
    this._hours = this._timeService.hours(startHour: this._startHour);
    return;
  }

  void expand(String startOrEnd){
    if (startOrEnd == "Starts") this._expandStart();
    if (startOrEnd == "Ends") this._expandEnd();
    this.notifyListeners();
    return;
  }

  void _expandStart(){
    this._isStartExpanded = !this._isStartExpanded;
    this._isEndExpanded = false;
    if (this._isStartExpanded) {
      this._minuteList = this._timeService.minutes(currentMinute: this._startMinute);
      this._hours = this._timeService.hours(startHour: this._startHour);
    }
    return;
  }

  void _expandEnd(){
    this._isEndExpanded = !this._isEndExpanded;
    this._isStartExpanded = false;
    if (this._isEndExpanded) {
      this._minuteList = this._timeService.minutes(currentMinute: this._endMinute);
      this._hours = this._timeService.hours(startHour: this._endHour);
    }
    return;
  }

  void _convertStart(){
    this._startHour = this._timeService.convertHour(hour: this._startHour);
    this._startPeriod = Period.PM;
    return;
  }

  void _convertEnd(){
    this._endHour = this._timeService.convertHour(hour: this._endHour);
    this._endPeriod = Period.PM;
    return;
  }

  void changeSelectedMinute(int index, String startOrEnd){
    if (startOrEnd == "Starts") {
      this._startMinute = this._minuteList[index];
    } else {
      this._endMinute = this._minuteList[index];
    }
    this.notifyListeners();
    return;
  }

  void changeAmPm(int index){
    if (index == 0) {
      this._startPeriod = Period.AM;
    } else {
      this._startPeriod = Period.PM;
    }
    this.notifyListeners();
    return;
  }

  bool changeStartHour({required int index, required bool isIncrement}){
    this._startHour = this._hours[index];
    if (this._startHour == 12 && isIncrement || this._startHour == 11 && !isIncrement) {
      this._startPeriod = this._timeService.convertPeriod(period: this._startPeriod);
      this.notifyListeners();
      return true;
    }
    this.notifyListeners();
    return false;
  }

  bool changeEndHour({required int index, required bool isIncrement}){
    this._endHour = this._hours[index];
    if (this._endHour == 12 && isIncrement || this._endHour == 11 && !isIncrement) {
      this._endPeriod = this._timeService.convertPeriod(period: this._endPeriod);
      this.notifyListeners();
      return true;
    }
    this.notifyListeners();
    return false;
  }

  EventTime _startData(){
    final Time _time = Time(hour: this._startHour, minute: this._startMinute, period: this._startPeriod);
    return EventTime(day: this.day, time: _time);
  }

  EventTime _endData(){
    final Time _time = Time(hour: this._endHour, minute: this._endMinute, period: this._endPeriod);
    return EventTime(day: this.day, time: _time);
  }
}