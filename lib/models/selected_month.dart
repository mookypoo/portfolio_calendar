import 'class/day_class.dart' show DateTileData;
import 'month_model.dart' show  MonthAbstract;

class SelectedMonth extends MonthAbstract {
  @override
  int year;

  @override
  int month;

  @override
  List<List<int>> weekList = [];

  SelectedMonth({required this.month, required this.year}){
    this._weekss(month: this.month, year: this.year);
  }

  void _weekss({required int month, required int year}){
    //super.weeks(month: month, year: year);
  }

  List<DateTileData> _weeks(){

  }

}