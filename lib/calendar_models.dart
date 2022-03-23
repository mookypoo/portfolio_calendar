class DateAndDayModel {
  final int date; // 날짜
  final int day; // 요일
  DateAndDayModel({required this.date, required this.day});
}

class MonthAndWeeksModel {
  final int month;
  final List<List<int?>> weeks;
  MonthAndWeeksModel({required this.month, required this.weeks});
}

/*
class MonthAndWeeksModel {
  final int month;
  List<List<int?>> weeks;
  MonthAndWeeksModel({required this.month}){
    this.weeks =
  }
}

class SelectedMonth extends MonthAndWeeksModel {


}
 */