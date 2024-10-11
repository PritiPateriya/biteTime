import 'package:bitetime/model/all_meal_show.dart';
import 'package:bitetime/model/color_value.dart';
import 'package:bitetime/model/count.dart';
import 'package:bitetime/screens/splesh_screen.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Count()),
      ChangeNotifierProvider(create: (_) => AllMealChange()),
      ChangeNotifierProvider(create: (_) => DashBordSelect()),
      ChangeNotifierProvider(create: (_) => DashBordSelectString()),
      ChangeNotifierProvider(create: (_) => Quantity()),
      ChangeNotifierProvider(create: (_) => AddMoreItems()),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          highlightColor: Colors.white,
        ),
        home: SplashScreenOfApp()),
  ));
}
