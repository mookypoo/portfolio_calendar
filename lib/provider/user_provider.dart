import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:portfolio_calendar/repos/enum.dart';
import 'package:portfolio_calendar/service/user_service.dart';

import '../class/day_class.dart' show DateTileData, DayData;
import '../class/event_class.dart';
import '../class/user_color.dart';
import '../class/selected_month.dart';
import '../class/time_model.dart' show Period, Time;
import '../repos/variables.dart' show EventColors;

class UserProvider with ChangeNotifier {
  UserService _userService = UserService();

  ProviderState _state = ProviderState.open;
  ProviderState get state => this._state;
  set state(ProviderState s) => throw "error";

  String? userUid;

  SelectedMonth selectedMonth;

  UserProvider(this.selectedMonth){
    print("user provider init");
    this._thisMonthEvents = this._fetchThisMonthEvents(selectedMonth: this.selectedMonth);
  }

  void init({required String userUid}) async {
    this.userUid = userUid;
    if (this._state == ProviderState.open) {
      final Map<String, dynamic>? _res = await this._userService.getUserColors(userUid: userUid);
      if (_res != null) {
        final List<Map<String, dynamic>> _colors = List<Map<String, dynamic>>.from(_res["colors"]);
        this._userColors = _colors.map((Map<String, dynamic> json) => UserColor.fromJson(json)).toList();
      }

      this._state = ProviderState.complete;
    }
    return;
  }

  List<UserColor> _userColors = [];
  List<UserColor> get userColors => [...this._userColors];
  set UserColors(List<UserColor> c) => throw "error";

  List<Event> _userEvents = [
    Event(
      color: EventColors.yellow,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.AM,
        ),
        day: DayData(
            month: 3,
            year: 2022,
            date: 30
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.AM,
        ),
        day: DayData(
            month: 3,
            year: 2022,
            date: 30
        ),
      ),
      title: "기몌수 홍대",
    ),
    Event(
      color: EventColors.green,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 3,
          year: 2022,
          date: 30,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
            month: 3,
            year: 2022,
            date: 30
        ),
      ),
      title: "Study Coding",
    ),
    Event(
      color: EventColors.purple,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 2,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
            month: 4,
          year: 2022,
          date: 2,
        ),
      ),
      title: "Tattoo",
    ),
    Event(
      color: EventColors.green,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 5,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 5,
        ),
      ),
      title: "Mom's Bday",
    ),
    Event(
      color: EventColors.red,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
            month: 4,
            year: 2022,
            date: 20
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
            month: 4,
            year: 2022,
            date: 20
        ),
      ),
      title: "Sarah at Gangnam",
    ),
    Event(
      color: EventColors.orange,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 30,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 4,
          year: 2022,
          date: 30,
        ),
      ),
      title: "Team meeting",
    ),
    Event(
      color: EventColors.purple,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 5,
          year: 2022,
          date: 6,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 5,
          year: 2022,
          date: 6,
        ),
      ),
      title: "My bday",
    ),
    Event(
      color: EventColors.red,
      startTime: EventTime(
        time: Time(
          hour: 8,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 5,
          year: 2022,
          date: 31,
        ),
      ),
      endTime: EventTime(
        time: Time(
          hour: 9,
          minute: 0,
          period: Period.PM,
        ),
        day: DayData(
          month: 5,
          year: 2022,
          date: 31,
        ),
      ),
      title: "Team meeting",
    ),
  ];


  List<Event> _thisMonthEvents = [];
  List<Event> get thisMonthEvents => [...this._thisMonthEvents];

  // todo 서버에서 갖고올때는 이 코드 써서 갖고오면 될듯
  List<Event> _fetchThisMonthEvents({required SelectedMonth selectedMonth}){
    List<Event> _thisMonthEvents = [];
    selectedMonth.weekList.forEach((List<DateTileData> week) {
      week.forEach((DateTileData data) {
        if (selectedMonth.weekList.indexOf(week) == 0 && data.date < 32 && data.date > 24) {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.startTime.day.month == selectedMonth.month - 1 && e.startTime.day.date == data.date);
          _thisMonthEvents.addAll(_indices);
        } else if (selectedMonth.weekList.indexOf(week) == selectedMonth.weekList.length - 1 && data.date < 7) {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.startTime.day.month == selectedMonth.month + 1 && e.startTime.day.date == data.date);
          _thisMonthEvents.addAll(_indices);
        } else {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.startTime.day.month == selectedMonth.month && e.startTime.day.date == data.date);
          _thisMonthEvents.addAll(_indices);
        }
      });
    });
    return _thisMonthEvents;
  }

  void addEvent({required String title, required EventTime startTime, required EventTime endTime, required Color color}){
    final Event _newEvent = Event(title: title, startTime: startTime, color: color, endTime: endTime);
    this._thisMonthEvents.add(_newEvent);
    this.notifyListeners();
    return;
  }

  void changeState(ProviderState state){
    this._state = state;
    return;
  }

  void addColor(UserColor uc) => this._userColors.add(uc);

  void removeColor(UserColor uc) => this._userColors.removeWhere((UserColor c) => c.color == uc.color);

}