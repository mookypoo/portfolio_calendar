import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../provider/time_provider.dart';
import '../../repos/variables.dart';

class TimeRow extends StatefulWidget {
  TimeRow({Key? key, required this.text, required this.widget, required this.period, required this.timeProvider, required this.isExpanded}) : super(key: key);
  final String text;
  final Widget widget;
  TimeProvider timeProvider;
  bool isExpanded;
  Period period;

  @override
  State<TimeRow> createState() => _TimeRowState();
}

class _TimeRowState extends State<TimeRow> {
  ScrollController? _periodCt;
  ScrollController _hourCt = FixedExtentScrollController();

  Widget _scrollWidget({ScrollController? ct, required void Function(int i) onSelectedItemChanged, required List<Widget> children}){
    return Container(
      width: 60.0,
      height: 90.0,
      child: ListWheelScrollView.useDelegate(
        controller: ct,
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        itemExtent: 30.0,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: children,
        )),
    );
  }

  @override
  void initState() {
    this._periodCt = FixedExtentScrollController(initialItem: this.widget.period == Period.AM ? 0 : 1);
    super.initState();
  }

  @override
  void dispose() {
    this._periodCt?.dispose();
    this._hourCt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              this.widget.timeProvider.expand(this.widget.text);
            },
            child: Container(
              height: 20.0,
              width: 280.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(this.widget.text, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: MyColors.primary)),
                  this.widget.widget,
                ],
              ),
            ),
          ),
          this.widget.isExpanded ? Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.0),
                width: 290.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 60.0,
                      height: 90.0,
                      child: ListWheelScrollView.useDelegate(
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (int i) {
                            final bool _isIncrement = this._hourCt.position.userScrollDirection == ScrollDirection.reverse;
                            final bool _scrollAmPm = this.widget.text == "Starts"
                                ? this.widget.timeProvider.changeStartHour(index: i, isIncrement: _isIncrement,)
                                : this.widget.timeProvider.changeEndHour(index: i, isIncrement: _isIncrement);
                            if (_scrollAmPm) {
                              if (this.widget.period == Period.PM){
                                this._periodCt?.animateTo(this._periodCt!.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                              } else {
                                this._periodCt?.animateTo(this._periodCt!.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                              }
                            }
                          },
                          controller: this._hourCt,
                          itemExtent: 30.0,
                          childDelegate: ListWheelChildLoopingListDelegate(children: this.widget.timeProvider.hours.map<Widget>((int i) => Container(
                              alignment: Alignment.center,
                              child: Text(i.toString())
                          )).toList(),
                          )),
                    ),
                    Text(":", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),),
                    this._scrollWidget(
                      onSelectedItemChanged: (int i) => this.widget.timeProvider.changeSelectedMinute(i, this.widget.text),
                      children: this.widget.timeProvider.minuteList.map<Widget>((int i) => Container(
                        alignment: Alignment.center,
                        child: Text(i.toString().padLeft(2, "0")),
                      )).toList(),
                    )
                    Container(
                        width: 50.0,
                        height: 90.0,
                        child: ListWheelScrollView(
                          physics: FixedExtentScrollPhysics(),
                          controller: this._periodCt,
                          onSelectedItemChanged: this.widget.timeProvider.changeAmPm,
                          itemExtent: 30.0,
                          children: this.widget.timeProvider.periodList.map<Widget>((String s) => Container(
                              alignment: Alignment.center,
                              child: Text(s)
                          )).toList(),
                        )
                    ),
                  ],
                ),
              ),
              Positioned(
                width: 290.0,
                left: 0.0,
                top: 39.0,
                child: Container(
                  height: 30.0,
                  color: MyColors.secondary,
                ),
              ),
            ],
          ) : Container(),
        ],
      ),
    );
  }
}

class AddEventRow extends StatelessWidget {
  const AddEventRow({Key? key, required this.widget, required this.icon}) : super(key: key);
  final Widget widget;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this.icon,
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: this.widget,
          ),
        ],
      ),
    );
  }
}

class RepeatAllDay extends StatelessWidget {
  const RepeatAllDay({Key? key, required this.widget, required this.text}) : super(key: key);
  final Widget widget;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        height: 20.0,
        margin: const EdgeInsets.only(bottom: 25.0),
        width: 280.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(this.text, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: MyColors.primary)),
            this.widget,
          ],
        ),
      ),
    );
  }
}
