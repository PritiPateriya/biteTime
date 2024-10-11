import 'dart:convert';

import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  dynamic data;
  dynamic getOrder;
//bool _isLoading;
  var id;

  @override
  void initState() {
    //  _isLoading = true;
    id = '';
    getToken();
    super.initState();
  }

  getToken() async {
    setState(() {
      //  _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('TOKEN');
    print(token);
    var res = json.decode(token);
    setState(() {
      id = res['id'];
      print("=============+$id");
      orderApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getOrder == null
          ? Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height - 200,
              child: Text('$data',
                  style: TextStyle(fontSize: 18, fontFamily: sansBold)),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: FsDimens.space24,
                          ),
                          Text("UPCOMING",
                              style: TextStyle(
                                  color: Color(0xffB4B6BD),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  fontSize: 14)),
                          SizedBox(
                            height: FsDimens.space12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey[300])),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0, left: 12, bottom: 12.0, right: 10),
                              child: Column(
                                children: [
                                  upComingCon(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: FsDimens.space24,
                          ),
                          // Text("OTHER HISTORY",
                          //     style: TextStyle(
                          //         color: Color(0xffB4B6BD),
                          //         fontWeight: FontWeight.w600,
                          //         letterSpacing: 0.5,
                          //         fontSize: 14)),
                          // SizedBox(
                          //   height: FsDimens.space12,
                          // ),
                          orderHistory(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: FsDimens.space24,
                ),
              ],
            ),
    );
  }

  Widget upComingCon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Wed, Mar 8,2021",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                    fontFamily: sansSemiBold,
                  )),
              Text(String.fromCharCodes(Runes('\u0024115.00')),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xff000A12))),
              // Text("+25 points",
              //     textAlign: TextAlign.end,
              //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
            ]),
        SizedBox(
          height: FsDimens.space24,
        ),
        Text("MEXICAN",
            style: TextStyle(
                fontFamily: montserratBold,
                color: Color(0xffB4B6BD),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 14)),
        SizedBox(
          height: FsDimens.space6,
        ),
        Text("4 Honey adobo chicken soft tacos",
            style: TextStyle(
              fontFamily: sourceSansPro,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Color(0xff1B1c1c),
              // color: Color(0xffB4B6BD),
            )),
        SizedBox(
          height: FsDimens.space6,
        ),
        Text(
          "4 Chocolate chip cookies",
          style: TextStyle(
            fontFamily: sourceSansPro,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: Color(0xff1B1c1c),
          ),
        ),
        SizedBox(
          height: FsDimens.space24,
        ),
        Text("ITALIAN",
            style: TextStyle(
                fontFamily: montserratBold,
                color: Color(0xffB4B6BD),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 14)),
        SizedBox(
          height: FsDimens.space6,
        ),
        Text("4 Creamy Tuscac chicken",
            style: TextStyle(
              fontFamily: sourceSansPro,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Color(0xff1B1c1c),
            )),
        SizedBox(
          height: FsDimens.space6,
        ),
        Text("Side: Balsamic vegetables",
            style: TextStyle(
              fontFamily: sourceSansPro,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Color(0xff1B1c1c),
            )),
        SizedBox(
          height: FsDimens.space24,
        ),
        cPaymentButton(),
      ],
    );
  }

  Widget cPaymentButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 08),
      child: GreenButton(
        key: Key('view_details_submit'),
        buttonName: "View details",
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => FinalPayment()));
        },
      ),
    );
  }

  Widget orderHistory() {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 10, bottom: 12, left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey[300])),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Thu, Feb 8, 2021",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        fontFamily: sourceSansPro)),
                Text(String.fromCharCodes(Runes('\u002427.50')),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        fontFamily: sourceSansPro)),
                // Padding(
                //   padding: const EdgeInsets.only(right: 12.0),
                //   child: Text("+27 points",
                //       textAlign: TextAlign.end,
                //       style:
                //           TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                // ),
              ]),
        ),
        SizedBox(
          height: FsDimens.space14,
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 10, bottom: 12, left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey[300])),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Thu, Feb 8, 2021",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        fontFamily: sourceSansPro)),
                Text(String.fromCharCodes(Runes('\u002427.50')),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        fontFamily: sourceSansPro)),
                // Padding(
                //   padding: const EdgeInsets.only(right: 12.0),
                //   child: Text("+27 points",
                //       textAlign: TextAlign.end,
                //       style:
                //           TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                // ),
              ]),
        ),
      ],
    );
  }

  orderApi() async {
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
        '''{"query":"{\\n   customer (customerAccessToken:\\"$id\\"){\\n        orders(first: 10){\\n           edges {\\n            node {\\n                email\\n                orderNumber\\n                totalPrice\\n                lineItems(first:10){\\n                     edges {\\n              node {\\n                quantity\\n              }\\n              }\\n                }\\n                \\n            }\\n       }\\n    }\\n  }\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      print("Order....$responseJson");
      dynamic responseData = json.decode(responseJson);
      var data = responseData['data']['customer']['orders'];
      print("Orders  $data");

      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }
}
