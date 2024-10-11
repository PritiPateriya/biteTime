import 'dart:convert';

import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/media_quary_size_type.dart';
import 'package:bitetime/common_files/mytextfield.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/common_files/validation.dart';
import 'package:bitetime/screens/login.dart';
import 'package:bitetime/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fEmailCon = TextEditingController();
  bool _isLoading;

  void _submit() async {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (fEmailCon.text.toString().trim().isEmpty) {
      return showToastMessage("${Strings.emailIsEmpty}", context);
    } else if (fEmailCon.text.toString().trim().isNotEmpty &&
        !regExp.hasMatch(fEmailCon.text.toString().trim())) {
      return showToastMessage("${Strings.validEmail}", context);
    } else {
      return gorGotPassword();
    }
  }

  gorGotPassword() async {
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
        '''{"query":"mutation {\\r\\n  customerRecover(email: \\"${fEmailCon.text.toString().trim()}\\") {\\r\\n    customerUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      dynamic responseJson = await response.stream.bytesToString();

      dynamic mujson = json.decode(responseJson);

      Map<String, dynamic> varjson = mujson['data']['customerRecover'];
      print("@@@@@@@@@@@@@@@@@@@@@@@@" + "$varjson");
      if (varjson == null) {
        showToastMessage(
            "Somthing went wrong please try after sometime", context);
      } else {
        dynamic fresponse = varjson['customerUserErrors'];
        print("&&&&&&&&&&&&&&&&&&&&&&&&" + "$fresponse");
        if (fresponse.isEmpty) {
          return showToastMessage("Account not found", context);
        } else {
          showToastMessage(
              "password reset link has been sent to your email", context);
          navigatToOtherLoginPage();
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  navigatToOtherLoginPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarThem,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: FsDimens.space24,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 18,
                                  child: Image.asset(
                                    'assets/icons/Group Copy 3.png',
                                    fit: BoxFit.fill,
                                    color: Colors.black,
                                    // height: MediaQuery.of(context).size.height,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: FsDimens.space24,
                              ),
                              Text("FORGOT PASSWORD",
                                  style: TextStyle(
                                      color: universalColor,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 7.4,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: monsterdRegular)),
                              SizedBox(
                                height: FsDimens.space24,
                              ),
                              fEmailField(),
                              SizedBox(
                                height: FsDimens.space100,
                              ),
                            ],
                          ),
                        ],
                      ),
                      submitButton(),
                    ],
                  ),
                ),
                LoaderIndicator(_isLoading)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fEmailField() {
    return AllInputDesign(
        key: Key("email"),
        inputHeaderName: 'Email',
        controller: fEmailCon,
        hintText: 'Email',
        validatorFieldValue: 'Email',
        validator: validEmailField,
        keyBoardType: TextInputType.emailAddress);
  }

  Widget submitButton() {
    return Align(
          alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: GreenButton(
            key: Key('forgot_pass_button'),
            buttonName: "Submit",
            onPressed: () {
              _submit();
            },
          ),
        ),
      ),
    );
  }
}
