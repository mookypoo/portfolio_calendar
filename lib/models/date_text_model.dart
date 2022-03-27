import 'day_models.dart' show DateModel;

class DateTextModel {
  DateModel selectedDate;

  List<DateModel> listOfDates({required DateModel selectedDate}){
    return [
      DateModel(
        date: selectedDate.prevDate(date: selectedDate.date, month: selectedDate.month),
        year: selectedDate.year,
        weekday: selectedDate.prevDay(day: selectedDate.weekday),
        month: selectedDate.prevMonth(month: selectedDate.month),
      ),
      DateModel(
        date: selectedDate.date,
        year: selectedDate.year,
        weekday: selectedDate.weekday,
        month: selectedDate.month,
      ),
      DateModel(
        date: selectedDate.prevDate(date: selectedDate.date, month: selectedDate.month),
        year: selectedDate.year,
        weekday: selectedDate.nextDay(day: selectedDate.weekday),
        month: selectedDate.nextMonth(month: selectedDate.month),
      ),
    ];
  }

  DateTextModel({required this.selectedDate}){

  }

  static void onScrollDown(){

  }
}

String sayHello(String name){
  final String _hello = "Hello, My name is "; // local variable
  final String _greet = ". Nice to meet you"; // local variable
  return _hello + name + _greet;
}