import 'package:flutter/material.dart';
import 'package:portfolio_calendar/views/auth/android_components.dart';
import 'package:portfolio_calendar/views/auth/common_components.dart';

import '../../../provider/auth_provider.dart';

class AndroidAuth extends StatelessWidget {
  const AndroidAuth({Key? key, required this.authProvider}) : super(key: key);

  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: _size.height,
            width: _size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  height: _size.height * 0.4,
                  child: Image.network(
                    "https://www.pixelstalk.net/wp-content/uploads/2014/12/Abstract-flower-wallpaper-download-free.jpg",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: _size.height * 0.75,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              const Color.fromRGBO(255, 255, 255, 0.75),
                              const Color.fromRGBO(255, 255, 255, 1.0),
                            ],
                            begin: const Alignment(0.0, -1.0),
                            end: const Alignment(0.0, -0.7),
                          ),
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                      ),
                      Positioned(
                        top: 10.0,
                        left: 0.0,
                        right: 0.0,
                        child: Icon(
                          Icons.person,
                          size: _size.width * 0.20,
                        ),
                      ),
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        top: 10.0 + _size.width * 0.20 + 5.0,
                        child: this.authProvider.isLoginPage ? Container() : AndroidSignUpWidget(),
                      ),
                      Positioned(
                        bottom: 30.0,
                        left: 0.0,
                        right: 0.0,
                        child: Column(
                          children: <Widget>[
                            SignUpWidget(onTap: (){}) ,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text("Already Registered ?"),
                                TextButton(
                                  child: Text("Login", style: TextStyle(fontSize: 17.0),),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
