import 'dart:convert';

import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/screens/information.dart';
import 'package:bitetime/screens/payment/final_payment.dart';
// ignore: unused_import
import 'package:bitetime/screens/preference.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShippingScreen extends StatefulWidget {
  ShippingScreen({Key key});
  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  SharedPreferences preferences;
  var userToken = '';
  @override
  void initState() {
    super.initState();
    userToken = '';
    initializePreference().whenComplete(() {
      setState(() {
        var responseJson = this.preferences.getString('TOKEN');
        var res = json.decode(responseJson);
        userToken = res['id'];
      });
    });
  }

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
  }

  int vegeSelect = 0;
  dynamic vegSelected = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                "assets/icons/Group Copy 3.png",
                height: 18,
                width: 18,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("Shipping", style: newAppbartextStyle),
      ),
      body: ListView(
        children: [
          Container(
            height: ((30 / 100) * MediaQuery.of(context).size.height),
            color: Color(0xffF8F8F8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: FsDimens.space28,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Contact",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: montserratBold,
                            fontWeight: FontWeight.w500,
                            fontSize: 18)),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("Contact",
                  //         style: TextStyle(
                  //             color: Colors.black,
                  //             fontFamily: montserratBold,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 18)),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => Information()));
                  //       },
                  //       child: Text("Edit".toUpperCase(),
                  //           style: TextStyle(
                  //               color: bGBottomColor,
                  //               letterSpacing: 0.3,
                  //               fontFamily: montserratBold,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: 17.5)),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: FsDimens.space10,
                  ),
                  Text(this.preferences?.getString("email"),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: sourceSansPro,
                          fontSize: 17)),
                  SizedBox(
                    height: FsDimens.space32,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ship to",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: montserratBold,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Information()));
                        },
                        child: Text("Edit".toUpperCase(),
                            style: TextStyle(
                                color: bGBottomColor,
                                letterSpacing: 0.3,
                                fontFamily: montserratBold,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.5)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: FsDimens.space10,
                  ),
                  Text(this.preferences?.getString("address1"),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: sourceSansPro,
                          fontSize: 17)),
                  SizedBox(
                    height: FsDimens.space4,
                  ),
                  Row(
                    children: [
                      Text(
                          "${this.preferences?.getString("city")}" +
                              " , ".toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontFamily: sourceSansPro,
                              fontSize: 17)),
                      Text("${this.preferences?.getString("zip_code")}" + "  ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontFamily: sourceSansPro,
                              fontSize: 17)),
                      Text("${this.preferences?.getString("state")}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontFamily: sourceSansPro,
                              fontSize: 17)),
                    ],
                  ),
                  SizedBox(
                    height: FsDimens.space16,
                  ),
                ],
              ),
            ),
          ),
          DottedLine(
            dashColor: Color(0xffA2A4AD),
          ),
          shippingMethod()
        ],
      ),
    );
  }

  Widget shippingMethod() {
    return Container(
      height: ((75 / 100) * MediaQuery.of(context).size.height),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: FsDimens.space32,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Shipping method",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.5,
                  fontFamily: montserratBold,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: FsDimens.space20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (vegeSelect == 0) {
                    vegeSelect = 1;
                  } else {
                    vegeSelect = 0;
                    vegSelected = '';
                    // addToOrderButton(-10);
                  }
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: vegeSelect == 0 ? bGBottomColor : Colors.white,
                      border: Border.all(color: Colors.grey[300])),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Outlet pickup",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: sourceSansPro,
                                color: vegeSelect == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16)),
                        Text(String.fromCharCodes(Runes('Free')),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: sansSemiBold,
                                color: vegeSelect == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16)),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: FsDimens.space10,
            ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       vegeSelect = 1;
            //     });
            //   },
            //   child: Container(
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(8),
            //           color: vegeSelect == 1 ? bGBottomColor : Colors.white,
            //           border: Border.all(color: Colors.grey[300])),
            //       child: Padding(
            //         padding: const EdgeInsets.only(
            //             top: 12.0, left: 12, bottom: 12.0),
            //         child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.only(right: 40.0),
            //                 child: Text("Some other options",
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.w600,
            //                         fontFamily: sourceSansPro,
            //                         color: vegeSelect == 0
            //                             ? Colors.black
            //                             : Colors.white,
            //                         fontSize: 16)),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(right: 12.0),
            //                 child: Text(
            //                     String.fromCharCodes(Runes('\u002436.95')),
            //                     textAlign: TextAlign.end,
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.w600,
            //                         fontFamily: sourceSansPro,
            //                         color: vegeSelect == 0
            //                             ? Colors.black
            //                             : Colors.white,
            //                         fontSize: 16)),
            //               ),
            //             ]),
            //       )),
            // ),
            SizedBox(
              height: FsDimens.space140,
            ),
            // vegeSelect == 0 ?

            checkoutProceedWithPayment()
            // : Container(),
          ],
        ),
      ),
    );
  }

  Widget checkoutProceedWithPayment() {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: GreenButton(
        key: Key('continue_payment_submit'),
        buttonName: "Continue to payment",
        onPressed: () {
          checkoutWithCustomerToken();
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => FinalPayment()));
        },
      ),
    );
  }

  checkoutWithCustomerToken() async {
    var headers = {
      'Accept': 'application/json',
      'X-Shopify-Storefront-Access-Token': 'cda4fb2c7736fc030e88e093ed5e1aae',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://getbitetime.myshopify.com/api/2021-07/graphql.json'));
    request.body =
        '''{"query":"mutation associateCustomerWithCheckout(\$checkoutId: ID!, \$customerAccessToken: String!) {\\n  checkoutCustomerAssociateV2(checkoutId: \$checkoutId, customerAccessToken: \$customerAccessToken) {\\n    checkout {\\n      id\\n        webUrl\\n    }\\n    checkoutUserErrors {\\n      code\\n      field\\n      message\\n    }\\n    customer {\\n      id\\n    }\\n  }\\n}","variables":{"checkoutId": "${this.preferences?.getString("checkout_id")}","customerAccessToken":"$userToken"}}''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      dynamic responsejson = await response.stream.bytesToString();
      dynamic responseData = json.decode(responsejson);
      dynamic responsedata = responseData['data'];
      dynamic varjson = responsedata['checkoutCustomerAssociateV2'];
      Map<String, dynamic> checkout = varjson['checkout'];

      if (varjson != null) {
        dynamic checkoutUserErrors = varjson["checkoutUserErrors"];
        if (checkout != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('checkout_id', checkout['id']);
          prefs.setString('web_url', checkout['webUrl']);
          print("webUrl...${checkout['webUrl']}");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FinalPayment()));
          //return showToastMessage("Checkout Created.", context);
        } else {
          dynamic showError = checkoutUserErrors[0]['message'];
          return showToastMessage(showError, context);
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
