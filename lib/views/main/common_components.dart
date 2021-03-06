import 'package:flutter/cupertino.dart';

import '../../class/day_class.dart';
import '../../class/event_class.dart';
import '../../repos/variables.dart';
import '../../service/calendar_service.dart';

class CalendarTopRow extends StatelessWidget {
  const CalendarTopRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map<Widget>((String s) =>
        Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(
              color: Color.fromRGBO(192, 192, 192, 1.0), width: 2.0),
            ),
          ),
          height: 45.0,
          width: MediaQuery.of(context).size.width / 7,
          child: Text(s, style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: s == "Sun"
                ? const Color.fromRGBO(216, 31, 42, 1.0)
                : null,)),
        )).toList(),
    );
  }
}

class DateTile extends StatelessWidget {
  DateTile({Key? key, required this.dayIndex, required this.data, required this.selectedMonth, required this.selectedDate, required this.onPressed, required this.thisMonthEvents}) : super(key: key);
  final DateTileData data;
  DayData selectedDate;
  void Function(DateTileData date) onPressed;
  List<Event> thisMonthEvents;
  final int selectedMonth;
  final int dayIndex;

  Color _dateColor({required DateTileData data, required int dayIndex}){
    if (this.selectedMonth != data.month) {
      if (dayIndex == 0) return MyColors.transpRed;
      return MyColors.transpBlack;
    } else {
      if (dayIndex == 0) return MyColors.red;
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
      child: Text(data.date.toString(), style: TextStyle(fontSize: 15.0, color: Color.fromRGBO(255, 255, 255, 1.0)),),
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
      margin: const EdgeInsets.all(3.0),
      //height: 10.0,
      //width: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: event.color,
      ),
    );
  }

  Color? _tileColor({required DateTileData data}){
    if (this.selectedMonth != data.month) {
      return Color.fromRGBO(211, 211, 211, 0.17);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onPressed(this.data),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: CalendarService.isSame(date1: this.data, date2: this.selectedDate) ? Border.all(color: MyColors.primary) : null,
            ),
            padding: const EdgeInsets.only(top: 2.0),
            height: 87.0,
            width:  MediaQuery.of(context).size.width/7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CalendarService.isSame(date1: this.data, date2: Today.today)
                    ? this._today(data: this.data)
                    : this._date(data: this.data, color: this._dateColor(data: this.data, dayIndex: this.dayIndex)),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: this.data.events.length < 4 ? this.data.events.length : 4,
                    itemBuilder: (BuildContext context, int i) {

                      if (i == 3) return Align(
                        alignment: Alignment.center,child: Text("+ ${this.data.events.length - 3}", style: TextStyle(fontWeight: FontWeight.w500),));
                      return this._events(event: this.data.events[i]);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 25.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 87.0,
            width: MediaQuery.of(context).size.width/7,
            color: this._tileColor(data: this.data),
          ),
        ],
      ),
    );
  }
}

class TodayEventTile extends StatelessWidget {
  const TodayEventTile({Key? key, required this.event, required this.onTapEvent}) : super(key: key);
  final Event event;
  final void Function(String eventUid) onTapEvent;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        this.onTapEvent(this.event.uid);
      },
      child: Container(
        height: 60.0,
        decoration: const BoxDecoration(border: Border(
          bottom: BorderSide(color: Color.fromRGBO(192, 192, 192, 1.0)),
        )),
        width: _size.width,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              width: _size.width * 0.3,
              decoration: BoxDecoration(
                border: Border(right: BorderSide(
                  color: this.event.color,
                  width: 8.0,
                )),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(this.event.startTime.time, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),),
                  Text(this.event.endTime.time, style: TextStyle(fontSize: 15.0, color: Color.fromRGBO(114, 114, 114, 1.0))),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(this.event.title),
            ),
          ],
        ),
      ),
    );
  }
}
