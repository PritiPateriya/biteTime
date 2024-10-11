import 'dart:convert';

import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/mytextfield.dart';
import 'package:bitetime/common_files/sizedbox_common.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/common_files/validation.dart';
import 'package:bitetime/screens/login_splash.dart';
import 'package:bitetime/screens/registration.dart';
import 'package:bitetime/screens/slide_screens.dart';
import 'package:bitetime/strings/asset_image.dart';
import 'package:bitetime/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../common_files/media_quary_size_type.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  final bool isFromOnbord;
  Login({
    Key key,
    this.isFromOnbord,
  });
  @override
  _LoginState createState() => _LoginState();
}

dynamic data;

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode;
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  bool _isLoading;
  bool whareFrom;
  @override
  void initState() {
    whareFrom = widget.isFromOnbord;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //       statusBarColor: Colors.white,
    //       statusBarIconBrightness: Brightness.dark),
    // );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarThem,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        allFieldOfInputContainer(),
                        Expanded(child: Container()),
                        bottomView(),
                      ],
                    ),
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

  Widget allFieldOfInputContainer() {
    return Column(
      children: [
        CommonSized(FsDimens.space24),
        GestureDetector(
          onTap: () {
            // ignore: unnecessary_statements
            //   whareFrom == true ? Navigator.of(context).pop() : null;
//Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SliderScreen()));
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 18,
              child: Image.asset(
                '${AssetImageOfApp.cutIcon}',
                color: Colors.black,
                fit: BoxFit.fill,
                // height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ),
        CommonSized(FsDimens.space40),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("${Strings.signIn}",
              style: TextStyle(
                  color: universalColor,
                  fontSize: SizeConfig.blockSizeHorizontal * 8,
                  fontWeight: FontWeight.bold,

                  //fontStyle: TextStyle(fontWeight: FontWeight.bold),
                  letterSpacing: 0.5,
                  fontFamily: monstExtrabold)),
        ),
        CommonSized(FsDimens.space28),
        Align(alignment: Alignment.center, child: emailField()),
        CommonSized(FsDimens.space20),
        passwordField(),
        CommonSized(FsDimens.space20),
      ],
    );
  }

  Widget emailField() {
    return AllInputDesign(
        key: Key("${Strings.emailKey}"),
        focusNode: emailFocus,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(passwordFocus)},
        textInputAction: TextInputAction.next,
        inputHeaderName: '${Strings.emailTextHint}',
        controller: emailCon,
        hintText: '${Strings.emailTextHint}',
        validatorFieldValue: '${Strings.emailTextHint}',
        validator: validEmailField,
        keyBoardType: TextInputType.emailAddress);
  }

  Widget passwordField() {
    return Align(
      alignment: Alignment.center,
      child: AllInputDesign(
        key: Key("${Strings.passwordKey}"),
        focusNode: passwordFocus,
        textInputAction: TextInputAction.done,
        inputHeaderName: "${Strings.passwordTextHint}",
        controller: passwordCon,
        hintText: "************",
        validatorFieldValue: "${Strings.passwordTextHint}",
        validator: validPasswordField,
        obsecureText: true,
        keyBoardType: TextInputType.visiblePassword,
      ),
    );
  }

  //List<Product> products = [];

  Widget submitButton() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          child: GreenButton(
            key: Key('${Strings.signInButtonKey}'),
            buttonName: "${Strings.signInButton}",
            onPressed: () {
              _onPressSubmitButton();
              // var products = shopifyStore.getAllProducts();
              // print(products);
            },
          ),
        ));
  }

  Widget bottomView() {
    return Column(
      children: [
        Align(alignment: Alignment.center, child: submitButton()),
        CommonSized(FsDimens.space20),
        Align(alignment: Alignment.center, child: forGotPass()),
        CommonSized(FsDimens.space20),
      ],
    );
  }

  Widget forGotPass() {
    return Column(
      children: [
        Center(
            child: new InkWell(
                child: new Text(
                  '${Strings.forgotPasswordButton}',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                })),
        CommonSized(FsDimens.space20),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${Strings.donthaveAcc}',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.2,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Registration()));
                },
                child: Text(
                  "${Strings.createAcc}",
                  style: TextStyle(
                      color: Color(0xFF00B864),
                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                      fontWeight: FontWeight.w900,
                      fontFamily: sourceSansPro,
                      letterSpacing: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//LoginSplash(data: fName)
  navigationToDashBord(fName) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginSplash(data: fName),
      ),
      (route) => false,
    );
  }

  _onPressSubmitButton() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (emailCon.text.toString().trim().isEmpty) {
      return showToastMessage("${Strings.emailIsEmpty}", context);
    } else if (emailCon.text.toString().trim().isNotEmpty &&
        !regExp.hasMatch(emailCon.text.toString().trim())) {
      return showToastMessage("${Strings.validEmail}", context);
    } else if (passwordCon.text.toString().isEmpty) {
      return showToastMessage("${Strings.passwordIsEmpty}", context);
    } else if (passwordCon.text.toString().isNotEmpty &&
        passwordCon.text.toString().trim().length < 6) {
      return showToastMessage("${Strings.validpassword}", context);
    } else {
      logInApi();
    }
  }

  logInApi() async {
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
        '''{"query":" mutation {\\r\\n    customerAccessTokenCreate(input: {\\r\\n      email: \\"${emailCon.text.toString()}\\"\\r\\n      password: \\"${passwordCon.text.toString()}\\"\\r\\n    }) {\\r\\n    customerAccessToken {\\r\\n      accessToken\\r\\n      expiresAt\\r\\n    }\\r\\n    customerUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n}\\r\\n}","variables":{}}''';

    var login =
        '''{"query":" mutation {\\r\\n    customerAccessTokenCreate(input: {\\r\\n      email: \\"${emailCon.text.toString()}\\"\\r\\n      password: \\"${passwordCon.text.toString()}\\"\\r\\n    }) {\\r\\n    customerAccessToken {\\r\\n      accessToken\\r\\n      expiresAt\\r\\n    }\\r\\n    customerUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n}\\r\\n}","variables":{}}''';
    print("$login");

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
      print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + '$mujson');

      dynamic customer = varjson['customerUserErrors'];

      if (token != null) {
        if (token['accessToken'] != null) {
          var tokenLogin = token['accessToken'];
          return getUserInfo(tokenLogin);
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

  getUserInfo(var tokenLogin) async {
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
        '''{"query":"{\\r\\n  customer(customerAccessToken: \\"$tokenLogin\\"){\\r\\n    email\\r\\n    firstName\\r\\n    lastName\\r\\n    id\\r\\n    phone\\r\\n    }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      dynamic mujson = json.decode(responseJson);
      print("login_res...${mujson.toString()}");
      CommonFunctions().console(mujson);
      var fName = mujson['data']['customer']['firstName'];
      var lName = mujson['data']['customer']['lastName'];
      var email = mujson['data']['customer']['email'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      data = {
        'id': tokenLogin.toString(),
        'lastName': lName.toString(),
        'firstName': "Hi ${fName.toString()}"
      };
      print("123456789" + data.toString());
      saveToken(json.encode(data).toString());
      navigationToDashBord(fName);
    } else {
      print(response.reasonPhrase);
    }
  }

  saveToken(data) async {
    print("======================" + data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('TOKEN', data.toString());
  }

  Widget heightSpaceBetween(height) {
    return SizedBox(
      height: height,
    );
  }
}
