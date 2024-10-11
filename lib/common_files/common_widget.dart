import 'package:bitetime/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'styles.dart';

// status bar style light color
dynamic statusBarThem = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark);
// status bar color green dark color

dynamic statusBarthemeGreenColor = SystemUiOverlayStyle(
    statusBarColor: Color(0xFF00B864),
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark);
showToastMessage(String massage, BuildContext context) {
  showToast(massage,
      context: context,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideFromTopFade,
      backgroundColor: greenColor,
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      position: StyledToastPosition(align: Alignment.topCenter, offset: 40),
      startOffset: Offset(0.0, -1.0),
      reverseEndOffset: Offset(0.0, 0.0),
      duration: Duration(seconds: 3),
      //Animation duration   animDuration * 2 <= duration
      animDuration: Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn);
}

Widget heightSpaceBetween(height) {
  return SizedBox(
    height: height,
  );
}

ProgressHUD progressHUD = ProgressHUD(
  loading: false,
  backgroundColor: Colors.black12,
  color: Colors.blue,
  containerColor: Colors.white,
  borderRadius: 5.0,
  text: 'Loading...',
);

removeTokenFromDisk() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove("TOKEN");
}

Future<void> logOut(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 23,
                color: Colors.transparent,
                child: Image.asset(
                  "assets/logo/BT-logo-black-text.png",
                  fit: BoxFit.fill,
                )),
            Text(' Logout',
                style: TextStyle(
                    color: Color(0xff242424), fontWeight: FontWeight.w500)),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Do you want to LogOut?',
                  style: TextStyle(
                      color: Color(0xff1C1C1C), fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('No', style: TextStyle(color: Color(0xff5A3C16))),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the Dialog
            },
          ),
          // ignore: deprecated_member_use
          FlatButton(
            child: Text(
              "LOGOUT",
              style: TextStyle(color: Color(0xff5A3C16)),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the Dialog
              removeTokenFromDisk();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      );
    },
  );
}

Widget buildErrors(message, field) {
  return Align(
    alignment: field == true ? Alignment.topLeft : Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: message != null
          ? field == true
              ? Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: errorColor,
                    ),
                  ),
                )
              : Text(
                  message,
                  style: TextStyle(
                    color: errorColor,
                  ),
                )
          : Container(),
    ),
  );
}
