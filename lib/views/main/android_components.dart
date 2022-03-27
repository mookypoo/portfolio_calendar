import 'package:flutter/material.dart';

import '../../models/day_models.dart' show DateTileModel, DateModel;
import '../../repos/variables.dart' show MyColors, Today;

class CalendarTopRow extends StatelessWidget {
  const CalendarTopRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map<Widget>((String s) => Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color.fromRGBO(192, 192, 192, 1.0), width: 2.0),),
        ),
        height: 45.0,
        width: MediaQuery.of(context).size.width/7,
        child: Text(s, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: s == "Sun" ? const Color.fromRGBO(216, 31, 42, 1.0) : null,)),
      )).toList(),
    );
  }
}

class DateTile extends StatelessWidget {
  DateTile({Key? key, required this.data, required this.selectedDate, required this.onPressed}) : super(key: key);
  final DateTileModel data;
  DateModel selectedDate;
  void Function(DateTileModel date) onPressed;

  Color _dateColor({required DateTileModel data}){
    if (!data.isThisMonth()) {
      if (data.weekday == 0) return MyColors.transpRed;
      return MyColors.transpBlack;
    } else {
      if (data.weekday == 0) return MyColors.red;
      return MyColors.black;
    }
  }

  Widget _today({required DateTileModel data}){
    return Container(
      padding: EdgeInsets.all(5.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColors.primary,
      ),
      child: Text(data.date.toString(), style: TextStyle(fontSize: 15.0, color: Colors.white),),
    );
  }

  Widget _date({required DateTileModel data, required Color color}){
    return Padding(
      padding: EdgeInsets.all(4.5),
      child: Text(this.data.date.toString(), style: TextStyle(fontSize: 15.0, color: color),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.onPressed(this.data);
        print(this.data.month);
        print(this.selectedDate.month);
        print(this.selectedDate.year);
      },
      child: Container(
        decoration: BoxDecoration(
          border: this.data.isSame(date1: this.data, date2: this.selectedDate) ? Border.all(color: MyColors.primary) : null,
        ),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(2.0),
        height: 110.0,
        width: MediaQuery.of(context).size.width/7,
        child: this.data.isSame(date1: this.data, date2: Today.today)
          ? this._today(data: this.data)
          : this._date(data: this.data, color: this._dateColor(data: this.data))
      ),
    );
  }
}

