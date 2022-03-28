import 'package:flutter/material.dart';

import '../../models/day_class.dart' show DateTileData, Day;
import '../../repos/variables.dart' show MyColors, Today;
import '../../service/calendar_service.dart';

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
  final DateTileData data;
  Day selectedDate;
  void Function(DateTileData date) onPressed;

  Color _dateColor({required DateTileData data}){
    if (!CalendarService.isThisMonth(data: data)) {
      if (data.weekday == 0) return MyColors.transpRed;
      return MyColors.transpBlack;
    } else {
      if (data.weekday == 0) return MyColors.red;
      return MyColors.black;
    }
  }

  Widget _today({required DateTileData data}){
    return Container(
      padding: EdgeInsets.all(5.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColors.primary,
      ),
      child: Text(data.date.toString(), style: TextStyle(fontSize: 15.0, color: Colors.white),),
    );
  }

  Widget _date({required DateTileData data, required Color color}){
    return Padding(
      padding: EdgeInsets.all(4.5),
      child: Text(this.data.date.toString(), style: TextStyle(fontSize: 15.0, color: color),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onPressed(this.data),
      child: Container(
        decoration: BoxDecoration(
          border: CalendarService.isSame(date1: this.data, date2: this.selectedDate) ? Border.all(color: MyColors.primary) : null,
        ),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(2.0),
        height: 110.0,
        width: MediaQuery.of(context).size.width/7,
        child: CalendarService.isSame(date1: this.data, date2: Today.today)
          ? this._today(data: this.data)
          : this._date(data: this.data, color: this._dateColor(data: this.data))
      ),
    );
  }
}

