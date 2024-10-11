import 'package:flutter/material.dart';

import 'styles.dart';

class GreenButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final Key key;

  //passing props in react style
  GreenButton({this.buttonName, this.onPressed, this.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width - 40;
    return Container(
      height: 48.0,
      width: MediaQuery.of(context).size.width - 25,
      // ignore: deprecated_member_use
      child: RaisedButton(
          key: key,
          elevation: 1.0,
          color: bGBottomColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Text(
            buttonName,
            style: TextStyle(
              inherit: true,
              color: Colors.white,
              fontSize: screenSize <= 350 ? 19 : 20.0,
              letterSpacing: 1,
              fontFamily: sourceSansPro,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: onPressed),
    );
  }
}
