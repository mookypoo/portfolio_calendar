import 'package:flutter/material.dart';
import 'package:portfolio_calendar/provider/calendar_provider.dart';
import 'package:portfolio_calendar/views/add_event/add_event_page.dart';
import 'package:portfolio_calendar/views/main/android_components.dart';

import '../../models/day_models.dart' show DateTileModel;
import '../../repos/variables.dart' show MyColors;

class AndroidMain extends StatelessWidget {
  const AndroidMain({Key? key, required this.calendarProvider}) : super(key: key);
  final CalendarProvider calendarProvider;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: MyColors.primary,
            centerTitle: true,
            leading: IconButton(
              iconSize: 28.0,
              icon: const Icon(Icons.arrow_left),
              onPressed: (){
                this.calendarProvider.prevMonth();
                print(this.calendarProvider.selectedDate.month);
                print(this.calendarProvider.selectedDate.date);
              },
            ),
            actions: [
              IconButton(
                iconSize: 28.0,
                icon: const Icon(Icons.arrow_right),
                onPressed: this.calendarProvider.nextMonth,
              ),
            ],
            title: GestureDetector(
              onTap: () {},
              child: Text(
                this.calendarProvider.textMonth + " ${this.calendarProvider.year}" ,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  color: MyColors.bg,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CalendarTopRow(),
                      ...List.generate(this.calendarProvider.weeks.length, (int weekIndex) =>
                          Row(
                            children: List.generate(7, (int dayIndex) => DateTile(
                              onPressed: this.calendarProvider.selectDate,
                              selectedDate: this.calendarProvider.selectedDate,
                              data: DateTileModel(
                                year: this.calendarProvider.year,
                                date: this.calendarProvider.weeks[weekIndex][dayIndex],
                                weekday: dayIndex,
                                month: this.calendarProvider.month,
                                weekIndex: weekIndex,
                              ),
                            ),
                          ),
                        ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primary,
        child: Icon(Icons.add),
        onPressed: () async => await Navigator.of(context).pushNamed(AddEventPage.routeName),
      ),
    );
  }
}
