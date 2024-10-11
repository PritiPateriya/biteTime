import 'dart:convert';
import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/sizedbox_common.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/database.dart';
import 'package:bitetime/model/count.dart';
import 'package:bitetime/model/data.dart';
import 'package:bitetime/screens/add_dessert.dart';
import 'package:bitetime/screens/all_meal.dart';
import 'package:bitetime/screens/dashboard.dart';
import 'package:bitetime/screens/extra_details.dart';
import 'package:bitetime/screens/information.dart';
import 'package:bitetime/screens/persionalize.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class YourOrder extends StatefulWidget {
  YourOrder({Key key}) : super(key: key);
  @override
  _YourOrderState createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {
  final dbHelper = DatabaseHelper.instance;
  ScrollController controller1 = ScrollController();
  double checkoutAmount = 0.0;
  int cellQty = 1;
  List<Car> cars = [];
  dynamic itemCont;
  dynamic email;
  var nameData = [];
  var dataId = [];
  dynamic allRows;
  dynamic data;
  bool _isSelected = true;
  bool _isLoading;
  var vid = '';
  var cid;
  var infoPrice = '';
  dynamic addressData = '';
  // var id = '';
  bool condition;
  DateTime _selectedDate;
  TextEditingController _shippingDateCon = TextEditingController();
  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: universalColor,
                  onPrimary: Colors.white,
                  surface: greenColor,
                  onSurface: universalColor,
                ),
                dialogBackgroundColor: Colors.white),
            child: child,
          );
        });
    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _shippingDateCon
        ..text = DateFormat.yMMMEd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _shippingDateCon.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  var pfinal;
  var pid;

  void _incrementCounter1(int id, String qty, String price, int idx) async {
    final result = await dbHelper.updateQtyAndPrice(
        id,
        (int.parse(qty) + 1).toString(),
        (double.parse(price) * (int.parse(qty) + 1))
            .toStringAsFixed(2)
            .toString());
    print("hiiiiiiii.......$result");
    setState(() {
      cars[idx].qty = (int.parse(cars[idx].qty) + 1).toString();
      cars[idx].totalPrice = (double.parse(price) * (int.parse(qty) + 1))
          .toStringAsFixed(2)
          .toString();
    });
    totalCheckoutPrice();
  }

  void _decrementCounter(int id, String qty, String price, int idx) async {
    if (int.parse(qty) > 1) {
      final result = await dbHelper.updateQtyAndPrice(
          id,
          (int.parse(qty) - 1).toString(),
          (double.parse(price) * (int.parse(qty) - 1))
              .toStringAsFixed(2)
              .toString());
      print("hiiiiiiii.......$result");
      setState(() {
        cars[idx].qty = (int.parse(cars[idx].qty) - 1).toString();
        cars[idx].totalPrice = (double.parse(price) * (int.parse(qty) - 1))
            .toStringAsFixed(2)
            .toString();
      });
    }
    totalCheckoutPrice();
  }

  @override
  void initState() {
    //openLocationInBrowser();
    addressData = '';
    addressLocation();
    checkoutAmount = 0.0;
    cars = [];
    cellQty = 1;
    _queryAll();
    super.initState();
  }

  void _queryAll() async {
    itemCont = await dbHelper.queryAllRows();
    print("Heri...${itemCont.length}");
    cars.clear();
    setState(() {
      itemCont.forEach((row) => cars.add(Car.fromMap(row)));
      if (itemCont != null) {
        Provider.of<Count>(context, listen: false).change(itemCont.length);
      }
    });
    totalCheckoutPrice();
  }

  // double latitude1 = 23.469894;
  // double longitude1 = 80.077253;

  LatLng _initialcameraposition = LatLng(36.139779, -86.7618456);
  GoogleMapController _controller;
  Location _location = Location();

  // openLocationInBrowser() async {
  //   if (latitude1 != null && longitude1 != null) {
  //     double lat = double.parse(latitude1.toString());
  //     double lon = double.parse(longitude1.toString());
  //     print('123456  $latitude1 , $longitude1');
  //     final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
  //     //  https://api-us.zapiet.com/v1.0/pickup/locations?page=1&limit=10&shop=getbitetime.myshopify.com
  //     if (await canLaunch(url)) {
  //       await launch(url);
  //       print("loc_url.....$url");
  //     } else {
  //       showToastMessage('Could not launch', context);
  //       throw 'Could not launch $url';
  //     }
  //   }
  // }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  List value1;
  var listt = [];
  @override
  Widget build(BuildContext context) {
    var value = context.watch<Count>().value;

    value1 = context.watch<AddMoreItems>().itemss;
    if (value1.isNotEmpty) {
      // listt.add(value1);
      CommonFunctions().console("failed");
    } else {
      CommonFunctions().console("success");
    }
    var singleChildScrollView = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("TAP NAME TO EDIT. SWIPE RIGHT TO REMOVE.",
              style: TextStyle(
                  color: Color(0xffA1A3AC),
                  fontFamily: sourceSansPro,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),
          SizedBox(
            height: FsDimens.space24,
          ),
          secondOrderDetails(),
          SizedBox(
            height: FsDimens.space10,
          ),
          addDessertsField(),
          SizedBox(
            height: FsDimens.space14,
          ),
          addMoreItemsButton(),
          SizedBox(
            height: FsDimens.space40,
          ),
        ],
      ),
    );
    return Scaffold(
        backgroundColor: Color(0xffF8F8F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => YourOrder()),
                  );
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
                        padding: const EdgeInsets.only(right: 10.0, left: 5),
                        child: Text(
                          value == null ? "0" : "$value",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                // Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashBoard()));
              }),
          title: Text(
            "Personalize",
            style: newAppbartextStyle,
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 15, left: 15),
                      child: singleChildScrollView,
                    ),
                    DottedLine(),
                    Column(
                      children: [
                        firstContainer(),
                      ],
                    )
                  ],
                ),
              ],
            ),
            _isLoading == true ? LoaderIndicator(_isLoading) : Container()
          ],
        ));
  }

  Widget firstContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        //  child: SingleChildScrollView(
        child: Column(
          children: [
            shappingSelect(),
            CommonSized(FsDimens.space28),
            _isSelected == false ? outLetPickupSelected() : Container(),
            shippingDateText(),
            CommonSized(FsDimens.space10),
            sippingDateRow(),
            CommonSized(FsDimens.space20),
            checkOutButton(),
            CommonSized(FsDimens.space20),
          ],
        ),
      ),
      // ),
    );
  }

  Widget shappingSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = true;
            });
          },
          child: Container(
              height: 120,
              width: ((45 / 100) * MediaQuery.of(context).size.width),
              decoration: _isSelected == true
                  ? greenColorDecoration
                  : blackColorDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.public,
                      color: _isSelected == true ? darkBlack : lightBlack,
                      size: 45),
                  CommonSized(FsDimens.space10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text("Shipping  ",
                        style: TextStyle(
                            color: _isSelected == true ? darkBlack : lightBlack,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            fontSize: 16)),
                  )
                ],
              )),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = false;
            });
          },
          child: Container(
              height: 120,
              width: ((45 / 100) * MediaQuery.of(context).size.width),
              decoration: _isSelected == false
                  ? greenColorDecoration
                  : blackColorDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_rounded,
                      color: _isSelected == false ? darkBlack : lightBlack,
                      size: 45),
                  CommonSized(FsDimens.space10),
                  Text("   Outlet pickup",
                      style: TextStyle(
                          color: _isSelected == false ? darkBlack : lightBlack,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          fontSize: 16))
                ],
              )),
        )
      ],
    );
  }

  Widget outLetPickupSelected() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      onTap: () {},
                      onChanged: (value) {},
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {},
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Enter your postal code...',
                          hintStyle: TextStyle(
                              fontFamily: sourceSansPro,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                          border: InputBorder.none),
                      keyboardType: TextInputType.number,
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )),
                      height: 50,
                      width: 60,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width: 2.5, color: Color(0xff0BBC6B)),
          ),
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initialcameraposition),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                compassEnabled: true,
              ),
              LoaderIndicator(_isLoading)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 10.0),
          child: Text("Please choose a pickup location, date and time:",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(width: 1.5, color: Color(0xffE0E0E0)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7, left: 10),
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: new BoxDecoration(
                        color: greenColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      // "Company name",
                      addressData['company_name'],
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: monstExtrabold,
                          color: Color(0xff044239),
                          fontWeight: FontWeight.w800),
                    ),
                    Text(addressData['address_line_1'],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                    Row(
                      children: [
                        Text(addressData['city'] + ",",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15)),
                        Text(addressData['region'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15)),
                        Text(addressData['postal_code'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15)),
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.8,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Image.asset(
                                            "assets/icons/Group Copy 3.png",
                                            height: 14,
                                            width: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  addressData['company_name'],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          monstExtrabold,
                                                      color: Color(0xff044239),
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    addressData[
                                                        'address_line_1'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15)),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      addressData['city'] + ",",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15)),
                                                  Text(addressData['region'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15)),
                                                  Text(
                                                      addressData[
                                                          'postal_code'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: FsDimens.space28,
                                          ),
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "AVAILABLE TIME",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          monstExtrabold,
                                                      color: Color(0xff044239),
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: "Mon    ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                montserratBold),
                                                        children: [
                                                      (addressData['opening_hours']
                                                                  ['monday']
                                                              ['closed'])
                                                          ? TextSpan(
                                                              text: " Closed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                          : TextSpan(
                                                              text: addressData[
                                                                              'opening_hours']
                                                                          [
                                                                          'monday']
                                                                      [
                                                                      'opens'] +
                                                                  "-" +
                                                                  addressData['opening_hours']
                                                                          [
                                                                          'monday']
                                                                      [
                                                                      'closes'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                    ])),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: "Tue     ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                montserratBold),
                                                        children: [
                                                      (addressData['opening_hours']
                                                                  ['tuesday']
                                                              ['closed'])
                                                          ? TextSpan(
                                                              text: " Closed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                          : TextSpan(
                                                              text:
                                                                  "${addressData['opening_hours']['tuesday']['opens'] + "-" + "${addressData['opening_hours']['tuesday']['closes']}"}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                    ])),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: "Wed    ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                montserratBold),
                                                        children: [
                                                      (addressData['opening_hours']
                                                                  ['wednesday']
                                                              ['closed'])
                                                          ? TextSpan(
                                                              text: " Closed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                          : TextSpan(
                                                              text:
                                                                  "${addressData['opening_hours']['wednesday']['opens'] + "-" + "${addressData['opening_hours']['wednesday']['closes']}"}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                    ])),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: "Thu     ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                montserratBold),
                                                        children: [
                                                      (addressData['opening_hours']
                                                                  ['thursday']
                                                              ['closed'])
                                                          ? TextSpan(
                                                              text: " Closed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                          : TextSpan(
                                                              text:
                                                                  "${addressData['opening_hours']['thursday']['opens'] + "-" + "${addressData['opening_hours']['thursday']['closes']}"}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                    ])),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: "Fri       ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                montserratBold),
                                                        children: [
                                                      (addressData['opening_hours']
                                                                  ['friday']
                                                              ['closed'])
                                                          ? TextSpan(
                                                              text: " Closed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                          : TextSpan(
                                                              text:
                                                                  "${addressData['opening_hours']['friday']['opens'] + "-" + "${addressData['opening_hours']['friday']['closes']}"}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                    ])),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: "Sat      ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                montserratBold),
                                                        children: [
                                                      (addressData['opening_hours']
                                                                  ['saturday']
                                                              ['closed'])
                                                          ? TextSpan(
                                                              text: " Closed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                          : TextSpan(
                                                              text:
                                                                  "${addressData['opening_hours']['saturday']['opens'] + "-" + "${addressData['opening_hours']['saturday']['closes']}"}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                    ])),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: "Sun     ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                montserratBold),
                                                        children: [
                                                      (addressData['opening_hours']
                                                                  ['sunday']
                                                              ['closed'])
                                                          ? TextSpan(
                                                              text: " Closed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                          : TextSpan(
                                                              text:
                                                                  "${addressData['opening_hours']['sunday']['opens'] + "-" + "${addressData['opening_hours']['monday']['closes']}"}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      monsterdRegular),
                                                            )
                                                    ])),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        "More information",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: monstExtrabold,
                            color: greenColor,
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          ),
        )
      ],
    );
  }

  Widget shippingDateText() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 10.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text("Select shipping date",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16)),
      ),
    );
  }

  void totalCheckoutPrice() {
    checkoutAmount = 0.0;
    for (var price in cars) {
      checkoutAmount = (checkoutAmount + double.parse(price.totalPrice));
    }
    setState(() {
      checkoutAmount = checkoutAmount;
    });
    //print("Total Checkoutr:- $checkoutAmount");
    vid = cars[0].variantId;
    print("Checkout Variants:- ${cars[0].variantId}");
  }

  Widget secondOrderDetails() {
    return cars == null
        ? Container(
            //    height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
          )
        : ListView.builder(
            controller: controller1,
            shrinkWrap: true,
            reverse: true,
            physics: ScrollPhysics(),
            itemCount: cars.length, //---------change
            itemBuilder: (ctx, index) {
              //dynamic data = cars[index].name;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Dismissible(
                  key: UniqueKey(),
                  //  key: Key(cars[index].id.toString()),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      _delete(cars[index].id);
                    });
                    showToastMessage("Remove item", context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 5, left: 16, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(width: 1.0, color: Colors.black12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              if (cars[index].productType.endsWith('Dessert')) {
                                // Desserts
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddDessert()));
                              } else if (cars[index]
                                  .productType
                                  .endsWith('Extras')) {
                                //

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ExtraDetails(
                                            extraPId: cars[index].pid,
                                            extraPImage: cars[index].image)));
                              } else {
                                editProductDetails(cars[index].pid);
                              }
                            },
                            child: Text(
                                //"${widget.title}",
                                "${cars[index].title}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: montserratBold,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                    fontSize: 18)),
                          ),
                        ),
                        SizedBox(
                          height: FsDimens.space6,
                        ),
                        Text("${cars[index].variantsTitle}",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                        SizedBox(
                          height: FsDimens.space6,
                        ),
                        setSauceString(
                            cars[index].sauce), // Text("${cars[index].sauce}"),
                        SizedBox(
                          height: FsDimens.space6,
                        ),
                        setSideString(cars[index].side),
                        SizedBox(
                          height: FsDimens.space14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _decrementCounter(
                                        cars[index].id,
                                        cars[index].qty,
                                        cars[index].variantsPrice,
                                        index);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 25,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: FsDimens.space20,
                                ),
                                Text(cars[index].qty,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                SizedBox(
                                  width: FsDimens.space20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _incrementCounter1(
                                        cars[index].id,
                                        cars[index].qty,
                                        cars[index].variantsPrice,
                                        index);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 25,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: FsDimens.space20,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Text(
                                  String.fromCharCodes(Runes(
                                    '\u0024' + "${cars[index].totalPrice}",
                                  )),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }

  Widget setSauceString(String vSauce) {
    return (vSauce.length > 0
        ? Row(
            children: [
              Text(
                String.fromCharCodes(Runes(
                  "Sauce: ",
                )),
              ),
              Text(vSauce),
            ],
          )
        : Container());
  }

  Widget setSideString(String vSide) {
    return (vSide.length > 0
        ? Container(
            child: RichText(
                text: TextSpan(
                    text: "Side : ",
                    style: TextStyle(color: Colors.black),
                    children: [TextSpan(text: vSide)])),
          )
        : Container());
  }

  Widget addDessertsField() {
    var screenSize = MediaQuery.of(context).size.width - 40;
    return Container(
      height: 55.0,
      width: MediaQuery.of(context).size.width - 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 2)),
      // ignore: deprecated_member_use
      child: RaisedButton(
          key: Key('add_photo'),
          elevation: 1.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Text(
            "Add desserts",
            style: TextStyle(
              inherit: true,
              color: Colors.black26,
              fontSize: screenSize <= 350 ? 20.0 : 22.0,
              letterSpacing: 1,
              fontFamily: sourceSansPro,
              fontWeight: FontWeight.w900,
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AddDessert()));
          }),
    );
  }

  Widget addMoreItemsButton() {
    var screenSize = MediaQuery.of(context).size.width - 40;
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Container(
        height: 55.0,
        width: MediaQuery.of(context).size.width - 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
            border: Border.all(color: Color(0xff0BBC6B), width: 2)),
        // ignore: deprecated_member_use
        child: RaisedButton(
            key: Key('add_more_items'),
            elevation: 1.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Text(
              "Add more items",
              style: TextStyle(
                inherit: true,
                color: Color(0xff0BBC6B),
                fontSize: screenSize <= 350 ? 20.0 : 22.0,
                letterSpacing: 1,
                fontFamily: sourceSansPro,
                fontWeight: FontWeight.w900,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllMealsData(condition: true)));
            }),
      ),
    );
  }

  Widget sippingDateRow() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.94,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(color: Colors.black12)),
      child: TextFormField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: _shippingDateCon,
        decoration: InputDecoration(
            hintText: "Choose a date",
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.date_range,
                  color: Colors.black,
                ),
                onPressed: () {}),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16, top: 14)),
        onTap: () {
          _selectDate(context);
        },
      ),
    );
  }

  Widget checkOutButton() {
    var screenSize = MediaQuery.of(context).size.width - 40;
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width - 25,
      // ignore: deprecated_member_use
      child: RaisedButton(
          key: Key("checkout_button"),
          elevation: 1.0,
          color: bGBottomColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Checkout",
                style: TextStyle(
                  inherit: true,
                  color: Colors.white,
                  fontSize: screenSize <= 350 ? 19.0 : 20.0,
                  letterSpacing: 1,
                  fontFamily: sourceSansPro,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                String.fromCharCodes(Runes(
                  '\u0024' + "${checkoutAmount.toStringAsFixed(2)}",
                )),
                style: TextStyle(
                  inherit: true,
                  color: Colors.white,
                  fontSize: screenSize <= 350 ? 19.0 : 20.0,
                  letterSpacing: 1,
                  fontFamily: sourceSansPro,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          onPressed: () {
            onPressCheckoutButton();
          }),
    );
  }

  void _delete(id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    setState(() {
      nameData = [];
      allRows = null;
      _counts();
      _queryAll();
    });
    CommonFunctions().console(rowsDeleted);
  }

  void _counts() async {
    itemCont = await dbHelper.queryAllRows();
    cars.clear();

    setState(() {
      itemCont.forEach((row) => cars.add(Car.fromMap(row)));

      if (itemCont != null) {
        Provider.of<Count>(context, listen: false).change(itemCont.length);
      } else {
        Provider.of<Count>(context, listen: false).change(0);
      }
    });
  }

  onPressCheckoutButton() {
    if (checkoutAmount < 20) {
      return showToastMessage("Price should be  grater than 20", context);
    } else if (_selectedDate == null) {
      return showToastMessage("Select date", context);
    } else {
      return getCheckout();
    }
  }

  getCheckout() async {
    setState(() {
      _isLoading = true;
    });
    var headers = {
      'Accept': 'application/json',
      'X-Shopify-Storefront-Access-Token': 'cda4fb2c7736fc030e88e093ed5e1aae',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic ZmNmN2MyYzI3MzAyZTk2MDVkZmM2ZmRjYmE4MjUxMjU6c2hwcGFfZjMxMTQyZTI2MGM4MmIzZjQ1ZDg1N2Q2YzI4MjgwYTY=',
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://getbitetime.myshopify.com/api/2021-04/graphql.json'));
    request.body =
        '''{"query":"mutation checkoutCreate(\$input: CheckoutCreateInput!) {\\r\\n  checkoutCreate(input: \$input) {\\r\\n    checkout {\\r\\n      id\\r\\n      webUrl\\r\\n    }\\r\\n    checkoutUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n  }\\r\\n}","variables":{"input":{"email":"Keyboard@gmail.com","lineItems":[{"variantId":"$vid","quantity":$cellQty}]}}}''';
    // var res =
    //     '''{"query":"mutation checkoutCreate(\$input: CheckoutCreateInput!) {\\r\\n  checkoutCreate(input: \$input) {\\r\\n    checkout {\\r\\n      id\\r\\n      webUrl\\r\\n    }\\r\\n    checkoutUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n  }\\r\\n}","variables":{"input":{"email":"Keyboard@gmail.com","lineItems":[{"variantId":"$vid","quantity": $cellQty }]}}}''';
    // print(res);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("Res...$response");
    if (response.statusCode == 200) {
      infoPrice = checkoutAmount.toString();
      dynamic responseJson = await response.stream.bytesToString();
      print("Checkout Responce...$responseJson");
      dynamic checkoitInitResponse = json.decode(responseJson);
      cid = checkoitInitResponse['data']['checkoutCreate']['checkout']['id'];
      print('CheckoutID $cid');
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Information(
                    informationId: cid,
                    amount: infoPrice,
                  ))); //FinalPayment()
    } else {
      print("Checkout Error...${response.reasonPhrase}");
    }
  }

  addressLocation() async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://api-us.zapiet.com/v1.0/pickup/locations?page=1&limit=10&shop=getbitetime.myshopify.com'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //  print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      dynamic addressRes = json.decode(responseJson);
      if (addressRes.length > 0) {
        addressData = addressRes['locations'];
        setState(() {
          addressData = addressData[1];
          print(addressData['opening_hours']['monday']);
        });
      }

      print("address_details...$addressRes}");
    } else {
      print(response.reasonPhrase);
    }
  }

  editProductDetails(String pID) async {
    var headers = {
      'Accept': 'application/json',
      'X-Shopify-Storefront-Access-Token': 'cda4fb2c7736fc030e88e093ed5e1aae',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://getbitetime.myshopify.com/api/2021-04/graphql.json'));
    request.body =
        '''{"query":"{\\n  node(id: \\"$pID\\") {\\n    ... on Product {\\n      id\\n      title\\n      productType\\n      description\\n      tags\\n      images(first: 10) {\\n        edges {\\n          node {\\n            id\\n            src\\n          }\\n        }\\n      }\\n      variants(first: 10) {\\n        edges {\\n          node {\\n            id\\n            price\\n            title\\n            available\\n          }\\n        }\\n      }\\n    }\\n  }\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      dynamic productData = json.decode(responseJson);
      print("product_details...${productData['data']}");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pesionalized(
                data: productData['data'],
                isFrom: true,
                isFromDB: true), //AlldataList(data:data)
          ));
    } else {
      print(response.reasonPhrase);
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
