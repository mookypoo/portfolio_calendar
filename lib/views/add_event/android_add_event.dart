import 'package:flutter/material.dart';
import 'package:portfolio_calendar/views/add_event/android_components.dart';

import '../../provider/time_provider.dart';
import '../../repos/variables.dart';
import 'common_components.dart';

class AndroidAddEvent extends StatelessWidget {
  AndroidAddEvent({Key? key, required this.timeProvider}) : super(key: key);
  final TimeProvider timeProvider;
  ScrollController _minuteCt = FixedExtentScrollController();

  final List<Color> _eventColors = [
    EventColors.orange, EventColors.green, EventColors.red, EventColors.yellow, EventColors.purple, EventColors.blue,
  ];

  Widget _colorCircle(Color color) => Container(
    margin: EdgeInsets.only(right: 22.0),
    height: 22.0,
    width: 22.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              padding: MediaQuery.of(context).viewPadding + EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              height: _size.height,
              width: _size.width,
              color: MyColors.bg,
              child: Column(
                children: <Widget>[
                  TitleTextField(),
                  AddEventRow(
                    widget: Column(
                      children: <Widget>[
                        RepeatAllDay(widget: Switch(value: false, onChanged: (bool b) {}), text: "All day"),
                        TimeRow(

                          period: this.timeProvider.startPeriod,
                          isExpanded: this.timeProvider.isStartExpanded,
                          timeProvider: this.timeProvider,
                          text: "Starts", widget: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(this.timeProvider.dateText),
                            ),
                            Text(this.timeProvider.startTime),
                          ],
                        ),),
                        TimeRow(
                          period: this.timeProvider.endPeriod,
                          isExpanded: this.timeProvider.isEndExpanded,
                          timeProvider: this.timeProvider,
                          text: "Ends", widget: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(this.timeProvider.dateText),
                            ),
                            Text(this.timeProvider.endTime),
                          ],
                        ),),
                        RepeatAllDay(
                          widget: Text("Never"),
                          text: "Repeat",
                        ),
                      ],
                    ),
                    icon: Icon(Icons.access_time),
                  ),
                  AddEventRow(
                    icon: Icon(Icons.label_outline, size: 28.0,),
                    widget: Row(
                      children: this._eventColors.map<Widget>((Color c) => this._colorCircle(c)).toList(),
                    ),
                  ),
                  AddEventRow(
                    icon: Icon(Icons.notifications_outlined, ),
                    widget: Text("Add notification",style: Theme.of(context).textTheme.bodyText1, )
                  ),
                  AddEventRow(
                      icon: Icon(Icons.location_on_outlined, ),
                      widget: Text("Add location",style: Theme.of(context).textTheme.bodyText1, )
                  ),
                  AddEventRow(
                      icon: Icon(Icons.notes_outlined ),
                      widget: Text("Add notes", style: Theme.of(context).textTheme.bodyText1, )
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Row(
                children: <Widget>[
                  BottomWidget(text: "Cancel", save: false,),
                  BottomWidget(text: "Save", save: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

