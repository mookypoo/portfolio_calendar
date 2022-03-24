import 'package:flutter/material.dart';
import 'package:portfolio_calendar/calendar_provider.dart';
import 'package:portfolio_calendar/views/main/android_components.dart';

class AndroidMain extends StatelessWidget {
  const AndroidMain({Key? key, required this.calendarProvider}) : super(key: key);
  final CalendarProvider calendarProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            leading: IconButton(
              iconSize: 28.0,
              icon: Icon(Icons.arrow_left),
              onPressed: this.calendarProvider.prevMonth,
            ),
            actions: [
              IconButton(
                iconSize: 28.0,
                icon: Icon(Icons.arrow_right),
                onPressed: this.calendarProvider.nextMonth,
              ),
            ],
            title: GestureDetector(
              onTap: () {},
              child: Text(this.calendarProvider.selectedMonth.year.toString() + ". " + this.calendarProvider.selectedMonth.month.toString().padLeft(2, "0"), style: TextStyle(fontSize: 20.0)),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height:  MediaQuery.of(context).size.height,
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CalendarTopRow(),
                      ...List.generate(this.calendarProvider.selectedMonth.weeks.length, (int index) =>
                          WeekRow(days: this.calendarProvider.selectedMonth.weeks[index], weekIndex: index, isThisMonth: this.calendarProvider.selectedMonth.isThisMonth),
                      ),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
