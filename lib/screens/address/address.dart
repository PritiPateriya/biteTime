import 'dart:convert';

import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/sizedbox_common.dart';
import 'package:bitetime/screens/address/edit_address.dart';
import 'package:bitetime/strings/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_files/styles.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  dynamic data;
  dynamic defaultAddress;
  bool _isLoading;
  bool showLoader;
  var id;

  @override
  void initState() {
    _isLoading = true;
    getToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading == true ? LoaderIndicator(_isLoading) : body(),
    );
  }

  Widget body() {
    return Stack(
      children: [
        ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  // alartDialog(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [CommonSized(FsDimens.space12), priAddressBox()],
                ),
              ),
            ),
            otherAddress(),
          ],
        ),
        addNewAddress(),
        showLoader == true ? LoaderIndicator(showLoader) : Container(),
      ],
    );
  }

  Widget priAddressBox() {
    print("####################################################" +
        "$defaultAddress");
    return defaultAddress == null
        ? Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 200,
            child: Text("No address found",
                style: TextStyle(fontSize: 18, fontFamily: sansBold)),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              commonHeading('PRIMARY ADDRESS'),
              CommonSized(FsDimens.space8),
              Container(
                padding: EdgeInsets.only(top: 5, left: 16, bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(width: 2.0, color: Colors.black12),
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(width: 1.0, color: Colors.green),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text("${defaultAddress['company']}",
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                  fontFamily: sansSemiBold,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16)),
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.black26,
                          size: 30,
                        ),
                      ],
                    ),
                    CommonSized(FsDimens.space6),
                    Text(
                        "${defaultAddress['address1']}" +
                            ", " +
                            "\n${defaultAddress['address2']}",
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 0.5,
                            fontFamily: sourceSansPro,
                            fontWeight: FontWeight.w600,
                            fontSize: 16)),
                    Text(
                        "${defaultAddress['city']}" +
                            ", " +
                            "${defaultAddress['zip']}",
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 0.5,
                            fontFamily: sourceSansPro,
                            fontWeight: FontWeight.w900,
                            fontSize: 16)),
                  ],
                ),
              ),
            ],
          );
  }

  Widget otherAddress() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: data == null || data.length == 0
          ? Container()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonSized(FsDimens.space12),
                commonHeading('OTHER ADDRESSES'),
                CommonSized(FsDimens.space8),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        dynamic otherAddress = data[index];

                        return Container(
                          padding:
                              EdgeInsets.only(top: 5, left: 16, bottom: 20),
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border:
                                Border.all(width: 1.0, color: Colors.black12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Text(
                                        "${otherAddress['node']['company']}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 0.5,
                                            fontFamily: sansSemiBold,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      alartDialog(
                                        context,
                                        otherAddress['node']['id'],
                                        otherAddress,
                                      );
                                    },
                                    child: Icon(
                                      Icons.more_vert,
                                      color: Colors.black26,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  "${otherAddress['node']['address1']}" +
                                      ", " +
                                      "\n${otherAddress['node']['address2']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                      fontFamily: sourceSansPro,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16)),
                              CommonSized(FsDimens.space4),
                              //  print("${otherAddress['node']['city']}");
                              Text(
                                  //   print("${otherAddress['node']['city']}"),
                                  "${otherAddress['node']['city']}" +
                                      ", " +
                                      "${otherAddress['node']['zip']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                      fontFamily: sourceSansPro,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16)),
                            ],
                          ),
                        );
                      }),
                ),
                CommonSized(FsDimens.space40),
              ],
            ),
    );
  }

  alartDialog(
    context,
    editAddresId,
    otherAddress,
  ) async {
    print("################" + "$editAddresId");
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 1.0,
                  spreadRadius: 0.2,
                  offset: Offset(
                    0.0,
                    1.0,
                  ),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: ImageIcon(
                        AssetImage("assets/icons/Group Copy 3@3x.png"),
                        size: 17,
                      )),
                ),
                CommonSized(FsDimens.space14),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditAddress(editAddresId: editAddresId)))
                          .then((value) => setState(() {
                                getUsersPrimaryAddress();
                                showLoader = true;
                                Navigator.of(context).pop();
                              }));
                    });
                  },
                  child: Text("Edit"),
                ),
                CommonSized(FsDimens.space24),
                GestureDetector(
                    onTap: () {
                      makePrimaryAddress(otherAddress);
                      Navigator.of(context).pop();
                    },
                    child: Text("Make primary")),
                CommonSized(FsDimens.space24),
                GestureDetector(
                    onTap: () {
                      customerAddressDelete(editAddresId);
                      Navigator.of(context).pop();
                    },
                    child: Text("Delete")),
                CommonSized(FsDimens.space24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addNewAddress() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditAddress()))
              .then((value) => setState(() {
                    showLoader = true;
                    getUsersPrimaryAddress();
                  }));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                  color: greenColor, borderRadius: BorderRadius.circular(27)),
              child: Text("Add new address",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      fontFamily: sourceSansPro,
                      color: Colors.white))),
        ),
      ),
    );
  }

  Widget commonHeading(String heading) {
    return Container(
      child: Text("$heading",
          style: TextStyle(
              fontFamily: montserratBold,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 14)),
    );
  }

//--------------------get Address Start -------------///
  getToken() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('TOKEN');
    print(token);
    var res = json.decode(token);
    setState(() {
      id = res['id'];
      print(id);
      getUsersPrimaryAddress();
    });
  }

  getUsersPrimaryAddress() async {
    // var headers = Strings.hraders;
    // var request = http.Request(
    //     'POST',
    //     Uri.parse(
    //         'https://getbitetime.myshopify.com/api/2021-04/graphql.json'));
    // request.body =
    //     '''{"query":"{\\r\\n    customer(customerAccessToken: \\"$id\\") {\\r\\n      email\\r\\n      firstName\\r\\n      lastName\\r\\n      id\\r\\n      phone\\r\\n      defaultAddress{\\r\\n           id\\r\\n            address1\\r\\n            address2\\r\\n            city\\r\\n            company\\r\\n            country\\r\\n            firstName\\r\\n            lastName\\r\\n            phone\\r\\n            province\\r\\n            zip\\r\\n      }\\r\\n    addresses(first: 10){\\r\\n           edges {\\r\\n            node {\\r\\n                id\\r\\n                address1\\r\\n                address2\\r\\n                city\\r\\n                company\\r\\n                country\\r\\n                firstName\\r\\n                lastName\\r\\n                phone\\r\\n                province\\r\\n                zip\\r\\n        }\\r\\n       }\\r\\n    }\\r\\n    }\\r\\n}","variables":{}}''';

    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   var responseJson = await response.stream.bytesToString();
    //   setState(() {
    //     _isLoading = false;
    //     showLoader = false;
    //   });
    //   print(response);

    //   var responseData = json.decode(responseJson);
    //   defaultAddress = responseData['data']['customer']['defaultAddress'];
    //   data = responseData['data']['customer']['addresses']['edges'][1];

    //   CommonFunctions().console(data);
    // } else {
    //   print(response.reasonPhrase);
    // }

    var headers = {
      'Accept': 'application/json',
      'X-Shopify-Storefront-Access-Token': 'cda4fb2c7736fc030e88e093ed5e1aae',
      'Content-Type': 'application/json',
      'Cookie':
          '_landing_page=%2Fadmin%2Fauth%2Flogin; _orig_referrer=https%3A%2F%2Ffcf7c2c27302e9605dfc6fdcba825125%3A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%40getbitetime.myshopify.com%2Fadmin%2Fapi%2F2021-07%2Fcountries.json%250A; _shopify_y=a86dff1e-20f1-4a6b-b0ea-7b366884b4c9; _y=a86dff1e-20f1-4a6b-b0ea-7b366884b4c9; identity-state=BAhbBkkiJThhNDFkM2MxZWQ1OTNkMzQwNTcwM2ViNTYyNTU2ZWI0BjoGRUY%3D--f1165401f0f832833db4aae07f4df50d0ae9efc9; identity-state-8a41d3c1ed593d3405703eb562556eb4=BAh7DEkiDnJldHVybi10bwY6BkVUSSI3aHR0cHM6Ly9nZXRiaXRldGltZS5teXNob3BpZnkuY29tL2FkbWluL2F1dGgvbG9naW4GOwBUSSIRcmVkaXJlY3QtdXJpBjsAVEkiQ2h0dHBzOi8vZ2V0Yml0ZXRpbWUubXlzaG9waWZ5LmNvbS9hZG1pbi9hdXRoL2lkZW50aXR5L2NhbGxiYWNrBjsAVEkiEHNlc3Npb24ta2V5BjsAVDoMYWNjb3VudEkiD2NyZWF0ZWQtYXQGOwBUZhYxNjI3NzIzNjQ4LjU0Njc1N0kiCm5vbmNlBjsAVEkiJTAwNzc0ZTNkY2VhYmY4NjkwNjA0YTU2NWFhMWIwMmE2BjsARkkiCnNjb3BlBjsAVFsOSSIKZW1haWwGOwBUSSI3aHR0cHM6Ly9hcGkuc2hvcGlmeS5jb20vYXV0aC9kZXN0aW5hdGlvbnMucmVhZG9ubHkGOwBUSSILb3BlbmlkBjsAVEkiDHByb2ZpbGUGOwBUSSJOaHR0cHM6Ly9hcGkuc2hvcGlmeS5jb20vYXV0aC9wYXJ0bmVycy5jb2xsYWJvcmF0b3ItcmVsYXRpb25zaGlwcy5yZWFkb25seQY7AFRJIjBodHRwczovL2FwaS5zaG9waWZ5LmNvbS9hdXRoL2JhbmtpbmcubWFuYWdlBjsAVEkiPGh0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvc2hvcGlmeS1jaGF0LmFkbWluLmdyYXBocWwGOwBUSSI3aHR0cHM6Ly9hcGkuc2hvcGlmeS5jb20vYXV0aC9mbG93LndvcmtmbG93cy5tYW5hZ2UGOwBUSSI%2BaHR0cHM6Ly9hcGkuc2hvcGlmeS5jb20vYXV0aC9vcmdhbml6YXRpb24taWRlbnRpdHkubWFuYWdlBjsAVEkiD2NvbmZpZy1rZXkGOwBUSSIMZGVmYXVsdAY7AFQ%3D--b4b9d26c7164e0963a16703c24a89929e9955656'
    };

    var request = http.Request(
        'POST',
        Uri.parse(
            'https://getbitetime.myshopify.com/api/2021-04/graphql.json'));
    request.body =
        '''{"query":"{\\n    customer(customerAccessToken: \\"$id\\") {\\n      email\\n      firstName\\n      lastName\\n      id\\n      phone\\n      defaultAddress{\\n           id\\n            address1\\n            address2\\n            city\\n            company\\n            country\\n            firstName\\n            lastName\\n            phone\\n            province\\n            zip\\n      }\\n    addresses(first: 10){\\n           edges {\\n            node {\\n                id\\n                address1\\n                address2\\n                city\\n                company\\n                country\\n                firstName\\n                lastName\\n                phone\\n                province\\n                zip\\n        }\\n       }\\n    }\\n    }\\n}","variables":{}}''';

    print(body());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseJson = await response.stream.bytesToString();
      setState(() {
        _isLoading = false;
        showLoader = false;
      });
      //print(response);

      var responseData = json.decode(responseJson);
      defaultAddress = responseData['data']['customer']['defaultAddress'];
      data = responseData['data']['customer']['addresses']['edges'];

      CommonFunctions().console(data);

      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
//--------------------get Address End -------------///

//--------------------Delete Address Start -------------///

  customerAddressDelete(editAddresId) async {
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
        '''{"query":"mutation customerAddressDelete(\$id: ID!, \$customerAccessToken: String!) {\\n  customerAddressDelete(id: \$id, customerAccessToken: \$customerAccessToken) {\\n    customerUserErrors {\\n      code\\n      field\\n      message\\n    }\\n    deletedCustomerAddressId\\n  }\\n}\\n","variables":{"id":"$editAddresId","customerAccessToken":"$id"}}''';

    var delete =
        '''{"query":"mutation customerAddressDelete(\$id: ID!, \$customerAccessToken: String!) {\\n  customerAddressDelete(id: \$id, customerAccessToken: \$customerAccessToken) {\\n    customerUserErrors {\\n      code\\n      field\\n      message\\n    }\\n    deletedCustomerAddressId\\n  }\\n}\\n","variables":{"id":"$editAddresId","customerAccessToken":"$id"}}''';
    print("$delete");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //  print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      print(responseJson);
      dynamic responseData = json.decode(responseJson);
      var data = responseData['data']['customerAddressDelete'];
      dynamic error = data['customerUserErrors'];

      if (error.length == 0) {
        setState(() {
          getUsersPrimaryAddress();
        });
        return showToastMessage("address delete success", context);
      } else {
        return showToastMessage("something went wrong ", context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
//--------------------Delete Address End -------------///

//--------------------Edit Address Start -------------///
  makePrimaryAddress(otherAddress) async {
    var addressId = otherAddress['node']['id'];
    // setState(() {
    //   showLoader = true;
    // });
    var headers = Strings.hraders;
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://getbitetime.myshopify.com/api/2021-04/graphql.json'));
    request.body =
        '''{"query":"mutation customerDefaultAddressUpdate(\$customerAccessToken: String!, \$addressId: ID!) {\\r\\n  customerDefaultAddressUpdate(\\r\\n    customerAccessToken: \$customerAccessToken\\r\\n    addressId: \$addressId\\r\\n  ) {\\r\\n    customer {\\r\\n      id\\r\\n    }\\r\\n    customerUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n  }\\r\\n}","variables":{"customerAccessToken":"$id","addressId":"$addressId"}}''';

    var primary =
        '''{"query":"mutation customerDefaultAddressUpdate(\$customerAccessToken: String!, \$addressId: ID!) {\\r\\n  customerDefaultAddressUpdate(\\r\\n    customerAccessToken: \$customerAccessToken\\r\\n    addressId: \$addressId\\r\\n  ) {\\r\\n    customer {\\r\\n      id\\r\\n    }\\r\\n    customerUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n  }\\r\\n}","variables":{"customerAccessToken":"$id","addressId":"$addressId"}}''';
    print("$primary");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      setState(() {
        //  showLoader = false;
        getUsersPrimaryAddress();
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  //--------------------Edit Address End -------------///

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('_isLoading', _isLoading));
  }
}
