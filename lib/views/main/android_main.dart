import 'package:flutter/material.dart';
import 'package:portfolio_calendar/class/day_class.dart';
import 'package:portfolio_calendar/provider/calendar_provider.dart';
import 'package:portfolio_calendar/views/add_event/add_event_page.dart';
import 'package:portfolio_calendar/views/main/android_components.dart';

import '../../provider/auth_provider.dart';
import '../../provider/user_provider.dart';
import '../../repos/enum.dart';
import '../../repos/variables.dart' show MyColors;

class AndroidMain extends StatelessWidget {
  const AndroidMain({Key? key, required this.calendarProvider, required this.userProvider, required this.authProvider}) : super(key: key);
  final CalendarProvider calendarProvider;
  final UserProvider userProvider;
  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: MyColors.primary,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  iconSize: 28.0,
                  icon: const Icon(Icons.arrow_left),
                  onPressed: this.calendarProvider.prevMonth,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    this.calendarProvider.monthString + " ${this.calendarProvider.year}" ,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                IconButton(
                  iconSize: 28.0,
                  icon: const Icon(Icons.arrow_right),
                  onPressed: this.calendarProvider.nextMonth,
                ),
              ],
            ),
            actions: [
              IconButton(
                iconSize: 28.0,
                icon: const Icon(Icons.person),
                onPressed: () async {
                  await this.authProvider.firebaseSignOut(userUid: this.userProvider.userUid);
                  this.userProvider.changeState(ProviderState.open);
                },
              ),
            ],
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
                      ...List.generate(this.calendarProvider.weekList.length, (int weekIndex) =>
                          Row(
                            children: List.generate(7, (int dayIndex) => DateTile(
                              dayIndex: dayIndex,
                              selectedMonth: this.calendarProvider.month,
                              thisMonthEvents: this.userProvider.thisMonthEvents,
                              onPressed: this.calendarProvider.selectDate,
                              selectedDate: this.calendarProvider.selectedDate,
                              data: DateTileData.withEvents(
                                data: this.calendarProvider.weekList[weekIndex][dayIndex],
                                events: this.userProvider.thisMonthEvents,
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