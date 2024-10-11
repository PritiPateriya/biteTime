import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/screens/dashboard.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'biteparks.dart';

class ThankYou extends StatefulWidget {
  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: FsDimens.space80,
              ),
              Image.asset(
                "assets/icons/check-mark@3x.png",
                height: 100,
                width: 100,
                color: Color(0xff00B864),
              ),
              SizedBox(
                height: FsDimens.space28,
              ),
              Text(
                "Thank you!",
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: montserratBold,
                    color: Color(0xff000A12),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: FsDimens.space40,
              ),
              Text(
                "Your order will ship on",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: monsterdRegular,
                    color: Color(0xff000A12),
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.normal),
              ),
              Text('wed,Mar 24 2021',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: montserratBold,
                      color: Color(0xff000A12),
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: FsDimens.space44,
              ),
              Text(
                "A confirmation email has been sent to",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: monsterdRegular,
                    color: Color(0xff000A12),
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                "jason@bitetime.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: montserratBold,
                    color: Color(0xff000A12),
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: FsDimens.space60,
              ),
              Text(
                "ORDER #123141551",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: monsterdRegular,
                    color: Color(0xffA2a4AD),
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: FsDimens.space32,
              ),
              submitButton(),
              SizedBox(
                height: FsDimens.space10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: GreenButton(
          key: Key('thank_you_button'),
          buttonName: "Close",
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DashBoard()));
          },
        ),
      ),
    );
  }
}
