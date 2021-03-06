import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../../class/time_model.dart' show Period;
import '../../../class/user_color.dart';
import '../../../provider/add_event_provider.dart' show AddEventMode, AddEventProvider;
import '../../../provider/time_provider.dart';
import '../../../repos/variables.dart';

class AddColorTopRow extends StatelessWidget {
  const AddColorTopRow({Key? key, required this.addEventProvider, required this.addColor}) : super(key: key);
  final AddEventProvider addEventProvider;
  final void Function(UserColor uc) addColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            child: Text("Cancel", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: MyColors.primary)),
            onTap: this.addEventProvider.addColorMode,
          ),
          GestureDetector(
            child: Text("Add", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: MyColors.primary)),
            onTap: () {
              this.addColor(this.addEventProvider.newUserColor);
              this.addEventProvider.addNewColor();
            },
          ),
        ],
      ),
    );
  }
}

class TimeRow extends StatelessWidget {
  TimeRow({Key? key, required this.text, required this.widget, required this.period, required this.timeProvider, required this.isExpanded, required this.hourCt, required this.periodCt}) : super(key: key);
  final String text;
  final Widget widget;
  final TimeProvider timeProvider;
  final bool isExpanded;
  final Period period;
  final ScrollController hourCt;
  final ScrollController periodCt;

  Widget _scrollWidget({bool isPeriod = false, ScrollController? ct, required void Function(int i) onSelectedItemChanged, required List<Widget> children}){
    return Container(
      width: 60.0,
      height: 90.0,
      child: ListWheelScrollView.useDelegate(
          controller: ct,
          physics: FixedExtentScrollPhysics(),
          onSelectedItemChanged: onSelectedItemChanged,
          itemExtent: 30.0,
          childDelegate: isPeriod ? ListWheelChildListDelegate(children: children) : ListWheelChildLoopingListDelegate(
            children: children,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => this.timeProvider.expand(this.text),
            child: Container(
              height: 20.0,
              width: 280.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(this.text, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: MyColors.primary)),
                  this.widget,
                ],
              ),
            ),
          ),
          this.isExpanded ? Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                width: 290.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    this._scrollWidget(
                      onSelectedItemChanged: (int i) {
                        final bool _isIncrement = this.hourCt.position.userScrollDirection == ScrollDirection.reverse;
                        final bool _scrollAmPm = this.text == "Starts"
                            ? this.timeProvider.changeStartHour(index: i, isIncrement: _isIncrement,)
                            : this.timeProvider.changeEndHour(index: i, isIncrement: _isIncrement);
                        if (_scrollAmPm) {
                          if (this.period == Period.PM){
                            this.periodCt.animateTo(this.periodCt.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                          } else {
                            this.periodCt.animateTo(this.periodCt.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                          }
                        }
                      },
                      children: this.timeProvider.hours.map<Widget>((int i) => Container(
                          alignment: Alignment.center,
                          child: Text(i.toString())
                      )).toList(),
                      ct: this.hourCt,
                    ),
                    Text(":", style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),),
                    this._scrollWidget(
                      onSelectedItemChanged: this.timeProvider.changeSelectedMinute,
                      children: this.timeProvider.minuteList.map<Widget>((int i) => Container(
                        alignment: Alignment.center,
                        child: Text(i.toString().padLeft(2, "0")),
                      )).toList(),
                    ),
                    this._scrollWidget(
                      isPeriod: true,
                      onSelectedItemChanged: this.timeProvider.scrollPeriod,
                      children: this.timeProvider.periodList.map<Widget>((String s) => Container(
                          alignment: Alignment.center,
                          child: Text(s)
                      )).toList(),
                      ct: this.periodCt,
                    ),
                  ],
                ),
              ),
              Positioned(
                width: 290.0,
                left: 0.0,
                top: 39.0,
                child: Container(height: 30.0, color: MyColors.secondary,),
              ),
            ],
          ) : Container(),
        ],
      ),
    );
  }
}

class ColorCircle extends StatelessWidget {
  const ColorCircle({Key? key, required this.color, this.onTap, this.isSmall = false}) : super(key: key);
  final Color color;
  final void Function(Color color)? onTap;
  final bool isSmall;

  final double large = 22.0;
  final double small = 18.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap != null ? () => this.onTap!(this.color) : null,
      child: Container(
        margin: const EdgeInsets.only(right: 22.0),
        height: this.isSmall ? small : large,
        width: this.isSmall ? small : large,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: this.color,
        ),
      ),
    );
  }
}

class UserColorRow extends StatelessWidget {
  const UserColorRow({Key? key, required this.userColor, required this.onTap, required this.onTapRemove, required this.mode, required this.icon}) : super(key: key);
  final UserColor userColor;
  final void Function(UserColor uc) onTap;
  final AddEventMode mode;
  final IconData icon;
  final void Function(UserColor userColor) onTapRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () => this.onTap(this.userColor),
          child: Container(
            width: 260.0,
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: <Widget>[
                ColorCircle(isSmall: true, color: this.userColor.color,),
                Text(this.userColor.title, style: const TextStyle(fontSize: 17.0),),
              ],
            ),
          ),
        ),
        this.mode == AddEventMode.deleteColor ? GestureDetector(
          child: Icon(icon, color: const Color.fromRGBO(0, 0, 0, 1.0),),
          onTap: () => this.onTapRemove(this.userColor),
        ) : Container(),
      ],
    );
  }
}

class CategoryRow extends StatelessWidget {
  const CategoryRow({Key? key, required this.widget, required this.icon}) : super(key: key);
  final Widget widget;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          this.icon,
          Padding(padding: const EdgeInsets.only(left: 20.0), child: this.widget,),
        ],
      ),
    );
  }
}

class RepeatNoTime extends StatelessWidget {
  const RepeatNoTime({Key? key, required this.widget, required this.text}) : super(key: key);
  final Widget widget;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
