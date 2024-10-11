import 'dart:async';

import 'package:bitetime/database.dart';
import 'package:bitetime/model/count.dart';
import 'package:bitetime/model/data.dart';
import 'package:bitetime/screens/dashboard.dart';
import 'package:bitetime/strings/asset_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'slide_screens.dart';

class SplashScreenOfApp extends StatefulWidget {
  @override
  _SplashScreenOfAppState createState() => _SplashScreenOfAppState();
}

class _SplashScreenOfAppState extends State<SplashScreenOfApp> {
  final dbHelper = DatabaseHelper.instance;
  List<Car> cars = [];
  final List<String> banner = [
    'assets/images/banner-1x.png',
    'assets/images/banner-2x.png',
    'assets/images/banner-3x.png'
  ];
  dynamic itemCont;
  @override
  void initState() {
    _queryAll();
    super.initState();
    wichScreenShouldGo();
  }

  void _queryAll() async {
    itemCont = await dbHelper.queryAllRows();
    cars.clear();

    setState(() {
      itemCont.forEach((row) => cars.add(Car.fromMap(row)));

      if (itemCont != null) {
        print("itemCont--------------${itemCont.length}");
        print("itemCont1--------------$itemCont");
        Provider.of<Count>(context, listen: false).change(itemCont.length);
      }
    });
  }

  wichScreenShouldGo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool checkValue = prefs.containsKey('TOKEN');
    if (checkValue == true) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => DashBoard())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SliderScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFF00B864),
          statusBarIconBrightness: Brightness.light),
    );
    return SafeArea(
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
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                '${AssetImageOfApp.logoimage}',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * (75 / 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
