import 'package:flutter/cupertino.dart';

import '../../class/day_class.dart';
import '../../provider/auth_provider.dart';
import '../../provider/calendar_provider.dart';
import '../../provider/user_provider.dart';
import '../../repos/enum.dart';
import '../../repos/variables.dart';
import '../add_event/add_event_page.dart';
import 'common_components.dart';

class IosMain extends StatelessWidget {
  const IosMain({Key? key, required this.calendarProvider, required this.userProvider, required this.authProvider}) : super(key: key);
  final CalendarProvider calendarProvider;
  final UserProvider userProvider;
  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: MyColors.primary,
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              padding: const EdgeInsets.only(right: 35.0),
              child: const Icon(CupertinoIcons.arrow_left, size: 28.0, color: CupertinoColors.white),
              onPressed: this.calendarProvider.prevMonth,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                this.calendarProvider.monthString + " ${this.calendarProvider.year}" ,
                style: const TextStyle(fontSize: 20.0, color: CupertinoColors.white ),
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(left: 25.0),
              child: const Icon(CupertinoIcons.arrow_right, size: 28.0, color: CupertinoColors.white),
              onPressed: this.calendarProvider.nextMonth,
            ),
          ],
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.person, size: 28.0, color: CupertinoColors.white),
          onPressed: () async {
            await this.authProvider.firebaseSignOut(userUid: this.userProvider.userUid);
            this.userProvider.changeState(ProviderState.open);
          },
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 87.0 * this.calendarProvider.weekList.length + 45.0,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) => Container(
                      height: _size.height,
                      color: MyColors.bg,
                      width: _size.width,
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
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 40.0,
                        width: _size.width,
                        color: MyColors.primary,
                        child: Text(this.calendarProvider.selectedDateText, style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0), fontWeight: FontWeight.w500, fontSize: 18.0),),
                      ),
                      Container(
                        width: _size.width,
                        color: MyColors.bg,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 10.0,
            child: CupertinoButton(
              child: const Icon(CupertinoIcons.add_circled_solid, size: 55.0, color: MyColors.primary),
              onPressed: () async => await Navigator.of(context).pushNamed(AddEventPage.routeName),
            ),
          ),
        ],
      ),
    );
  }
}
