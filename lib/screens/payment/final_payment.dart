import 'dart:async';
import 'dart:convert';

import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
// ignore: unused_import
import 'package:bitetime/common_files/mytextfield.dart';
import 'package:bitetime/common_files/styles.dart';
// ignore: unused_import
import 'package:bitetime/common_files/validation.dart';
import 'package:bitetime/screens/information.dart';
import 'package:bitetime/screens/payment/payment_new_address.dart';
// ignore: unused_import
import 'package:bitetime/screens/write_review/review.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FinalPayment extends StatefulWidget {
  FinalPayment({Key key});

  @override
  _FinalPaymentState createState() => _FinalPaymentState();
}

class _FinalPaymentState extends State<FinalPayment> {
  SharedPreferences preferences;
  TextEditingController cardNumCon = TextEditingController();
  TextEditingController nameCardCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController cvvCon = TextEditingController();
  int vegeSelect = 0;
  int vegeSelect1 = 0;
  bool value = false;

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
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
              Navigator.of(context).pop();
            }),
        title: Text(
          "Shipping",
          style: newAppbartextStyle,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                "assets/icons/Group Copy 3.png",
                height: 20,
                width: 20,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: ListView(
        children: [
          firstContainer(),
          DottedLine(
            dashColor: Color(0xffCDCED3),
          ),
          creditCardContainer(),
        ],
      ),
    );
  }

  Widget firstContainer() {
    return Column(
      children: [
        Container(
          height: ((40 / 100) * MediaQuery.of(context).size.height),
          color: Color(0xffF8F8F8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                //     Text("Contect",
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontFamily: montserratBold,
                //             fontWeight: FontWeight.w800,
                //             fontSize: 18)),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => Information()));
                //       },
                //       child: Text("EDIT".toUpperCase(),
                //           style: TextStyle(
                //               color: Color(0xFF00B864),
                //               //fontFamily: sourceSansPro,
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
                Text("${this.preferences?.getString("email")}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontFamily: sourceSansPro,
                        fontSize: 17)),
                SizedBox(
                  height: FsDimens.space28,
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
                      child: Text("EDIT".toUpperCase(),
                          style: TextStyle(
                              color: Color(0xFF00B864),
                              //fontFamily: sourceSansPro,
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
                Text(
                    "${this.preferences?.getString("city")}" +
                        " , ".toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontFamily: sourceSansPro,
                        fontSize: 17)),
                Row(
                  children: [
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
                  height: FsDimens.space28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping method",
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
                      child: Text("EDIT".toUpperCase(),
                          style: TextStyle(
                              color: Color(0xFF00B864),
                              // fontFamily: sourceSansPro,
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
                RichText(
                  text: TextSpan(
                      text: "Outlet pickup ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: sourceSansPro,
                          fontSize: 17),
                      children: [
                        TextSpan(
                            text: " - Free",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: sansSemiBold,
                                fontSize: 17))
                      ]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget creditCardContainer() {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.height * 1.2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            top: 30,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment",
                style: TextStyle(
                    // fontWeight: FontWeight.w900,
                    fontSize: 20,
                    letterSpacing: 0.5,
                    fontFamily: montserratBold,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff1F2D3D)),
              ),
              SizedBox(
                height: FsDimens.space8,
              ),
              Text("All transactions are secure and encrypted",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: sourceSansPro,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
              SizedBox(
                height: FsDimens.space20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    vegeSelect = 0;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentNewAddress()));
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(top: 14, left: 20, bottom: 14),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: vegeSelect == 0 ? bGBottomColor : Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 1.0, color: Colors.black12),
                  ),
                  child: Text("Credit card",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: sourceSansPro,
                          letterSpacing: 1,
                          color: vegeSelect == 0 ? Colors.white : Colors.black,
                          fontSize: 18)),
                ),
              ),
              SizedBox(
                height: FsDimens.space14,
              ),
              payPalContainer(),
              SizedBox(
                height: FsDimens.space32,
              ),
              Text("Billing address",
                  style: TextStyle(
                      fontFamily: montserratBold,
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                      letterSpacing: 1,
//fontFamily: sourceSansPro,
                      color: Color(0xff1F2D3D))),
              SizedBox(
                height: FsDimens.space12,
              ),
              billingCons1(),
              SizedBox(
                height: FsDimens.space12,
              ),
              billingCons2(),
              SizedBox(
                height: FsDimens.space52,
              ),
              remBox(),
              SizedBox(
                height: FsDimens.space52,
              ),
              payNowButton(),
            ],
          ),
        ),
      )
    ]);
  }

  Widget payPalContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          vegeSelect = 1;
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 14.0, left: 20.0, bottom: 14),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: vegeSelect == 1 ? bGBottomColor : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 1.0, color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 25,
                color: Colors.transparent,
                child: Image.asset(
                  "assets/icons/paypal@3x.png",
                  fit: BoxFit.fill,
                  width: 80,
                )),
          ],
        ),
      ),
    );
  }

  Widget billingCons1() {
    return GestureDetector(
      onTap: () {
        setState(() {
          vegeSelect1 = 0;
        });
      },
      child: Container(
          padding: EdgeInsets.only(top: 14, left: 20, bottom: 14),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: vegeSelect1 == 0 ? bGBottomColor : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300])),
          child: Text("Same as shipping",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: sourceSansPro,
                  letterSpacing: 1,
                  color: vegeSelect1 == 0 ? Colors.white : Colors.black,
                  fontSize: 18))),
    );
  }

  Widget billingCons2() {
    return GestureDetector(
      onTap: () {
        setState(() {
          vegeSelect1 = 1;
        });
      },
      child: Container(
          padding: EdgeInsets.only(top: 14, left: 20, bottom: 14),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: vegeSelect1 == 1 ? bGBottomColor : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300])),
          child: Text("Use a different billing address",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: sourceSansPro,
                  letterSpacing: 1,
                  color: vegeSelect1 == 0 ? Colors.black : Colors.white,
                  fontSize: 18))),
    );
  }

  Widget remBox() {
    return Wrap(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  vegeSelect1 = 0;
                });
              },
              child: Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  activeColor: Colors.green,
                  value: this.value,
                  onChanged: (bool value) {
                    setState(() {
                      this.value = value;
                    });
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text("Save my information for faster checkout",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: sourceSansPro,
                          letterSpacing: 0,
                          color: Colors.black,
                          fontSize: 17)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget payNowButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GreenButton(
        key: Key('paynow_button'),
        buttonName: "Continue to Payment",
        onPressed: () async {
          var url = this.preferences?.getString("web_url");
          if (await canLaunch(url)) {
            await launch(url,
                //   forceSafariVC: true,
                // universalLinksOnly: true,
                forceWebView: true);
          } else {
            throw 'Could not launch $url';
          }
        },

        //  openWebview();
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => ThankYou()));
      ),
    );
  }

  // Widget openWebview() {
  //   return WebView(
  //     javascriptMode: JavascriptMode.unrestricted,
  //     initialUrl:
  //         "https://getbitetime.myshopify.com/47453307030/checkouts/2a19ed80aa9f97683867dc522792bd5c?key=0831e079aed450f9c8eaa06835cd86cb",
  //     onWebViewCreated: (WebViewController webViewConteroller) {
  //       _controller.complete(webViewConteroller);
  //     },
  //   );
  // }
}
