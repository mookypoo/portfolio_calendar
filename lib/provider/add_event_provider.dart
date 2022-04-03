import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/repos/variables.dart';

class AddEventProvider with ChangeNotifier {

  String _title = "";
  String get title => this._title;
  set title(String s) => throw "error";

  Color _color = MyColors.transparent;
  Color get color => this._color;
  set color(Color c) => throw "error";

  void changeColor(Color c){
    this._color = c;
    this.notifyListeners();
    return;
  }
}