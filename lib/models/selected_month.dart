import 'month_model.dart' show  MonthAbstract;

class SelectedMonth extends MonthAbstract {
  @override
  int year;

  @override
  int month;

  @override
  List<List<int>> weekList = [];

  SelectedMonth({required this.month, required this.year}){
    this._weeks(month: this.month, year: this.year);
  }

  void _weeks({required int month, required int year}){
    super.weeks(month: month, year: year);
  }

}