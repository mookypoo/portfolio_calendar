import 'class/day_class.dart' show week;
import 'month_model.dart' show MonthAbstract;

class SelectedMonth extends MonthAbstract {
  @override
  final int year;

  @override
  final int month;

  @override
  List<week> weekList = [];

  SelectedMonth({required this.month, required this.year}){
    this.weekList = super.weeks(month: this.month, year: this.year);
  }
}