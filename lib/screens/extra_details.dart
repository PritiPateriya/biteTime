import 'dart:convert';

import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/sizedbox_common.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/database.dart';
import 'package:bitetime/model/data.dart';
import 'package:bitetime/screens/dashboard.dart';
import 'package:bitetime/screens/rating_star.dart';
import 'package:bitetime/screens/write_review/review.dart';
import 'package:bitetime/screens/your_order.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExtraDetails extends StatefulWidget {
  final dynamic extraPId;
  final dynamic extraPImage;

  ExtraDetails({Key key, this.extraPId, this.extraPImage}) : super(key: key);

  @override
  _ExtraDetailsState createState() => _ExtraDetailsState();
}

class _ExtraDetailsState extends State<ExtraDetails> {
  final dbHelper = DatabaseHelper.instance;
  List<Car> cars = [];
  double rating = 4;
  var extraPId;
  var extraPImage;
  int breadOneSelect = 0;
  int breadTwoSelect = 0;
  var totalExtraPrice;
  dynamic extraProduct = '', extraProductDetails = '';
  @override
  void initState() {
    super.initState();
    extraPId = widget.extraPId;
    extraPImage = widget.extraPImage;
    extraProductDetails = '';
    _count = 1;
    addExtras();
  }

  int _count = 1;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
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
          "Extras",
          style: newAppbartextStyle,
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              imageView(),
              titleWidget(),
              starRatingWidget(),
              SizedBox(
                height: FsDimens.space14,
              ),
              titleSubWidget(),
              // bread(),
              SizedBox(
                height: FsDimens.space20,
              ),
              DottedLine(),
              SizedBox(
                height: FsDimens.space24,
              ),
              quantityForDrop(),
              SizedBox(
                height: FsDimens.space56,
              ),
              Align(alignment: Alignment.bottomCenter, child: checkOutButton())
            ],
          ),
        ),
      ),
    );
  }

  Widget imageView() {
    // print("${img['node']['src']}");
    return Stack(children: [
      Container(
        child: Padding(
          padding: const EdgeInsets.all(0.1),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
              (extraProductDetails.length > 0)
                  ? extraProductDetails['images'][0]['src'].toString()
                  : '',
              //'assets/icons/welcome_img.png',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ]);
  }

  Widget titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 4),
        child: Text(
          //  " hell",
          (extraProductDetails.length > 0)
              ? extraProductDetails['title'].toString()
              : '',
          style: TextStyle(
              fontSize: 18,
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Reviews()));
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
              ],
            )),
      ),
    );
  }

  Widget titleSubWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 4),
        child: Text(
          //  " hell",
          (extraProductDetails.length > 0)
              ? extraProductDetails['title'].toString()
              : '',
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

  // Widget bread() {
  //   return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //           child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 if (breadOneSelect == 0) {
  //                   breadOneSelect = 1;
  //                 } else {
  //                   breadOneSelect = 0;
  //                   // extraOneProduct = '';
  //                 }
  //               });
  //             },
  //             child: Container(
  //               padding: EdgeInsets.only(left: 10),
  //               alignment: Alignment.centerLeft,
  //               width: double.infinity,
  //               height: 50,
  //               decoration: BoxDecoration(
  //                   color: breadOneSelect == 0 ? Colors.white : greenColor,
  //                   border: Border.all(
  //                       color: breadOneSelect == 0 ? Colors.grey : greenColor),
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text("4 Cronbreard ",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w600,
  //                           fontFamily: sourceSansPro,
  //                           color:
  //                               breadOneSelect == 0 ? darkBlack : Colors.white,
  //                           fontSize: 19)),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 10),
  //                     child: Text(" 6.95",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.w600,
  //                             fontFamily: sourceSansPro,
  //                             color: breadOneSelect == 0
  //                                 ? darkBlack
  //                                 : Colors.white,
  //                             fontSize: 19)),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           CommonSized(10),
  //           GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 if (breadTwoSelect == 0) {
  //                   breadTwoSelect = 1;
  //                 } else {
  //                   breadTwoSelect = 0;
  //                 }
  //               });
  //             },
  //             child: Container(
  //               padding: EdgeInsets.only(left: 10),
  //               alignment: Alignment.centerLeft,
  //               width: double.infinity,
  //               height: 50,
  //               decoration: BoxDecoration(
  //                   color: breadTwoSelect == 0 ? Colors.white : greenColor,
  //                   border: Border.all(
  //                       color: breadTwoSelect == 0 ? Colors.grey : greenColor),
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text("4 Cronbreard ",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w600,
  //                           fontFamily: sourceSansPro,
  //                           color:
  //                               breadTwoSelect == 0 ? darkBlack : Colors.white,
  //                           fontSize: 19)),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 10),
  //                     child: Text(" 4.95",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.w600,
  //                             fontFamily: sourceSansPro,
  //                             color: breadTwoSelect == 0
  //                                 ? darkBlack
  //                                 : Colors.white,
  //                             fontSize: 19)),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       )));
  // }

  Widget quantityForDrop() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "QUANTITY".toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: monstExtrabold,
                    color: Color(0xff044239),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Container(
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
                        // _incrementCounter1(cars[index].id, cars[index].qty,
                        //     cars[index].variantsPrice, index);
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
        ],
      ),
    );
  }

  Widget checkOutButton() {
    var screenSize = MediaQuery.of(context).size.width - 30;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
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
                  "Add to Order",
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
                  // extraProductDetails['variants']['price'],
                  //totalExtraPrice =
                  (extraProductDetails.length > 0)
                      ? '\u0024' +
                          ((double.parse(extraProductDetails['variants'][0]
                                      ['price']) *
                                  _count))
                              .toStringAsFixed(2)
                              .toString()
                      : '00.00',

                  // (double.parse( extraProductDetails['variants'][0]
                  //         ['price'] ))*
                  //     _count.toString(),
                  style: TextStyle(
                    inherit: true,
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 1,
                    fontFamily: sourceSansPro,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => YourOrder()));
            }),
      ),
    );
  }

  Future<void> addExtras() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://fcf7c2c27302e9605dfc6fdcba825125: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@getbitetime.myshopify.com/admin/api/2021-07/products.json?product_type=Extras'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      dynamic extrajson = json.decode(responseJson);
      print(responseJson);
      setState(() {
        extraProduct = extrajson['products'];
        for (var i = 0; i < extraProduct.length; i++) {
          if (extraProduct[i]['id'] == int.parse(extraPId)) {
            extraProductDetails = extraProduct[i];
            break;
          }
        }
        print("selected_product...$extraProductDetails");
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}
