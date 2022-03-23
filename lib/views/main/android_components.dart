import 'package:flutter/material.dart';

class CalendarTopRow extends StatelessWidget {
  const CalendarTopRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map<Widget>((String s) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Color.fromRGBO(192, 192, 192, 1.0)),
            bottom: BorderSide(color: Color.fromRGBO(192, 192, 192, 1.0)),
          ),
        ),
        height: 45.0,
        width: MediaQuery.of(context).size.width/7,
        child: Text(s, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: s == "Sun" ? Color.fromRGBO(216, 31, 42, 1.0) : null,)),
      )).toList(),
    );
  }
}

class DateTile extends StatelessWidget {
  const DateTile({Key? key, required this.date, required this.isThisMonth}) : super(key: key);
  final int? date;
  final bool isThisMonth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          color: this.isThisMonth ? Color.fromRGBO(255, 255, 255, 1.0) : Color.fromRGBO(192, 192, 192, 0.5),
          border: Border(
            right: BorderSide(color: Color.fromRGBO(192, 192, 192, 1.0)),
            bottom: BorderSide(color: Color.fromRGBO(192, 192, 192, 1.0)),
          ),
        ),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(2.0),
        height: 85.0,
        width: MediaQuery.of(context).size.width/7,
        child: Text(this.date == null ? "" : this.date.toString(), style: TextStyle(fontSize: 16.0),),
      ),
    );
  }

}

class WeekRow extends StatelessWidget {
  const WeekRow({Key? key, required this.days, required this.index, required this.isThisMonth}) : super(key: key);
  final List<int?> days;
  final int index;
  final bool Function(int index, int date) isThisMonth;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: this.days.map<Widget>((int? i) =>
            DateTile(date: i, isThisMonth: this.isThisMonth(index, i!)),
        ).toList(),
      ),
    );
  }
}
