import 'dart:convert';

import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/sizedbox_common.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/database.dart';
import 'package:bitetime/model/all_meal_show.dart';
import 'package:bitetime/model/color_value.dart';
import 'package:bitetime/model/count.dart';

import 'package:bitetime/screens/all_meal.dart';
import 'package:bitetime/screens/biteparks.dart';
import 'package:bitetime/screens/cart/cart_screen.dart';
import 'package:bitetime/screens/faq.dart';
import 'package:bitetime/screens/hii_jhons.dart';
import 'package:bitetime/screens/order.dart';
import 'package:bitetime/screens/preference.dart';
import 'package:bitetime/screens/profile.dart';
import 'package:bitetime/screens/your_order.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'address/address.dart';
import 'payment/payment_first_page.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  CarouselController buttonCarouselController = CarouselController();
  CarouselController imageSlindingController = CarouselController();
  DateTime backbuttonpressedTime;
  dynamic itemCont;
  final dbHelper = DatabaseHelper.instance;
  List<Card> cards = [];
  bool changeVale;
  bool allMealShow;
  double rating = 3.5;
  dynamic response;
  ScrollController controller;
  int _isSelected;
  // ignore: unused_field
  dynamic _firstSelect;

  List<String> _locations = [
    'All meals',
    'Addresses',
    //'Payment',
    'Profile',
    'Preferences',
    'Order',
    //'Biteparks'
  ];
  String _selectedLocation; // Option 2
  String _capitalize(String value) {
    return value.substring(0, 1).toUpperCase() +
        value.substring(1, value.length);
  }

  @override
  void initState() {
    getToken();

    super.initState();
  }

  getToken() async {
    allMealShow = Provider.of<AllMealChange>(context, listen: false).value;

    CommonFunctions().console(allMealShow);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var responseJson = prefs.getString('TOKEN');

    var res = json.decode(responseJson);
    print("$res");

    response = _capitalize(res['firstName']);

    setState(() {
      _locations.insert(0, "$response");
      if (allMealShow == false) {
        _selectedLocation = '$response';
        Provider.of<DashBordSelect>(context, listen: false).change(0);
      } else {
        _selectedLocation = 'All meals';
        Provider.of<DashBordSelect>(context, listen: false).change(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = context.watch<Count>().value;
    _isSelected = context.watch<DashBordSelect>().value;
    _firstSelect = context.watch<DashBordSelectString>().value;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarThem,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backwardsCompatibility: false,
              elevation: 0.5,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              title: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text(
                    '${_locations[0]}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ), // Not necessary for Option 1
                  value:
                      _selectedLocation != null ? _selectedLocation : response,

                  onChanged: (newValue) {
                    setState(() {
                      Provider.of<AllMealChange>(context, listen: false)
                          .change(false);
                      Provider.of<DashBordSelectString>(context, listen: false)
                          .changes(_selectedLocation);
                      _selectedLocation = newValue;
                    });
                  },
                  isExpanded: false,
                  icon: Icon(
                    // Add this
                    Icons.keyboard_arrow_down_sharp,
                    // Add this
                    size: 30, // Add this
                  ),
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: new Text(
                        location,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: sansBold,
//fontWeight: FontWeight.w200,
                            fontSize: 20),
                      ),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              centerTitle: true,
              actions: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(right: 10.0, top: 15, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => YourOrder()));
                    },
                    child: Container(
                      height: 29,
                      padding: EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff00be61),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 5),
                            child: Text(
                              value == null ? "0" : "$value",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            drawer: drawerr(context),
            body: WillPopScope(child: commonFunction(), onWillPop: onWillPop)),
      ),
    );
  }

  // ignore: missing_return
  Widget commonFunction() {
    CommonFunctions().console(_selectedLocation);
    if (_selectedLocation == '$response') {
      return dashBoard();
    } else if (_selectedLocation == 'All meals') {
      return alljson();
    } else if (_selectedLocation == 'Addresses') {
      return addAddress();
      // } else if (_selectedLocation == 'Payment') {
      //   return payment();
    } else if (_selectedLocation == 'Profile') {
      return Profile();
    } else if (_selectedLocation == 'Preferences') {
      return preferences();
    } else if (_selectedLocation == 'Order') {
      return order();
    }
    // else if (_selectedLocation == 'Biteperks') {
    //   return Biteparks();
    // }
  }

  Widget dashBoard() {
    return HiiJhons();
  }

  Widget alljson() {
    return AllMealsData();
  }

  Widget addAddress() {
    return Address();
  }

  Widget payment() {
    return PaymentFirst();
  }

  Widget preferences() {
    return Preference();
  }

  Widget order() {
    return OrderScreen();
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    //Statement 1 Or statement2
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      showToastMessage("Double Click to exit app", context);
      return false;
    }
    return true;
  }

  Widget drawerr(context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: new BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                    left: 0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(30, 4, 20, 4),
                            decoration:
                                _isSelected == 0 ? decoration : emptyDecoration,
                            child: Text(
                              "Dashboard",
                              style: _isSelected == 0
                                  ? drawerEmptytextStyle
                                  : drawertextStyle,
                            ),
                          ),
                          onTap: () {
                            Provider.of<DashBordSelect>(context, listen: false)
                                .change(0);
                            _selectedLocation == '$response'
                                ?
                                // ignore: unnecessary_statements
                                Navigator.of(context).pop()
                                : Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DashBoard()));
                          },
                        ),
                        CommonSized(FsDimens.space10),
                        GestureDetector(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(30, 4, 20, 4),
                              decoration: _isSelected == 1
                                  ? decoration
                                  : emptyDecoration,
                              child: Text(
                                "Meals",
                                style: _isSelected == 1
                                    ? drawerEmptytextStyle
                                    : drawertextStyle,
                              ),
                            ),
                            onTap: () {
                              Provider.of<DashBordSelect>(context,
                                      listen: false)
                                  .change(1);
                              _selectedLocation = 'All meals';
                              _selectedLocation == 'All meals'
                                  ? Navigator.of(context).pop()
                                  : Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DashBoard()));
                            }),
                        CommonSized(FsDimens.space10),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(30, 4, 20, 4),
                            decoration:
                                _isSelected == 2 ? decoration : emptyDecoration,
                            child: Text(
                              "Biteperks",
                              style: _isSelected == 2
                                  ? drawerEmptytextStyle
                                  : drawertextStyle,
                            ),
                          ),
                          onTap: () {
                            Provider.of<DashBordSelect>(context, listen: false)
                                .change(2);
                            //_selectedLocation = 'Biteperks';
                            // _selectedLocation == 'Biteperks' ?
                            //  Navigator.of(context).pop():
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Biteparks()));
                          },
                        ),
                        CommonSized(FsDimens.space10),
                        GestureDetector(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(30, 4, 20, 4),
                              decoration: _isSelected == 3
                                  ? decoration
                                  : emptyDecoration,
                              child: Text(
                                "Profile",
                                style: _isSelected == 3
                                    ? drawerEmptytextStyle
                                    : drawertextStyle,
                              ),
                            ),
                            onTap: () {
                              Provider.of<DashBordSelect>(context,
                                      listen: false)
                                  .change(3);
                              _selectedLocation = 'Profile';
                              _selectedLocation == 'Profile'
                                  ? Navigator.of(context).pop()
                                  : Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DashBoard()));
                            }),
                        CommonSized(FsDimens.space10),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(30, 4, 20, 4),
                            decoration:
                                _isSelected == 4 ? decoration : emptyDecoration,
                            child: Text(
                              "FAQs",
                              style: _isSelected == 4
                                  ? drawerEmptytextStyle
                                  : drawertextStyle,
                            ),
                          ),
                          onTap: () {
                            Provider.of<DashBordSelect>(context, listen: false)
                                .change(4);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Faq()));
                          },
                        ),
                        CommonSized(FsDimens.space10),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(30, 4, 20, 4),
                            decoration:
                                _isSelected == 5 ? decoration : emptyDecoration,
                            child: Text(
                              "Sign out",
                              style: _isSelected == 5
                                  ? drawerEmptytextStyle
                                  : drawertextStyle,
                            ),
                          ),
                          onTap: () {
                            Provider.of<DashBordSelect>(context, listen: false)
                                .change(5);
                            logOut(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Container(
                height: 130,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xFF00B864)),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.white,
                              size: 30,
                            ),
                            tooltip: 'Facebook',
                            onPressed: () async {
                              const url =
//'https://www.facebook.com/mybitetime/?_rdc=1&_rdr';
                                  ' https://www.facebook.com/';
                              if (await canLaunch(url)) {
                                await launch(url,
                                    // forceSafariVC: true,
                                    // universalLinksOnly: true,
                                    forceWebView: true);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: FsDimens.space10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xFF00B864)),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                              size: 30,
                            ),
                            tooltip: 'Instagram',
                            onPressed: () async {
                              const url = '  https://www.instagram.com/';
                              //'https://bitetime.com/collections/caribbean';
// 'https://www.sketch.com/s/c6222dd1-1f1d-49ba-ae80-2e94a0dde428/a/ygyeoqL';
                              if (await canLaunch(url)) {
                                await launch(
                                  url,
                                  forceWebView: true,
                                  //forceSafariVC: true,
                                );
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: FsDimens.space10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xFF00B864)),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.linkedinIn,
                              color: Colors.white,
                              size: 30,
                            ),
                            tooltip: 'LinkedIn',
                            onPressed: () async {
                              const url = 'https://www.linkedin.com/';
                              if (await canLaunch(url)) {
                                await launch(url,
                                    // forceSafariVC: true,
                                    // universalLinksOnly: true,
                                    forceWebView: true);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: FsDimens.space16,
                    ),
                    GestureDetector(
                      onTap: () {
                        _makingPhoneCall();
                      },
                      child: Text(
                        "18449862483",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: FsDimens.space12,
                    ),
                    GestureDetector(
                      onTap: () {
                        _makingEmailOpen();
                      },
                      child: Text(
                        "hello@bitetime.com",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _makingPhoneCall() async {
    const url = 'tel:18449862483';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingEmailOpen() async {
    const emailurl = 'mailto:${'hello123@bitetime.com'}';
    if (await canLaunch(emailurl)) {
      await launch(emailurl);
    } else {
      throw 'Could not launch $emailurl';
    }
  }
}
