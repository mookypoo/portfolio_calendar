import 'package:flutter/widgets.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({Key? key, required this.maleIcon, required this.isMale, required this.femaleIcon}) : super(key: key);

  final IconData maleIcon;
  final IconData femaleIcon;
  final bool isMale;

  Widget _gender({required IconData icon, required bool isMale}){
    return GestureDetector(
      onTap: () {},
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
      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
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

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
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
        child: Center(
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 18.0,
              color: Color.fromRGBO(255, 255, 255, 1.0),
            ),
          ),
        ),
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
    return GestureDetector(
      onTap: this.onPressed,
      child: Stack(
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
    );
  }
}
