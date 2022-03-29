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


