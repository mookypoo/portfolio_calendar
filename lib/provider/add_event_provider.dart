import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/repos/variables.dart';

import '../models/class/user_color.dart';

class AddEventProvider with ChangeNotifier {

  AddEventProvider(this.userColors);

  List<Color> _eventColors = [
    EventColors.red, EventColors.orange, EventColors.yellow, EventColors.green, EventColors.teal,
    EventColors.aqua, EventColors.blue, EventColors.purple, EventColors.brown, EventColors.grey,
  ];
  List<Color> get eventColors => [...this._eventColors];
  set eventColors(List<Color> c) => throw "error";

  List<UserColor> userColors = [UserColor(title: "yo", color: EventColors.red, )];

  String _title = "";
  String get title => this._title;
  set title(String s) => throw "error";

  Color _color = MyColors.transparent;
  Color get color => this._color;
  set color(Color c) => throw "error";

  Color _newColor = MyColors.transparent;
  Color get newColor => this._newColor;
  set newColor(Color c) => throw "error";

  bool _isAddMode = false;
  bool get isAddMode => this._isAddMode;

  void switchMode(){
    this._isAddMode = !this._isAddMode;
    this.notifyListeners();
  }

  void changeColor(Color c){
    this._color = c;
    this.notifyListeners();
    return;
  }

  void changeNewColor(Color c){
    this._newColor = c;
    print("changing new color");
    this.notifyListeners();
    return;
  }
}