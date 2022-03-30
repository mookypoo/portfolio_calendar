import 'package:flutter/material.dart';

import 'common_components.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({Key? key, this.width, this.obscureText, this.suffixIcon, this.textCt, required this.hintText}) : super(key: key);

  final bool? obscureText;
  final Widget? suffixIcon;
  final TextEditingController? textCt;
  final String hintText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
      width: this.width ?? null,
      child: TextField(
        controller: this.textCt,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 3.0),
          isDense: true,
          hintText: this.hintText,
          suffix: this.suffixIcon ?? null,
          suffixStyle: TextStyle(),
        ),
        obscureText: this.obscureText ?? false,
      ),
    );
  }
}

class AndroidSignUpWidget extends StatelessWidget {
  const AndroidSignUpWidget({Key? key}) : super(key: key);

  Widget _redEye({required void Function() onPressed}){
    return IconButton(
      constraints: BoxConstraints(maxHeight: 20.0,),
      padding: const EdgeInsets.all(0.0),
      icon: const Icon(Icons.remove_red_eye_outlined, size: 20.0),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: _size.width * 0.08),
      height: _size.height * 0.45,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              AuthTextField(
                width: _size.width * 0.42,
                hintText: "First Name",
              ),
              AuthTextField(
                width: _size.width * 0.42,
                hintText: "Last Name",
              ),
            ],
          ),
          AuthTextField(
            hintText: "Mobile",
          ),
          AuthTextField(
            hintText: "First Name",
          ),
          GenderWidget(maleIcon: Icons.male_outlined, isMale: true, femaleIcon: Icons.female_outlined),
          AuthTextField(
            hintText: "Password",
            suffixIcon: this._redEye(onPressed: (){}),
          ),
          AuthTextField(
            hintText: "Confirm Password",
            suffixIcon: this._redEye(onPressed: (){}),
          ),
          Container(
            width: _size.width * 0.79,
            margin: const EdgeInsets.all(12.0),
            child: Row(
                children: <Widget>[
                  Tos(
                    iconData: Icons.check,
                    onPressed: () {},
                    isChecked: true,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5.0, top: 10.0),
                    width: _size.width * 0.68,
                    child: const Text(
                      "By proceeding, I agree to Mooky's Terms of Use and Conditions.",
                      style: TextStyle(
                        fontSize: 12.0,
                        //decoration: this._checked ? TextDecoration.underline : null,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
}

