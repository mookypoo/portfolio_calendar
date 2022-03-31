import 'package:flutter/widgets.dart';
import 'package:portfolio_calendar/repos/variables.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({Key? key, required this.maleIcon, required this.isMale, required this.femaleIcon, required this.onSelect}) : super(key: key);

  final IconData maleIcon;
  final IconData femaleIcon;
  final bool isMale;
  final void Function(bool b) onSelect;

  Widget _gender({required IconData icon, required bool isMale}){
    return GestureDetector(
      onTap: () => this.onSelect(isMale),
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
          border: isMale ? Border.all() : null,
        ),
        child: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text("Select Gender", style: TextStyle(fontSize: 16.0,)),
          this._gender(icon: this.maleIcon, isMale: this.isMale,),
          this._gender(icon: this.femaleIcon, isMale: !this.isMale,),
        ],
      ),
    );
  }
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key, required this.onTap}) : super(key: key);

  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 40.0,
      left: 0.0,
      right: 0.0,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              await this.onTap();
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 20.0),
              padding: const EdgeInsets.all(7.0),
              width: _size.width * 0.23,
              height: _size.width * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                gradient: LinearGradient(
                  colors: <Color>[
                    const Color.fromRGBO(0, 96, 255, 1.0),
                    const Color.fromRGBO(255, 132, 188, 1.0)
                  ],
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Already Registered?   ",),
              GestureDetector(
                child: Text("Login", style: TextStyle(fontSize: 17.0, color: MyColors.primary),),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Tos extends StatelessWidget {
  Tos({Key? key, required this.iconData, required this.onPressed, required this.isChecked}) : super(key: key);
  final IconData iconData;
  final void Function() onPressed;
  bool isChecked;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: this.onPressed,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Icon(this.iconData, size: 27.0, color: this.isChecked ? Color.fromRGBO(0,0,0, 1.0) : Color.fromRGBO(255, 255, 255, 1.0)),
              Positioned(
                bottom: 5.0,
                left: 5.0,
                child: Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                ),
              ),
            ]
          ),
          Container(
            margin: const EdgeInsets.only(left: 5.0, top: 15.0),
            width: _size.width * 0.68,
            child: Text(
              "By proceeding, I agree to Mooky's Terms of Use and Conditions.",
              style: TextStyle(
                fontSize: 13.5,
                decoration: this.isChecked ? TextDecoration.underline : null,
              ),
              overflow: TextOverflow.clip,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
