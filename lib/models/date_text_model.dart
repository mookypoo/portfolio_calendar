import 'day_class.dart' show Day;

class DateTextModel {
  Day selectedDate;

  List<Day> listOfDates({required Day selectedDate}){
    return [

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