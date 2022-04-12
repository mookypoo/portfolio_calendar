import 'package:flutter/cupertino.dart';

import '../../class/day_class.dart';
import '../../provider/auth_provider.dart';
import '../../provider/calendar_provider.dart';
import '../../provider/user_provider.dart';
import '../../repos/enum.dart';
import '../../repos/variables.dart';
import 'common_components.dart';

class IosMain extends StatelessWidget {
  const IosMain({Key? key, required this.calendarProvider, required this.userProvider, required this.authProvider}) : super(key: key);
  final CalendarProvider calendarProvider;
  final UserProvider userProvider;
  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(
                child: const Icon(CupertinoIcons.arrow_left, size: 28.0),
                onPressed: this.calendarProvider.prevMonth,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  this.calendarProvider.monthString + " ${this.calendarProvider.year}" ,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
              CupertinoButton(
                child: const Icon(CupertinoIcons.arrow_right, size: 28.0),
                onPressed: this.calendarProvider.nextMonth,
              ),
            ],
          ),
          trailing: CupertinoButton(
            child: const Icon(CupertinoIcons.person, size: 28.0),
            onPressed: () async {
              await this.authProvider.firebaseSignOut(userUid: this.userProvider.userUid);
              this.userProvider.changeState(ProviderState.open);
            },
          ),
        ),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => Container(
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
          ),
        ),
      ),
    );
  }
}
