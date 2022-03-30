import 'package:flutter/material.dart';
import 'package:portfolio_calendar/views/add_event/common_components.dart' show ColorCircle;

import '../../repos/variables.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key, this.onPressed, required this.text, required this.save}) : super(key: key);
  final String text;
  final bool save;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.bg,
      height: 50.0,
      width: MediaQuery.of(context).size.width/2,
      child: TextButton(
        style: ButtonStyle(overlayColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.1))),
        child: Text(text, style: TextStyle(fontSize: 18.0, color: MyColors.primary),),
        onPressed: () {
          if (this.onPressed != null) this.onPressed!();
          Navigator.of(context).pop(this.save ? true : false);
        },
      ),
    );
  }
}

class TitleTextField extends StatelessWidget {
  TitleTextField({Key? key, required this.textCt, required this.color}) : super(key: key);
  TextEditingController textCt;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: this.textCt,
              cursorColor: MyColors.primary,
              style: TextStyle(fontSize: 23.0),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
                contentPadding: const EdgeInsets.only(left: 20.0, top: 15.0, bottom: 10.0),
              ),
            ),
          ),
          ColorCircle(color: color),
        ],
      ),
    );
  }
}

