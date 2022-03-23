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
              onPressed: () {

              },
            ),
            actions: [
              IconButton(
                iconSize: 28.0,
                icon: Icon(Icons.arrow_right),
                onPressed: () {

                },
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(2022.toString(), style: TextStyle(fontSize: 20.0)),
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                        ),
                        Container(
                          child: Text(this.calendarProvider.selectedMonth!.month.toString(), style: TextStyle(fontSize: 20.0)),
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                      CalendarTopRow(onTap: (){}),
                      ...List.generate(this.calendarProvider.selectedMonth!.weeks.length, (int index) => WeekRow(days: this.calendarProvider.selectedMonth!.weeks[index])),
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
