import 'package:flutter/material.dart';
import 'package:portfolio_calendar/views/add_event/android_components.dart';
import '../../class/event_class.dart';
import '../../provider/add_event_provider.dart';
import '../../provider/time_provider.dart';
import '../../provider/user_provider.dart';
import '../../repos/variables.dart' show MyColors;
import 'common_components.dart';
import '../../class/time_model.dart' show Period;

class AndroidAddEvent extends StatefulWidget {
  AndroidAddEvent({Key? key, required this.addEventProvider, required this.timeProvider, required this.userProvider}) : super(key: key);
  final TimeProvider timeProvider;
  final UserProvider userProvider;
  final AddEventProvider addEventProvider;

  @override
  State<AndroidAddEvent> createState() => _AndroidAddEventState();
}

class _AndroidAddEventState extends State<AndroidAddEvent> {
  ScrollController _hourCt = FixedExtentScrollController();
  ScrollController _periodCt = FixedExtentScrollController();
  TextEditingController _titleCt = TextEditingController();
  TextEditingController _noteCt = TextEditingController();

  @override
  void initState() {
    this._periodCt = FixedExtentScrollController(initialItem: this.widget.timeProvider.startPeriod == Period.AM ? 0 : 1);
    super.initState();
  }

  @override
  void dispose() {
    <ChangeNotifier>[this._hourCt, this._titleCt, this._periodCt, this._noteCt].forEach((ChangeNotifier cn) => cn.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                color: MyColors.bg,
                padding: MediaQuery.of(context).viewPadding + EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                width: _size.width,
                height: _size.height,
                child: Column(
                  children: <Widget>[
                    TitleTextField(textCt: this._titleCt..text = this.widget.addEventProvider.title, color: this.widget.addEventProvider.color,),
                    CategoryRow(
                      widget: Column(
                        children: <Widget>[
                          RepeatAllDay(widget: Switch(value: false, onChanged: (bool b) {}), text: "All day"),
                          TimeRow(
                            hourCt: this._hourCt,
                            periodCt: this._periodCt,
                            period: this.widget.timeProvider.startPeriod,
                            isExpanded: this.widget.timeProvider.isStartExpanded,
                            timeProvider: this.widget.timeProvider,
                            text: "Starts",
                            widget: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(this.widget.timeProvider.dateText),
                                ),
                                Text(this.widget.timeProvider.startTime),
                              ],
                            ),
                          ),
                          TimeRow(
                            hourCt: this._hourCt,
                            periodCt: this._periodCt,
                            period: this.widget.timeProvider.endPeriod,
                            isExpanded: this.widget.timeProvider.isEndExpanded,
                            timeProvider: this.widget.timeProvider,
                            text: "Ends",
                            widget: Text(this.widget.timeProvider.endTime),
                          ),
                          RepeatAllDay(
                            widget: Text("Never"),
                            text: "Repeat",
                          ),
                        ],
                      ),
                      icon: Icon(Icons.access_time),
                    ),
                    CategoryRow(
                      icon: Icon(Icons.label_outline, size: 28.0,),
                      widget: this.widget.addEventProvider.addEventMode == AddEventMode.addColor
                        ? AddColorTopRow(addEventProvider: this.widget.addEventProvider, addColor: this.widget.userProvider.addColor)
                        : ColorTopRow(addEventProvider: this.widget.addEventProvider, removeColor: this.widget.userProvider.removeColor)
                    ),
                    this.widget.addEventProvider.addEventMode == AddEventMode.addColor ? AddColorWidget(addEventProvider: this.widget.addEventProvider) : Container(),
                    CategoryRow(
                      icon: Icon(Icons.notifications_outlined, ),
                      widget: AddNotification(),
                    ),
                    CategoryRow(
                      icon: Icon(Icons.notes_outlined ),
                      widget: AddNotes(addEventProvider: this.widget.addEventProvider, ct: this._noteCt),
                    ),
                  ],
                ),
              ),
            ),
            this.widget.addEventProvider.addEventMode == AddEventMode.normal ? Positioned(
              bottom: 0.0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    BottomWidget(text: "Cancel", save: false,),
                    BottomWidget(
                      onPressed: () {
                        this.widget.userProvider.addEvent(Event(
                          day: this.widget.timeProvider.day,
                          color: this.widget.addEventProvider.color,
                          title: this.widget.addEventProvider.title,
                          endTime: this.widget.timeProvider.endData,
                          startTime: this.widget.timeProvider.startData,
                          notes: this.widget.addEventProvider.note,
                        ));
                      },
                      text: "Save Event", save: true,
                    ),
                  ],
                ),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}

