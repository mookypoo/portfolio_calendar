import 'package:flutter/foundation.dart';
import 'package:portfolio_calendar/repos/enum.dart';
import 'package:portfolio_calendar/service/user_service.dart';

import '../class/day_class.dart' show DateTileData, DayData;
import '../class/event_class.dart';
import '../class/user_color.dart';
import '../class/selected_month.dart';
import '../class/time_model.dart' show Period, Time;
import '../repos/user_data.dart';
import '../repos/variables.dart' show EventColors;

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  final UserData _userData = UserData();

  ProviderState _state = ProviderState.open;
  ProviderState get state => this._state;
  set state(ProviderState s) => throw "error";

  String userUid = "";

  UserProvider(){
    print("user provider init");
    this._userEvents = this._userData.userEvents;
    this._userColors = this._userData.userColors;
    this._thisMonthEvents = this._fetchThisMonthEvents(selectedMonth: SelectedMonth(
      month: DateTime.now().month,
      year: DateTime.now().year,
    ));
  }

  List<UserColor> _userColors = [];
  List<UserColor> get userColors => [...this._userColors];
  set userColors(List<UserColor> l) => throw "error";

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

  List<Event> _userEvents = [];

  List<Event> _thisMonthEvents = [];
  List<Event> get thisMonthEvents => [...this._thisMonthEvents];

  // todo 서버에서 갖고올때는 이 코드 써서 갖고오면 될듯
  List<Event> _fetchThisMonthEvents({required SelectedMonth selectedMonth}){
    List<Event> _thisMonthEvents = [];
    selectedMonth.weekList.forEach((List<DateTileData> week) {
      week.forEach((DateTileData data) {
        if (selectedMonth.weekList.indexOf(week) == 0 && data.date < 32 && data.date > 24) {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.day.month == selectedMonth.month - 1 && e.day.date == data.date);
          _thisMonthEvents.addAll(_indices);
        } else if (selectedMonth.weekList.indexOf(week) == selectedMonth.weekList.length - 1 && data.date < 7) {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.day.month == selectedMonth.month + 1 && e.day.date == data.date);
          _thisMonthEvents.addAll(_indices);
        } else {
          final Iterable<Event> _indices = this._userEvents.where((Event e) => e.day.month == selectedMonth.month && e.day.date == data.date);
          _thisMonthEvents.addAll(_indices);
        }
      });
    });
    return _thisMonthEvents;
  }

  void changeMonth({required SelectedMonth selectedMonth}){
    this._thisMonthEvents = this._fetchThisMonthEvents(selectedMonth: selectedMonth);
    this.notifyListeners();
  }

  void addEvent(Event newEvent){
    this._thisMonthEvents.add(newEvent);
    this._userService.eventActions(userUid: this.userUid, event: newEvent, action: "add");
    this.notifyListeners();
    return;
  }

  void changeState(ProviderState state){
    this._state = state;
    return;
  }

  void addColor(UserColor uc){
    this._userColors.add(uc);
    this._userService.colorActions(userUid: this.userUid, action: "add", uc: uc);
  }

  void removeColor(UserColor uc){
    this._userColors.removeWhere((UserColor c) => c.color == uc.color);
    this._userService.colorActions(userUid: this.userUid, action: "delete", uc: uc);
  }

  List<Event> selectedDayEvents(DayData day){
    return this._thisMonthEvents.where((Event event) => event.day.date == day.date).toList();
  }

}