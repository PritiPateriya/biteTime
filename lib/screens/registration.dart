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
import 'package:bitetime/screens/login_splash.dart';
import 'package:bitetime/strings/asset_image.dart';
import 'package:bitetime/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

dynamic data;

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode;
  TextEditingController regEmailCon = TextEditingController();
  TextEditingController regPasswordCon = TextEditingController();
  TextEditingController fNameCon = TextEditingController();
  TextEditingController lNameCon = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode fNameFocus = FocusNode();
  final FocusNode lNameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  initState() {
    super.initState();
  }

  bool _isLoading;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarThem,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          //resizeToAvoidBottomInset: true,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Stack(
                  children: [
                    Form(
                        key: _formKey,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context)..requestFocus(FocusNode());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
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
                                    '${AssetImageOfApp.cutIcon}',
                                    fit: BoxFit.fill,
                                    color: Colors.black,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: FsDimens.space24,
                              ),
                              Text("${Strings.signUpText}",
                                  style: TextStyle(
                                      color: universalColor,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 7,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: monstExtrabold)),
                              SizedBox(
                                height: FsDimens.space20,
                              ),
                              emailField(),
                              SizedBox(
                                height: FsDimens.space20,
                              ),
                              fNameField(),
                              SizedBox(
                                height: FsDimens.space20,
                              ),
                              lNameField(),
                              SizedBox(
                                height: FsDimens.space20,
                              ),
                              passwordField(),
                              SizedBox(
                                height: FsDimens.space60,
                              ),
                              submitButton(),
                              SizedBox(
                                height: FsDimens.space24,
                              ),
                              sIgnIn(),
                              SizedBox(
                                height: FsDimens.space24,
                              ),
                            ],
                          ),
                        )),
                    LoaderIndicator(_isLoading)
                  ],
                ),
              ),
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return AllInputDesign(
        key: Key("email"),
        inputHeaderName: '${Strings.emailText}',
        controller: regEmailCon,
        textInputAction: TextInputAction.next,
        focusNode: emailFocus,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(fNameFocus)},
        hintText: '${Strings.emailTextHint}',
        validatorFieldValue: '${Strings.emailTextHint}',
        validator: validEmailField,
        keyBoardType: TextInputType.emailAddress);
  }

  Widget fNameField() {
    return AllInputDesign(
        key: Key("Fname"),
        inputHeaderName: '${Strings.firstName}',
        controller: fNameCon,
        focusNode: fNameFocus,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(lNameFocus)},
        textInputAction: TextInputAction.next,
        hintText: '${Strings.firstNameHint}',
        validatorFieldValue: '${Strings.firstNameHint}',
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget lNameField() {
    return AllInputDesign(
        key: Key("lname"),
        inputHeaderName: '${Strings.lastName}',
        controller: lNameCon,
        focusNode: lNameFocus,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(passwordFocus)},
        textInputAction: TextInputAction.next,
        hintText: '${Strings.lastNameHint}',
        validatorFieldValue: '${Strings.lastNameHint}',
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget passwordField() {
    return AllInputDesign(
      key: Key("password"),
      inputHeaderName: '${Strings.passwordText}',
      controller: regPasswordCon,
      focusNode: passwordFocus,
      textInputAction: TextInputAction.done,
      hintText: "${Strings.passwordTextHint}",
      validatorFieldValue: "${Strings.passwordTextHint}",
      validator: validPasswordField,
      obsecureText: true,
      keyBoardType: TextInputType.visiblePassword,
    );
  }

  Widget submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GreenButton(
        key: Key('login_button'),
        buttonName: "Sign in",
        onPressed: () {
          _onPressSubmitButton();
        },
      ),
    );
  }

  Widget sIgnIn() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: new Text(
              "${Strings.privacyText}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black26,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: FsDimens.space20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${Strings.alreadyAccount} ",
                style: TextStyle(
                    color: Color(0xff25272B),
                    fontSize: 17,
                    // fontSize: SizeConfig.blockSizeHorizontal * 5,
                    fontWeight: FontWeight.w900,
                    fontFamily: sansSemiBold,
                    letterSpacing: 0.6),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  "${Strings.signInButtonInSignUp}",
                  style: TextStyle(
                      color: Color(0xFF00B864),
                      fontSize: SizeConfig.blockSizeHorizontal * 5,
                      fontFamily: sansSemiBold,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onPressSubmitButton() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (regEmailCon.text.toString().trim().isEmpty) {
      return showToastMessage("${Strings.emailIsEmpty}", context);
    } else if (regEmailCon.text.toString().trim().isNotEmpty &&
        !regExp.hasMatch(regEmailCon.text.toString().trim())) {
      return showToastMessage("${Strings.validEmail}", context);
    } else if (fNameCon.text.toString().trim().isEmpty) {
      return showToastMessage("${Strings.fNmaeIsEmpty}", context);
    } else if (lNameCon.text.toString().isEmpty) {
      return showToastMessage("${Strings.lNameIsEmpty}", context);
    } else if (regPasswordCon.text.toString().isEmpty) {
      return showToastMessage("${Strings.passwordIsEmpty}", context);
    } else if (regPasswordCon.text.toString().isNotEmpty &&
        regPasswordCon.text.toString().trim().length < 6) {
      return showToastMessage("${Strings.validpassword}", context);
    } else {
      logInwithApi();
    }
  }

  logInwithApi() async {
    setState(() {
      _isLoading = true;
    });

    var headers = {
      'Accept': 'application/json',
      'X-Shopify-Storefront-Access-Token': '${Strings.accessToken}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('${Strings.baseUrl}'));
    request.body =
        '''{"query":" mutation {\\r\\n  customerCreate(\\r\\n    input: {\\r\\n      firstName: \\"${fNameCon.text.toString()}\\",\\r\\n      lastName: \\"${lNameCon.text.toString()}\\",\\r\\n      email: \\"${regEmailCon.text.toString()}\\"\\r\\n      password: \\"${regPasswordCon.text.toString()}\\"\\r\\n     \\r\\n    }\\r\\n  ) {\\r\\n    customer {\\r\\n    id\\r\\n    firstName\\r\\n    lastName\\r\\n    email\\r\\n    \\r\\n    }\\r\\n    customerUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      dynamic responseJson = await response.stream.bytesToString();
      print(responseJson);
      dynamic mujson = json.decode(responseJson);
      dynamic responsedata = mujson['data'];

      dynamic varjson = responsedata['customerCreate'];
      print(varjson);
      Map<String, dynamic> customer = varjson['customer'];
      print("@@@@@@@@@@@@@@@@@@@@" + customer.toString());
      if (varjson != null) {
        dynamic customerUserErrors = varjson['customerUserErrors'];
        if (customer != null) {
          var fName = customer['firstName'];
          var lName = customer['lastName'];
          var email = customer['email'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', email);
          logInApi(fName, lName);
        } else {
          dynamic showError = customerUserErrors[0]['message'];
          return showToastMessage(showError, context);
        }
      } else {
        dynamic errorMessage =
            'Creating Customer Limit exceeded. Please try again later.';
        print(errorMessage);
        return showToastMessage(errorMessage, context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  logInApi(fName, lName) async {
    setState(() {
      _isLoading = true;
    });
    var headers = {
      'Accept': 'application/json',
      'X-Shopify-Storefront-Access-Token': 'cda4fb2c7736fc030e88e093ed5e1aae',
      'Content-Type': 'application/json',
      // 'Cookie':
      //     '_y=c99fa2c4-b45b-4efc-bf7c-d546ac8ed574; _s=0671c72b-d479-4d77-ad6c-506839a16597; _shopify_y=c99fa2c4-b45b-4efc-bf7c-d546ac8ed574; _shopify_s=0671c72b-d479-4d77-ad6c-506839a16597'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://getbitetime.myshopify.com/api/2021-04/graphql.json'));
    request.body =
        '''{"query":" mutation {\\r\\n    customerAccessTokenCreate(input: {\\r\\n      email: \\"${regEmailCon.text.toString()}\\"\\r\\n      password: \\"${regPasswordCon.text.toString()}\\"\\r\\n    }) {\\r\\n    customerAccessToken {\\r\\n      accessToken\\r\\n      expiresAt\\r\\n    }\\r\\n    customerUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n}\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      dynamic responseJson = await response.stream.bytesToString();

      dynamic mujson = json.decode(responseJson);

      dynamic varjson = mujson['data']['customerAccessTokenCreate'];

      Map<String, dynamic> token = varjson['customerAccessToken'];

      dynamic customer = varjson['customerUserErrors'];

      if (token != null) {
        if (token['accessToken'] != null) {
          var tokenLogin = token['accessToken'];

          data = {
            'id': tokenLogin.toString(),
            'lastName': lName.toString(),
            'firstName': "Hi ${fName.toString()}"
          };
          print(data.toString());
          saveToken(json.encode(data).toString());
          navigationToHomePage(fName);
        }
      } else {
        dynamic showerror = customer[0]['message'];
        if (showerror == 'Unidentified customer') {
          return showToastMessage('Incorrect email or password', context);
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  saveToken(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('TOKEN', data.toString());
  }

  navigationToHomePage(fName) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginSplash(data: fName)));
  }
}
