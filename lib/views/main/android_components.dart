import 'package:flutter/material.dart';

import '../../models/day_class.dart' show DateTileData, Day;
import '../../models/event_model.dart';
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
  DateTile({Key? key, required this.data, required this.selectedDate, required this.onPressed, required this.thisMonthEvents}) : super(key: key);
  final DateTileData data;
  Day selectedDate;
  void Function(DateTileData date) onPressed;
  List<Event> thisMonthEvents;

  Color _dateColor({required DateTileData data}){
    if (!CalendarService.isThisMonth(data: data)) {
      if (data.weekday == 0) return MyColors.transpRed;
      return MyColors.transpBlack;
    } else {
      if (data.weekday == 0) return MyColors.red;
      return MyColors.black;
    }
  }

  Widget _today({required DateTileData data,}){
    return Container(
      height: 30.0,
      width: 30.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColors.primary,
      ),
      child: Text(data.date.toString(), style: TextStyle(fontSize: 15.0, color: Colors.white),),
    );
  }

  Widget _date({required DateTileData data, required Color color}){
    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: Text(this.data.date.toString(), style: TextStyle(fontSize: 15.0, color: color),),
    );
  }

  Widget _events({required Event event}){

    return Container(
      margin: const EdgeInsets.only(top: 2.0),
      height: 35.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 3.0),
            width: 5.0,
            color: event.color,
          ),
          Expanded(child: Text(event.title, style: TextStyle(fontSize: 13.0), overflow: TextOverflow.clip,))
        ],
      ),
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
        padding: const EdgeInsets.only(top: 2.0),
        height: 110.0,
        width:  MediaQuery.of(context).size.width/7,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CalendarService.isSame(date1: this.data, date2: Today.today)
                ? this._today(data: this.data)
                : this._date(data: this.data, color: this._dateColor(data: this.data)),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: this.data.startEvents.length,
                itemBuilder: (BuildContext context, int i) => this._events(event: this.data.startEvents[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
