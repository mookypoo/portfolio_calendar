import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/repos/variables.dart';

import '../class/user_color.dart';

class AddEventProvider with ChangeNotifier {

  AddEventProvider(this.userColors){
    print("add event provider init");
    this.init();
  }

  List<Color> _eventColors = [
    EventColors.red, EventColors.orange, EventColors.yellow, EventColors.green, EventColors.teal,
    EventColors.aqua, EventColors.blue, EventColors.purple, EventColors.brown, EventColors.grey,
  ];
  List<Color> get eventColors => [...this._eventColors];
  set eventColors(List<Color> c) => throw "error";

  List<UserColor> userColors = [];

  String _title = "";
  String get title => this._title;
  set title(String s) => throw "error";

  String _newTitle = "";
  String get newTitle => this._newTitle;
  set newTitle(String s) => throw "error";

  Color _color = MyColors.transparent;
  Color get color => this._color;
  set color(Color c) => throw "error";

  Color _newColor = MyColors.transparent;
  Color get newColor => this._newColor;
  set newColor(Color c) => throw "error";

  bool _isAddMode = false;
  bool get isAddMode => this._isAddMode;
  set isAddMode(bool b) => throw "error";

  bool _isEditMode = false;
  bool get isEditMode => this._isEditMode;
  set isEditMode(bool b) => throw "error";

  UserColor get newUserColor => UserColor(color: this._newColor, title: this._newTitle);

  void init(){
    this.userColors.forEach((UserColor uc) {
      this._eventColors.removeWhere((Color c) => c.value == uc.color.value);
    });
  }

  void switchMode(){
    this._isAddMode = !this._isAddMode;
    this.notifyListeners();
  }

  void changeNewColor(Color c){
    this._newColor = c;
    this.notifyListeners();
  }

  void changeColor(UserColor uc){
    this._color = uc.color;
    this._title = uc.title;
    this.notifyListeners();
  }

  void onChangedNewTitle(String s) => this._newTitle = s;

  void addNewColor(){
    this.userColors.add(this.newUserColor);
    this.notifyListeners();
  }

  void removeColor(UserColor uc){
    this.userColors.removeWhere((UserColor c) => c.color == uc.color);
    this.notifyListeners();
  }

  void editMode(){
    this._isEditMode = !this._isEditMode;
    this.notifyListeners();
  }
}