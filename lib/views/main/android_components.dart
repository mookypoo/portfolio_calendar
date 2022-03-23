import 'package:flutter/material.dart';

import '../../calendar_models.dart';

class CalendarTopRow extends StatelessWidget {
  const CalendarTopRow({Key? key, required this.onTap}) : super(key: key);
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        child: Row(
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
        ),
      ),
    );
  }
}

class DateTile extends StatefulWidget {
  const DateTile({Key? key, required this.date}) : super(key: key);
  final int? date;

  @override
  State<DateTile> createState() => _DateTileState();
}

class _DateTileState extends State<DateTile> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.setState(() {
          this._isSelected = !this._isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Color.fromRGBO(192, 192, 192, 1.0)),
            bottom: BorderSide(color: Color.fromRGBO(192, 192, 192, 1.0)),
          ),
        ),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(2.0),
        height: 85.0,
        width: MediaQuery.of(context).size.width/7,
        child: Text(this.widget.date == null ? "" : this.widget.date.toString(), style: TextStyle(fontSize: 16.0),),
      ),
    );
  }
}

class WeekRow extends StatelessWidget {
  const WeekRow({Key? key, required this.days}) : super(key: key);
  final List<int?> days;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: this.days.map<Widget>((int? i) => DateTile(date: i)).toList(),
      ),
    );
  }
}
