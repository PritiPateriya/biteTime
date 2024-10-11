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
import 'package:bitetime/screens/rating_star.dart';
import 'package:bitetime/screens/your_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'write_review/review.dart';

class Pesionalized extends StatefulWidget {
  final dynamic data;
  final bool isFrom;
  final bool isFromDB;
  final String name;

  Pesionalized({Key key, this.data, this.isFrom, this.name, this.isFromDB})
      : super(key: key);

  @override
  _PesionalizedState createState() => _PesionalizedState();
}

var quntity;
int counts;

class _PesionalizedState extends State<Pesionalized> {
  String vBreadTitle = 'Android';
  final dbHelper = DatabaseHelper.instance;
  var values = [];
  List<String> selectedSides = [];
  List<Car> cars = [];
  Map<String, dynamic> variants;
  Map<String, dynamic> img;
  Map<String, dynamic> twoP;
  Map<String, dynamic> fourP;
  Map<String, dynamic> sixP;
  var sideStr = '';
  bool isFromDB = false;
  dynamic sauceList = '';
  dynamic sideList = '';
  dynamic extraList = '';

  var sauceSelectedValue = '';
  var sideDBStr = '';
  var sideSelectedValue = '';
  var extraType = '';
  bool sideSelected = false;
  dynamic extraProduct;
  dynamic productTypeCollection;
  bool _isLoading;
  dynamic extraOneProduct = '';
  dynamic extraTwoProduct = '';
  dynamic itemCont;
  double rating = 0.0;
  dynamic review = '';
  dynamic ratingPId = '';
  int selecteVarient = 1;
  int selecteVarient_t = 4;
  String varientPrice = '';
  String totalProductPrice = '';
  int qtyCount = 0;

  int breadOneSelect = 0;
  int breadOneSelectPrice = 0;
  int breadTwoSelect = 0;

  var extrasP = [];
////radio button
  int initSelect = 1;
  String _radioButton = " ";
  bool radioButtonshow = false;
  var object = [];
  ////====vagitable
  int vegeOneSelect = 0;
  int vegeTwoSelect = 0;
  int vegeThreeSelect = 0;
  int vegeFourSelect = 0;
  int vegeFiveSelect = 0;
  dynamic selectVegeOne = '';
  dynamic selectVegeTwo = '';
  dynamic selectVegeThree = '';
  dynamic selectVegeFour = '';
  dynamic selectVegeFive = '';

  /////radio button
  bool monVal;
  bool value = false;
  bool value1 = false;
  dynamic items;
  bool _isNavigation;
  dynamic newText;
  var totalPrice;

  dynamic selcted;
  String selectedCountry;
  var prices;
  var pfinal = 0.0;
  var suffixtype;
  var lacalTagdat = [];
  var sendData;

  int _count = 1;
  dynamic allCount;

  @override
  initState() {
    sauceList = '';
    sideList = '';
    extraList = '';
    rating = 0.0;
    review = '';
    ratingPId = '';
    sauceSelectedValue = '';
    sideSelectedValue = '';
    sideSelected = false;
    extraType = '';
    varientPrice = '';
    sideDBStr = '';
    vBreadTitle = 'Android';
    _count = 1;

    // print(Review.reviewRatingData[0]['product']['productTitle']);
    _queryAll();
    items = widget.data;
    isFromDB = widget.isFromDB;
    CommonFunctions().console(widget.data);
    print("EDIT Profiles...{${items.toString()}}");
    dynamic editPro = widget.data['node'];
    print("KKK...{$editPro}");
    dataResponeGet();
    _radioButton = String.fromCharCode(initSelect);
    addExtras();
    collectionDataStaic();
    setDataFromDB();
    updateReviewRating();
    super.initState();
  }

  setDataFromDB() {
    setState(() {
      sauceSelectedValue = '';
    });
    print('IS_IN_DB...$isFromDB');
  }

  dataResponeGet() {
    for (final list in items['node']['tags']) {
      if (list == 'new') {
        newText = list;
      } else {
        lacalTagdat.add(list);
      }
    }
    print("PPP...{$items}");
    img = items['node']['images']['edges'][0];
    // print("${img['node']['src']}");

    for (final variantsData in items['node']['variants']['edges']) {
      print("########################" + variantsData.toString());
      if (variantsData['node']['title'] == '2' ||
          variantsData['node']['title'] == '4' ||
          variantsData['node']['title'] == '6') {
        if (variantsData['node']['title'] == '2') {
          twoP = variantsData['node'];
        } else if (variantsData['node']['title'] == '4') {
          fourP = variantsData['node'];
        } else if (variantsData['node']['title'] == '6') {
          sixP = variantsData['node'];
        }
      } else {
        setState(() {
          radioButtonshow = true;
          dynamic tmpPriceList = items['node']['variants']['edges'];
          suffixtype = tmpPriceList[0]['node']['title'];
          prices = tmpPriceList[0]['node']['price'];
          if (tmpPriceList != null && tmpPriceList.length > 0) {
            values = List.from(tmpPriceList);
          }
          CommonFunctions().console(items['node']['variants']['edges']);
        });
      }
    }
    print(" Priri +$items");
  }

  void _queryAll() async {
    itemCont = await dbHelper.queryAllRows();
    cars.clear();
    setState(() {
      itemCont.forEach((row) => cars.add(Car.fromMap(row)));
    });
  }

  void _decrementCounter() {
    if (_count > 1) {
      setState(() {
        _count--;
      });
      CommonFunctions().console(_count);
    }
  }

  void _incrementCounter() {
    setState(() {
      _count++;
    });
    CommonFunctions().console(_count);
  }

  var quant;

  List<Widget> selectSauceRadio() {
    List<Widget> widget = [];
    for (var sauceItem in sauceList) {
      widget.add(RadioListTile(
        value: sauceItem['item'],
        //  dense: true,
        dense: true,
        selected: true,
        groupValue: sauceSelectedValue,
        title: Align(
          alignment: Alignment(-1.20, 0),
          child: Text(sauceItem['item'],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: sourceSansPro,
                  color: darkBlack)),
        ),
        // selectedTileColor: Colors.white,
        activeColor: greenColor,

        onChanged: (curentSauce) {
          setState(() {
            sauceSelectedValue = curentSauce;
            print("selected_sauce...$sauceSelectedValue");
          });
        },
        //   selected: sauceSelectedValue == sauceItem['item'],
      ));
    }
    return widget;
  }
  /////------------Sauce End---------

/////------------Side Start---------

  /////------------Side Start---------

  @override
  Widget build(BuildContext context) {
    var value = context.watch<Count>().value;
    quant = context.watch<Quantity>().quantity;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
    );

    CommonFunctions().console(jsonEncode(quant));
    // CommonFunctions().console(prices);
    return Scaffold(appBar: appBar(value), body: bodyScreen());
  }

  Widget bodyScreen() {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(child: imageView()),
                          titleWidget(),
                          starRatingWidget(),
                          discriptionWidget(),
                          tagesList(),
                          SizedBox(
                            height: 3,
                          ),
                          priceWidget(),
                          CommonSized(10),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "how many portions?".toUpperCase(),
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: monstExtrabold,
                            color: Color(0xff044239),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      CommonWidth(10),
                      GestureDetector(
                        onTap: () {
                          selecteVarient = 0;
                          selecteVarient_t = 2;
                          varientPrice = items['node']['variants']['edges'][0]
                              ['node']['price'];
                          // varientTotalPrice = double.parse(items['node']
                          //     ['variants']['edges'][0]['node']['price']);
                          //   "${double.parse(variants['node']['price']) / 2}"
                          setState(() {
                            _count = 1;
                          });
                          priceWidget();
                          setState(() {
                            initSelect = 0;
                            _radioButton = "2";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                              color:
                                  initSelect == 0 ? greenColor : Colors.white,
                              border: Border.all(
                                  color: initSelect == 0
                                      ? greenColor
                                      : Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                //  "$suffixtype" + "$prices",
                                items['node']['variants']['edges'][0]['node']
                                    ['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: sourceSansPro,
                                    color: initSelect == 0
                                        ? Colors.white
                                        : darkBlack,
                                    fontSize: 20)),
                          ),
                        ),
                      ),
                      CommonWidth(10),
                      GestureDetector(
                        onTap: () {
                          selecteVarient = 1;
                          selecteVarient_t = 4;
                          varientPrice = items['node']['variants']['edges'][1]
                              ['node']['price'];
                          setState(() {
                            _count = 1;
                          });
                          priceWidget();
                          setState(() {
                            initSelect = 1;
                            _radioButton = "4";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                              color:
                                  initSelect == 1 ? greenColor : Colors.white,
                              border: Border.all(
                                  color: initSelect == 1
                                      ? greenColor
                                      : Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                //"$suffixtype[1]" + "$prices",
                                items['node']['variants']['edges'][1]['node']
                                    ['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: sourceSansPro,
                                    color: initSelect == 1
                                        ? Colors.white
                                        : darkBlack,
                                    fontSize: 22)),
                          ),
                        ),
                      ),
                      CommonWidth(10),
                      GestureDetector(
                        onTap: () {
                          // variants = items['node']['variants']['edges'][2]
                          //     ['node']['price'];
                          selecteVarient = 2;
                          selecteVarient_t = 6;
                          varientPrice = items['node']['variants']['edges'][2]
                              ['node']['price'];
                          setState(() {
                            _count = 1;
                          });
                          priceWidget();
                          setState(() {
                            initSelect = 2;
                            _radioButton = "6";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                              color:
                                  initSelect == 2 ? greenColor : Colors.white,
                              border: Border.all(
                                  color: initSelect == 2
                                      ? greenColor
                                      : Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                //"$suffixtype[2]" + "$prices",
                                items['node']['variants']['edges'][2]['node']
                                    ['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: sourceSansPro,
                                    color: initSelect == 2
                                        ? Colors.white
                                        : darkBlack,
                                    fontSize: 20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  souceProduct(),
                  twoSideProductCheckbox(),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //       child: Column(
                  //     children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       if (vegeOneSelect == 0) {
                  //         vegeOneSelect = 1;
                  //       } else {
                  //         vegeOneSelect = 0;
                  //         selectVegeOne = '';
                  //         // addToOrderButton(-10);
                  //       }
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.only(left: 10),
                  //     alignment: Alignment.centerLeft,
                  //     width: double.infinity,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         color: vegeOneSelect == 0
                  //             ? greenColor
                  //             : Colors.white,
                  //         border: Border.all(
                  //             color: vegeOneSelect == 0
                  //                 ? greenColor
                  //                 : Colors.grey),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Text("Balsamic vagetable",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontFamily: sourceSansPro,
                  //             color: vegeOneSelect == 0
                  //                 ? Colors.white
                  //                 : darkBlack,
                  //             fontSize: 19)),
                  //   ),
                  // ),
                  // CommonSized(10),
                  // // CommonWidth(10),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       if (vegeTwoSelect == 0) {
                  //         vegeTwoSelect = 1;
                  //       } else {
                  //         vegeTwoSelect = 0;
                  //         selectVegeTwo = '';
                  //         // addToOrderButton(-10);
                  //       }
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.only(left: 10),
                  //     alignment: Alignment.centerLeft,
                  //     width: double.infinity,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         color: vegeTwoSelect == 0
                  //             ? greenColor
                  //             : Colors.white,
                  //         border: Border.all(
                  //             color: vegeTwoSelect == 0
                  //                 ? greenColor
                  //                 : Colors.grey),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Text("Roasted garlic broccoli",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontFamily: sourceSansPro,
                  //             color: vegeTwoSelect == 0
                  //                 ? Colors.white
                  //                 : darkBlack,
                  //             fontSize: 19)),
                  //   ),
                  // ),
                  // CommonSized(10),

                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       if (vegeThreeSelect == 0) {
                  //         vegeThreeSelect = 1;
                  //       } else {
                  //         vegeThreeSelect = 0;
                  //         selectVegeThree = '';
                  //         // addToOrderButton(-10);
                  //       }
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.only(left: 10),
                  //     alignment: Alignment.centerLeft,
                  //     width: double.infinity,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         color: vegeThreeSelect == 0
                  //             ? greenColor
                  //             : Colors.white,
                  //         border: Border.all(
                  //             color: vegeThreeSelect == 0
                  //                 ? greenColor
                  //                 : Colors.grey),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Text("Roasted garlic broccoli",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontFamily: sourceSansPro,
                  //             color: vegeThreeSelect == 0
                  //                 ? Colors.white
                  //                 : darkBlack,
                  //             fontSize: 19)),
                  //   ),
                  // ),
                  // CommonSized(10),
                  // // CommonWidth(10),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       if (vegeFourSelect == 0) {
                  //         vegeFourSelect = 1;
                  //       } else {
                  //         vegeFourSelect = 0;
                  //         selectVegeFour = '';
                  //         // addToOrderButton(-10);
                  //       }
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.only(left: 10),
                  //     alignment: Alignment.centerLeft,
                  //     width: double.infinity,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         color: vegeFourSelect == 0
                  //             ? greenColor
                  //             : Colors.white,
                  //         border: Border.all(
                  //             color: vegeFourSelect == 0
                  //                 ? greenColor
                  //                 : Colors.grey),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Text("Roasted garlic broccoli",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontFamily: sourceSansPro,
                  //             color: vegeFourSelect == 0
                  //                 ? Colors.white
                  //                 : darkBlack,
                  //             fontSize: 19)),
                  //   ),
                  // ),
                  // CommonSized(10),
                  // // CommonWidth(10),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       if (vegeFiveSelect == 0) {
                  //         vegeFiveSelect = 1;
                  //       } else {
                  //         vegeFiveSelect = 0;
                  //         selectVegeFive = '';
                  //         // addToOrderButton(-10);
                  //       }
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.only(left: 10),
                  //     alignment: Alignment.centerLeft,
                  //     width: double.infinity,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         color: vegeFiveSelect == 0
                  //             ? greenColor
                  //             : Colors.white,
                  //         border: Border.all(
                  //             color: vegeFiveSelect == 0
                  //                 ? greenColor
                  //                 : Colors.grey),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Text("Roasted garlic broccoli",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontFamily: sourceSansPro,
                  //             color: vegeFiveSelect == 0
                  //                 ? Colors.white
                  //                 : darkBlack,
                  //             fontSize: 19)),
                  //   ),
                  // ),
                  //     ],
                  //   )),
                  // ),

                  bread(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Quantity".toUpperCase(),
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: monstExtrabold,
                            color: Color(0xff044239),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  commonCountSelect(),
                  addToOrderButton(0)
                ],
              ),
            ),
          ),
          _isNavigation == true ? LoaderIndicator(_isNavigation) : Container()
        ],
      ),
    );
  }

  Widget souceProduct() {
    return ((sauceList.length > 0)
        ? Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 25, 8, 0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "SELECT A SAUCE *".toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: monstExtrabold,
                          color: Color(0xff044239),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white),
                      child: Column(
                        children: selectSauceRadio(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container());
  }

  Widget twoSideProductCheckbox() {
    return ((sideList.length > 0)
        ? Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 15, 8, 0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "SELECT TWO SIDE *".toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: monstExtrabold,
                          color: Color(0xff044239),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white),
                      child: Column(
                        children: selectSideCheck(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container());
  }

  List<Widget> selectSideCheck() {
    List<Widget> widget = [];
    for (var i = 0; i < sideList.length; i++) {
      //  sideSelected = _isChecked[i];
      widget.add(CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: sideList[i]['checked'],
        dense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        title: Align(
          alignment: Alignment(-1.30, -10),
          child: Text(sideList[i]['item'],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: sourceSansPro,
                  color: darkBlack)),
        ),
        activeColor: greenColor,
        onChanged: (bool curentSide) {
          print("selected_item...$curentSide");
          setState(() {
            sideList[i]['checked'] = curentSide;
            selectedSides = [];
            for (var i = 0; i < sideList.length; i++) {
              if (sideList[i]['checked']) {
                selectedSides.add(sideList[i]['item']);
              }
            }
            sideStr = selectedSides.join(',');
            print("OKAY...${sideStr.toString()}");
          });
        },
      ));
    }
    return widget;
  }

  Widget bread() {
    return ((extraList.length > 0)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                //addExtras() == null
                Container(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "add Extras".toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: monstExtrabold,
                          color: Color(0xff044239),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (breadOneSelect == 0) {
                        breadOneSelect = 1;
                        if (extraType.contains('cornbread')) {
                          extraOneProduct = extraProduct[1];
                        } else {
                          extraOneProduct = extraProduct[0];
                        }
                      } else {
                        breadOneSelect = 0;
                        extraOneProduct = '';
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: breadOneSelect == 0 ? Colors.white : greenColor,
                        border: Border.all(
                            color:
                                breadOneSelect == 0 ? Colors.grey : greenColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            (extraProduct == null
                                ? ''
                                : (extraType.contains('cornbread')
                                    ? extraProduct[1]['title'].toString()
                                    : extraProduct[0]['title'].toString())),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: sourceSansPro,
                                color: breadOneSelect == 0
                                    ? darkBlack
                                    : Colors.white,
                                fontSize: 19)),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                              "\u0024" +
                                  (extraProduct == null
                                      ? ''
                                      : (extraType.contains('cornbread')
                                          ? extraProduct[1]['variants'][0]
                                                  ['price']
                                              .toString()
                                          : extraProduct[0]['variants'][0]
                                                  ['price']
                                              .toString())),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: sourceSansPro,
                                  color: breadOneSelect == 0
                                      ? darkBlack
                                      : Colors.white,
                                  fontSize: 19)),
                        ),
                      ],
                    ),
                  ),
                ),
                CommonSized(10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (breadTwoSelect == 0) {
                        breadTwoSelect = 1;
                        if (extraType.contains('cornbread')) {
                          extraOneProduct = extraProduct[3];
                        } else {
                          extraTwoProduct = extraProduct[2];
                        }
                      } else {
                        breadTwoSelect = 0;
                        extraTwoProduct = '';
                      }
                      addToOrderButton(10);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: breadTwoSelect == 0 ? Colors.white : greenColor,
                        border: Border.all(
                            color:
                                breadTwoSelect == 0 ? Colors.grey : greenColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            (extraProduct == null
                                ? ''
                                : (extraType.contains('cornbread')
                                    ? extraProduct[3]['title'].toString()
                                    : extraProduct[2]['title'].toString())),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: sourceSansPro,
                                color: breadTwoSelect == 0
                                    ? darkBlack
                                    : Colors.white,
                                fontSize: 19)),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                              "\u0024" +
                                  (extraProduct == null
                                      ? ''
                                      : (extraType.contains('cornbread')
                                          ? extraProduct[3]['variants'][0]
                                                  ['price']
                                              .toString()
                                          : extraProduct[2]['variants'][0]
                                                  ['price']
                                              .toString())),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: sourceSansPro,
                                  color: breadTwoSelect == 0
                                      ? darkBlack
                                      : Colors.white,
                                  fontSize: 19)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )))
        : Container());
  }

  Widget imageView() {
    // print("${img['node']['src']}");
    return Stack(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(0.1),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                "${img['node']['src']}",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: newText == null
                ? Container()
                : Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE2B981),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 4, bottom: 4),
                        child: Text("$newText".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10)),
                      ),
                    ),
                  ))
      ],
    );
  }

  Widget titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 4),
        child: Text(
          "${items['node']['title']}".toUpperCase(),

          // + " "+ "${items['node']['productType']}",
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              letterSpacing: 0.5,
              fontFamily: montserratBold,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget starRatingWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
      child: GestureDetector(
        onTap: () {
          print('RatingID...$ratingPId');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Reviews(ratingPId: ratingPId)));
        },
        child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                StarRating(
                  starCount: 5,
                  color: greenColor,
                  rating: rating,
                ),
                Container(
                  child: Text("$review".toString() + " " + "reviews",
                      style: TextStyle(
                          fontFamily: sourceSansPro,
                          color: Color(0xff4A4A4C),
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                )
              ],
            )),
      ),
    );
  }

  Widget discriptionWidget() {
    print("${items['node']['description']}");
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text("${items['node']['description'.toString()]}",
            style: TextStyle(fontFamily: monsterdRegular, fontSize: 12)),
      ),
    );
  }

  Widget priceWidget() {
    varientPrice =
        items['node']['variants']['edges'][selecteVarient]['node']['price'];
    CommonFunctions().console(prices);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            child: Text(
              "\u0024${(double.parse(items['node']['variants']['edges'][selecteVarient]['node']['price']) / (selecteVarient_t)).toStringAsFixed(2)}/plate",
              //"${double.parse(variants['node']['price']) / 2}",
              // String.fromCharCodes(new Runes(
              //     '\u0024' + "${double.parse(variants['node']['price']) / 4}")),
              style: TextStyle(
                fontFamily: monsterdRegular,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CommonWidth(18),
          //   radioButtonshow == true
          Container(
            decoration: BoxDecoration(
                color: Color(0xffE2B981),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      String.fromCharCodes(new Runes('\u0024')),
                      style: TextStyle(
                        fontFamily: monsterdRegular,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${double.parse(items['node']['variants']['edges'][selecteVarient]['node']['price'])}/plate",
                      //"$prices" + "$suffixtype",
                      // items['node']['variants']['edges'][1]['node']
                      //     ['price'],
                      style: TextStyle(
                        fontFamily: monsterdRegular,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  addToOrderButton(int extraItem) {
    totalProductPrice = (double.parse(items['node']['variants']['edges']
                [selecteVarient]['node']['price']) *
            _count)
        .toStringAsFixed(2)
        .toString();
    print(extraItem);
    return Column(
      children: [
        CommonSized(20),
        InkWell(
          onTap: () => {navigationToCheckOut()},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                  color: greenColor, borderRadius: BorderRadius.circular(27)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "Add to order",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: sourceSansPro,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              String.fromCharCodes(new Runes('\u0024')),
                              style: TextStyle(
                                fontFamily: monsterdRegular,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              totalPrice = ((double.parse(items['node']
                                                      ['variants']['edges']
                                                  [selecteVarient]['node']
                                              ['price']) *
                                          _count) +
                                      ((extraOneProduct.toString().length > 0)
                                          ? double.parse(
                                              extraOneProduct['variants'][0]
                                                  ['price'])
                                          : 0) +
                                      ((extraTwoProduct.toString().length > 0)
                                          ? double.parse(
                                              extraTwoProduct['variants'][0]['price'])
                                          : 0)
                                  //  + addEXtraprices
                                  )
                                  .toStringAsFixed(2)
                                  .toString(),
                              //String.fromCharCodes(new Runes('$varientPrice')),
                              // "$varientPrice",
                              //      double.parse(varientPrice).toString(),
                              //  varientPrice.toString(),
                              //varientTotalPrice,
                              // pfinal == null
                              //     ? '0'
                              //     : '$varientPrice', //varientPrice
                              style: TextStyle(
                                fontFamily: monsterdRegular,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        CommonSized(20),
        // ${quntity['title']},

        RichText(
          text: TextSpan(
              text: " YOUR ORDER SERVES  ",
              style: TextStyle(
                  color: Color(0xffA1A3AC),
                  fontFamily: sansSemiBold,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  fontSize: 16),
              children: [
                TextSpan(
                    text: initSelect == 1 ? '4' : _radioButton,
                    style: TextStyle(
                        color: Color(0xffA1A3AC),
                        fontFamily: montserratBold,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        fontSize: 16)),
                TextSpan(
                    text: "  PEOPLE",
                    style: TextStyle(
                        color: Color(0xffA1A3AC),
                        fontFamily: sansBold,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        fontSize: 16))
              ]),
        ),

        SizedBox(
          height: FsDimens.space20,
        ),
      ],
    );
  }

  tagesList() {
    return ((lacalTagdat.length > 0)
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: lacalTagdat.length > 4 ? 30 : 15,
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: lacalTagdat.length,
              itemBuilder: (context, index) {
                return Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffD8F2E7),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 4, bottom: 4),
                          child: Text(
                            "${lacalTagdat[index]}".toUpperCase(),
                            style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                //fontFamily: monsterdRegular,
                                color: Color(0xff2C3B36)),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        : Container());
  }

  appBar(value) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          //  Navigator.push(context MaterialPageRoute(builder: (context)))
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> ))
        },
        child: Image.asset(
          "assets/icons/Group Copy 3.png",
          height: 20,
          width: 20,
          color: Colors.black,
        ),
      ),
      title: Text(
        "Personalize",
        style: newAppbartextStyle,
      ),
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
    );
  }

  // ignore: missing_return
  Widget commonCountSelect() {
    if (radioButtonshow == false) {
      if (selecteVarient == 1) {
        // return quantityFor4();
      } else if (selecteVarient == 0) {
        //  return quantityFor2();
      } else if (selecteVarient == 2) {
//return quantityFor6();
      }
    } else {
      return quantityForDrop();
    }
  }

  Widget quantityForDrop() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[300])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                splashColor: Colors.grey[400],
                onTap: () {
                  setState(() {
                    _decrementCounter();
                  });
                },
                child: Container(
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
              Text("$_count",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 20)),
              CommonWidth(FsDimens.space20),
              InkWell(
                splashColor: Colors.grey[400],
                onTap: () {
                  setState(() {
                    _incrementCounter();
                  });
                },
                child: Container(
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  navigationToCheckOut() {
    if (radioButtonshow == false) {
      if (selecteVarient == 0) {
        quntity = varientPrice;
        counts = _count;
        CommonFunctions().console(quntity);
      } else if (selecteVarient == 1) {
        quntity = varientPrice;
        counts = _count;
        CommonFunctions().console(quntity);
      } else if (selecteVarient == 2) {
        quntity = varientPrice;
        counts = _count;
      }
    } else {
      if (sendData != null) {
        quntity = sendData;
        counts = _count;

        CommonFunctions().console(quntity);
      } else {
        quntity = values[0]['node'];
        counts = _count;
        CommonFunctions().console(quntity);
      }
    }

    selectedSides = [];
    for (var i = 0; i < sideList.length; i++) {
      if (sideList[i]['checked']) {
        selectedSides.add(sideList[i]['item']);
      }
    }
    sideStr = selectedSides.join(',');
    print("OKAY...${sideStr.toString()}");

    if (selectedSides.length < 2) {
      return showToastMessage("Please select two sides", context);
    }
    int temp = 1;
    if (widget.isFrom == true) {
      print("SAUCE...$sauceSelectedValue");
      print("SAUCE...$sideStr");
      setState(() {
        _isLoading = true;
      });
      _insert(
          jsonEncode(items),
          temp,
          items['node']['id'],
          items['node']['title'],
          items['node']['description'],
          items['node']['productType'],
          items['node']['images']['edges'][0]['node']['image'],
          _count.toString(),
          items['node']['variants']['edges'][selecteVarient]['node']['id'],
          items['node']['variants']['edges'][selecteVarient]['node']['price'],
          items['node']['variants']['edges'][selecteVarient]['node']['title'],
          (double.parse(items['node']['variants']['edges'][selecteVarient]
                      ['node']['price']) *
                  _count)
              .toStringAsFixed(2)
              .toString(),
          sauceSelectedValue,
          sideStr);
      if (breadOneSelect == 1) {
        _insert(
            jsonEncode(extraOneProduct),
            temp,
            extraOneProduct['id'].toString(),
            extraOneProduct['title'],
            extraOneProduct['title'],
            extraOneProduct['product_type'],
            extraOneProduct['images'][0]['src'],
            "1",
            extraOneProduct['variants'][0]['id'].toString(),
            extraOneProduct['variants'][0]['price'],
            extraOneProduct['title'],
            extraOneProduct['variants'][0]['price'],
            '',
            '');
      }
      print("Flutter ====$breadTwoSelect");

      if (breadTwoSelect == 1) {
        _insert(
            jsonEncode(extraTwoProduct),
            temp,
            extraTwoProduct['id'].toString(),
            extraTwoProduct['title'],
            extraTwoProduct['title'],
            extraTwoProduct['product_type'],
            extraTwoProduct['images'][0]['src'],
            "1",
            extraTwoProduct['variants'][0]['id'].toString(),
            extraTwoProduct['variants'][0]['price'],
            extraTwoProduct['title'],
            extraTwoProduct['variants'][0]['price'],
            '',
            '');
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => YourOrder()));
    }
  }

  void _insert(
      name,
      miles,
      pid,
      title,
      description,
      productType,
      image,
      qty,
      varientId,
      varientPrice,
      varientTitle,
      totalPrice,
      sauceSelectedValue,
      sideStr) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnNamed: name, // pnode
      DatabaseHelper.columnMiles: miles,
      DatabaseHelper.columnPId: pid,
      DatabaseHelper.columnTitle: title,
      DatabaseHelper.columnDecription: description,
      DatabaseHelper.columnProductType: productType,
      DatabaseHelper.columnImage: image,
      DatabaseHelper.columnQty: qty,
      DatabaseHelper.columnVId: varientId,
      DatabaseHelper.columnVPrice: varientPrice,
      DatabaseHelper.columnVTitle: varientTitle,
      DatabaseHelper.columnTotalPrice: totalPrice,
      DatabaseHelper.columnVSauce: sauceSelectedValue,
      DatabaseHelper.columnVSide: sideStr
    };
    Car car = Car.fromMap(row);
    bool idProductExists = await dbHelper.isRecordExists(pid);
    print("Android_U...$idProductExists");
    if (idProductExists) {
      // int del = await dbHelper.deleteBYProductId(pid);
      //  print("Android_D...$del");
      int ins = await dbHelper.insert(car);
      print("Android_I...$ins"); //cart update item
    } else {
      int ins = await dbHelper.insert(car);

      print("Android_K...$ins"); //cart add item
    }
  }

  Future<void> addExtras() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://fcf7c2c27302e9605dfc6fdcba825125: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@getbitetime.myshopify.com/admin/api/2021-07/products.json?product_type=Extras'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      dynamic extrajson = json.decode(responseJson);
      print(responseJson);
      //  extraProduct = extrajson['products'];
      print(extraProduct);
      setState(() {
        extraProduct = extrajson['products'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  collectionDataStaic() async {
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
        '''{"query":"{\\n    collections(query: \\"temp\\",first: 50) {\\n      edges {\\n        node {\\n          title\\n          description\\n        }\\n      }\\n    }\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      dynamic collectionjson = json.decode(responseJson);
      setState(() {
        productTypeCollection = json.decode(collectionjson['data']
            ['collections']['edges'][0]['node']['description']);
      });
      var productType = "${items['node']['productType']}".toUpperCase();
      print("product_type_data...${productTypeCollection[productType]}");
      sauceList = productTypeCollection[productType]['SAUCE'];
      sideList = productTypeCollection[productType]['SIDES'];
      extraList = productTypeCollection[productType]['EXTRAS'];
      if (extraList.length > 0) {
        extraType = extraList[0]['item'];
      }

      if (isFromDB) {
        await dbHelper.getSauceIfProductExists(items['node']['id']).then((val) {
          setState(() {
            sauceSelectedValue = val;
            print('Android....$sauceSelectedValue');
          });
        });

        await dbHelper
            .getSauceIfProductExistsTwo(items['node']['id'])
            .then((val) {
          sideDBStr = val;
          print('Android....$sideDBStr');
          for (var i = 0; i < sideList.length; i++) {
            if (sideDBStr.contains(sideList[i]['item'])) {
              setState(() {
                sideList[i]['checked'] = true;
              });
            }
          }
        });
      }
      print("product_type_sauce...${sauceList.length}");
      print("product_type_side...${sideList.length}");
      print("product_type_extras...${extraList.length}");
    } else {
      print(response.reasonPhrase);
    }
  }

  void updateReviewRating() {
    // "average": 5.0,
    //         "total": 10,
    //print('jain...${Review.reviewRatingData.length}');
    //  print('jain11...${items['node']['title']}');
    var pTitle = Review.reviewRatingList[0]['product']['productTitle'];

    for (var i = 0; i < Review.reviewRatingList.length; i++) {
      var pTitle = Review.reviewRatingList[i]['product']['productTitle'];
      //  print('jain...$pTitle');
      // setState(() {
      //   rating = 3; // Review.reviewRatingData[i]['product']['average'];
      //   review = "5"; //Review.reviewRatingData[i]['product']['total'];
      // });
      if (pTitle
          .toString()
          .toLowerCase()
          .endsWith(items['node']['title'].toString().toLowerCase())) {
        //  print("Jai Shree ram...");
        setState(() {
          ratingPId = Review.reviewRatingList[i]['product']['productId'];
          rating = (Review.reviewRatingList[i]['product']['average'] == null)
              ? 0
              : Review.reviewRatingList[i]['product']['average'];
          review = (Review.reviewRatingList[i]['product']['total'] == null)
              ? ''
              : Review.reviewRatingList[i]['product']['total'];
        });

        break;
      }
    }
  }
}
