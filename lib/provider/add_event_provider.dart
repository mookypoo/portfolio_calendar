import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/repos/variables.dart';

import '../class/user_color.dart';

enum AddEventMode {
  normal, addColor, deleteColor, addNote
}

class AddEventProvider with ChangeNotifier {
  AddEventProvider(this.userColors){
    print("add event provider init");
    this.init();
  }

  AddEventMode _addEventMode = AddEventMode.normal;
  AddEventMode get addEventMode => this._addEventMode;
  set addEventMode(AddEventMode a) => throw "error";

  List<Color> _eventColors = [
    EventColors.pink, EventColors.red, EventColors.orange, EventColors.yellow, EventColors.green, EventColors.teal,
    EventColors.blue, EventColors.purple, EventColors.brown, EventColors.grey,
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

  UserColor get newUserColor => UserColor(color: this._newColor, title: this._newTitle);

  bool _setTime = true;
  bool get setTime => this._setTime;
  set setTime(bool b) => throw "error";

  String _note = "";
  String get note => this._note;
  set note(String s) => throw "error";

  void init(){
    this.userColors.forEach((UserColor uc) {
      this._eventColors.removeWhere((Color c) => c.value == uc.color.value);
    });
  }

  void addColorMode(){
    if (this._addEventMode == AddEventMode.normal) {
      this._addEventMode = AddEventMode.addColor;
    } else {
      this._addEventMode = AddEventMode.normal;
      this._newColor = MyColors.transparent;
      this._newTitle = "";
    }
    this.notifyListeners();
  }

  void deleteMode(){
    if (this._addEventMode == AddEventMode.normal) {
      this._addEventMode = AddEventMode.deleteColor;
    } else {
      this._addEventMode = AddEventMode.normal;
    }
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
    this.init();
    this.addColorMode();
  }

  void removeColor(UserColor uc){
    this.userColors.removeWhere((UserColor c) => c.color == uc.color);
    this._eventColors.add(uc.color);
    this.deleteMode();
  }

  void onTapSetTime(bool b){
    this._setTime = !this._setTime;
    this.notifyListeners();
  }

  void addNoteMode({bool? cancel}){
    if (this._addEventMode == AddEventMode.normal) {
      this._addEventMode = AddEventMode.addNote;
    } else {
      this._addEventMode = AddEventMode.normal;
      if (cancel == true) this._note = "";
    }
    this.notifyListeners();
  }

  void saveNote(String s){
    this._note = s;
    this.addNoteMode();
  }

}