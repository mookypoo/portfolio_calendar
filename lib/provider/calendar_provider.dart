import 'package:flutter/widgets.dart';

import '../models/day_models.dart' show DateModel, DateTileModel;
import '../models/selected_month.dart';

class CalendarProvider with ChangeNotifier {
  DateModel _selectedDate = DateModel(
    date: DateTime.now().day,
    weekday: DateTime.now().weekday,
    month: DateTime.now().month,
    year: DateTime.now().year,
  );
  DateModel get selectedDate => this.selectedDate;
  set selectedDate(DateModel d) => throw "error";

  SelectedMonth _selectedMonth = SelectedMonth(
    month: DateTime.now().month,
    year: DateTime.now().year,
  );
  SelectedMonth get selectedMonth => this._selectedMonth;
  set selectedMonth(SelectedMonth s) => throw "error";

  String get textMonth => this._selectedDate.convertMonth(month: this.month);
  set textMonth(String s) => throw "error";

  int get month => this._selectedMonth.month;
  set month(int i) => throw "error";

  int get year => this._selectedMonth.year;
  set year(int i) => throw "error";

  List<List<int>> get weeks => [...this._selectedMonth.weekList];

  void nextMonth(){
    this._selectedMonth.nextMonth();
    this._selectedDate.changeMonth(month: this.month, year: this.year);
    this.notifyListeners();
    return;
  }

  void prevMonth(){
    this._selectedMonth.prevMonth();
    this._selectedDate.changeMonth(month: this.month, year: this.year);
    this.notifyListeners();
    return;
  }

  void selectDate(DateTileModel date){
    this._selectedDate.changeData(date);
    this.notifyListeners();
    return;
  }
}