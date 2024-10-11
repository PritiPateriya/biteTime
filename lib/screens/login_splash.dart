import 'dart:async';

import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginSplash extends StatefulWidget {
  final dynamic data;
  LoginSplash({Key key, this.data});
  @override
  _LoginSplashState createState() => _LoginSplashState();
}

class _LoginSplashState extends State<LoginSplash> {
  dynamic response;
  @override
  void initState() {
    route();
    super.initState();
  }

  route() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashBoard())));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarthemeGreenColor,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF00B864),
                      Color(0xFF044239),
                    ],
                  )),
                ),
                Image.asset(
                  'assets/logo/BT-logo1.png',
                  height: MediaQuery.of(context).size.height - 400,
                  width: MediaQuery.of(context).size.height,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("HI\n" + "${widget.data}".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          fontFamily: monstExtrabold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/icons/welcome_img.png',
                    ),
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
