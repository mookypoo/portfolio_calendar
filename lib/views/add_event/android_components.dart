import 'package:flutter/material.dart';

import '../../repos/variables.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key, required this.text, required this.save}) : super(key: key);
  final String text;
  final bool save;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width/2,
      child: TextButton(
        style: ButtonStyle(overlayColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.1))),
        child: Text(text, style: TextStyle(fontSize: 18.0, color: MyColors.primary),),
        onPressed: () => Navigator.of(context).pop(this.save ? true : false),
      ),
    );
  }
}

class TitleTextField extends StatelessWidget {
  const TitleTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.0),
      child: TextField(
        cursorColor: MyColors.primary,
        style: TextStyle(fontSize: 23.0),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Title",
          contentPadding: EdgeInsets.only(left: 20.0, top: 15.0, bottom: 10.0),
        ),
      ),
    );
  }
}

class TimeRow extends StatelessWidget {
  const TimeRow({Key? key, required this.text, required this.widget}) : super(key: key);
  final String text;
  final Widget widget;

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
            Text(this.text, style: Theme.of(context).textTheme.bodyText1,),
            this.widget,
          ],
        ),
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

