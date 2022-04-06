import 'package:flutter/material.dart';
import 'package:portfolio_calendar/views/add_event/android_components.dart';
import '../../class/user_color.dart';
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
  TextEditingController _textCt = TextEditingController();

  @override
  void initState() {

    this._periodCt = FixedExtentScrollController(initialItem: this.widget.timeProvider.startPeriod == Period.AM ? 0 : 1);
    super.initState();
  }

  @override
  void dispose() {
    this._periodCt.dispose();
    this._hourCt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: Container(
          color: MyColors.bg,
          height: _size.height,
          width: _size.width,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  padding: MediaQuery.of(context).viewPadding + EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  width: _size.width,
                  height: _size.height,
                  child: Column(
                    children: <Widget>[
                      TitleTextField(textCt: this._textCt..text = this.widget.addEventProvider.title, color: this.widget.addEventProvider.color,),
                      Container(
                        //height: 200.0,
                        child: AddEventRow(
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
                      ),
                      AddEventRow(
                        icon: Icon(Icons.label_outline, size: 28.0,),
                        widget: Column(
                          //mainAxisSize: MainAxisSize.min,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // todo addEventMode ㅇㅣㄴ 애들까리 묶고
                            !this.widget.addEventProvider.isAddMode ? Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: this.widget.addEventProvider.switchMode,
                                  child: Container(
                                    width: 130.0,
                                    child: Text("Add New Colors", style: Theme.of(context).textTheme.bodyText1,),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: this.widget.addEventProvider.editMode,
                                  child: Container(
                                    width: 130.0,
                                    child: Text("Edit", style: Theme.of(context).textTheme.bodyText1,),
                                  ),
                                ),
                              ],
                            ) : Container(
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      width: 100.0,
                                        child: Text("Cancel", style: Theme.of(context).textTheme.bodyText1,)),
                                    onTap: this.widget.addEventProvider.switchMode,
                                  ),
                                  GestureDetector(
                                    child: Text("Add", style: Theme.of(context).textTheme.bodyText1,),
                                    onTap: () {
                                      this.widget.userProvider.addColor(this.widget.addEventProvider.newUserColor);
                                      this.widget.addEventProvider.addNewColor();
                                      this.widget.addEventProvider.switchMode();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            !this.widget.addEventProvider.isAddMode
                              ? Container(
                                  width: 290,
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(top: 12.0),
                                    shrinkWrap: true,
                                    itemBuilder: (_, int index) => UserColorRow(
                                      onTapRemove: (UserColor uc) {
                                        this.widget.userProvider.removeColor(uc);
                                        this.widget.addEventProvider.removeColor(uc);
                                        this.widget.addEventProvider.isEditMode;
                                      },
                                      icon: Icons.remove,
                                      isEditMode: this.widget.addEventProvider.isEditMode,
                                      userColor: this.widget.addEventProvider.userColors[index],
                                      onTap: this.widget.addEventProvider.changeColor,
                                    ),
                                    itemCount: this.widget.addEventProvider.userColors.length,
                                    scrollDirection: Axis.vertical,
                                  ),
                                )
                              : Container(),
                          ],
                        ),
                      ),
                      this.widget.addEventProvider.isAddMode ? Container(
                        padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                        height: 130.0,
                        width: _size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    onChanged: this.widget.addEventProvider.onChangedNewTitle,
                                    cursorColor: MyColors.primary,
                                    decoration: InputDecoration(
                                      hintText: "Title",
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.primary)),
                                      contentPadding: EdgeInsets.only(bottom: 8.0, top: 10.0),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                                ColorCircle(color: this.widget.addEventProvider.newColor),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text("Available Colors", style: Theme.of(context).textTheme.bodyText1),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (_, int index) => ColorCircle(
                                  color: this.widget.addEventProvider.eventColors[index],
                                  onTap: this.widget.addEventProvider.changeNewColor,
                                ),
                                itemCount: this.widget.addEventProvider.eventColors.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ],
                        ),
                      ) : Container(),
                      AddEventRow(
                        icon: Icon(Icons.notifications_outlined, ),
                        widget: Text("Add notification",style: Theme.of(context).textTheme.bodyText1, )
                      ),
                      AddEventRow(
                          icon: Icon(Icons.notes_outlined ),
                          widget: Text("Add notes", style: Theme.of(context).textTheme.bodyText1, )
                      ),
                    ],
                  ),
                ),
              ),
              !this.widget.addEventProvider.isAddMode ? Positioned(
                bottom: 0.0,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      BottomWidget(text: "Cancel", save: false,),
                      BottomWidget(
                        onPressed: () {
                          this.widget.userProvider.addEvent(
                            color: this.widget.addEventProvider.color,
                            title: this._textCt.text,
                            startTime: this.widget.timeProvider.startData,
                            endTime: this.widget.timeProvider.endData,
                          );
                        },
                        text: "Save", save: true,
                      ),
                    ],
                  ),
                ),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

