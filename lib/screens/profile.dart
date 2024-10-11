import 'dart:convert';

import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/mytextfield.dart';
import 'package:bitetime/common_files/validation.dart';
import 'package:bitetime/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../common_files/loader_indicator.dart';
import '../common_files/logger_print.dart';
import '../common_files/sizedbox_common.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  FocusNode nyFocusNode;
  TextEditingController proEmailCon = TextEditingController();
  TextEditingController proPasswordCon = TextEditingController();
  TextEditingController proCPasswordCon = TextEditingController();
  TextEditingController proFNameCon = TextEditingController();
  TextEditingController proLNameCon = TextEditingController();
  TextEditingController proCompanyCon = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode fNameFocus = FocusNode();
  final FocusNode lNameFocus = FocusNode();
  final FocusNode passwordCFocus = FocusNode();
  final FocusNode passwordNFocus = FocusNode();
  final FocusNode cNameFocus = FocusNode();
  dynamic data;
  bool _isLoading;
  bool showLoading;
  dynamic firstName;
  dynamic lastName;
  dynamic emailAddress;
  var fName;
  var lName;
  var email;
  var responseToken;

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _isLoading = true;
    getToken();
    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseJson = prefs.getString('TOKEN');
    var res = json.decode(responseJson);
    print("$res");
    setState(() {
      responseToken = res['id'];
      getUserInfo(responseToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: _isLoading == true
            ? LoaderIndicator(_isLoading)
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
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
                            children: [
                              CommonSized(FsDimens.space14),
                              emailField(),
                              CommonSized(FsDimens.space20),
                              fNameField(),
                              CommonSized(FsDimens.space20),
                              lNameField(),
                              CommonSized(FsDimens.space20),
                              //  newPasswordField(),
                              Container(
                                height: MediaQuery.of(context).size.height / 3,
                              ),
//CommonSized(FsDimens.space32),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: submitButton()),
                              CommonSized(FsDimens.space28),
                            ],
                          ),
                        ),
                      ),
                      showLoading == true
                          ? LoaderIndicator(showLoading)
                          : Container()
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget emailField() {
    return AllInputDesignProfile(
        key: Key("email"),
        inputHeaderName: 'Email*',
        controller: proEmailCon,
        focusNode: emailFocus,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(fNameFocus)},
        hintText: '$email',

        // hintText: 'Email',
        validatorFieldValue: 'Email',
        validator: validEmailField,
        textInputAction: TextInputAction.next,
        keyBoardType: TextInputType.emailAddress);
  }

  Widget fNameField() {
    return AllInputDesignProfile(
        key: Key("Fname"),
        inputHeaderName: 'First name*',
        controller: proFNameCon,
        focusNode: fNameFocus,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(lNameFocus)},
        hintText: '$fName',
        // hintText: 'First name',
        validatorFieldValue: 'First name',
        validator: userNameValidation,
        textInputAction: TextInputAction.next,
        keyBoardType: TextInputType.name);
  }

  Widget lNameField() {
    return AllInputDesignProfile(
        key: Key("lname"),
        inputHeaderName: 'Last name*',
        controller: proLNameCon,
        focusNode: lNameFocus,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(passwordNFocus)},
        hintText: '$lName',
        //  hintText: 'Last name',
        validatorFieldValue: 'Last name',
        validator: userNameValidation,
        textInputAction: TextInputAction.next,
        keyBoardType: TextInputType.name);
  }

  Widget comNameField() {
    return AllInputDesign(
        key: Key("com_name"),
        inputHeaderName: 'Company (optional)',
        controller: proCompanyCon,
        focusNode: cNameFocus,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(passwordCFocus)},
        hintText: 'Company name',
        validatorFieldValue: 'Company name',
        validator: userNameValidation,
        textInputAction: TextInputAction.next,
        keyBoardType: TextInputType.name);
  }

  Widget newPasswordField() {
    return AllInputDesign(
      key: Key("pro_new_password"),
      inputHeaderName: 'New password*',
      controller: proPasswordCon,
      focusNode: passwordNFocus,
      hintText: "New password",
      validatorFieldValue: "New password",
      validator: validPasswordField,
      obsecureText: true,
      textInputAction: TextInputAction.done,
      keyBoardType: TextInputType.visiblePassword,
    );
  }

  Widget submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GreenButton(
        key: Key('login_button'),
        buttonName: "Save",
        onPressed: () {
          inPressSaveButton();
        },
      ),
    );
  }

  inPressSaveButton() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (proEmailCon.text.toString().trim().isNotEmpty &&
        !regExp.hasMatch(proEmailCon.text.toString().trim())) {
      return showToastMessage("${Strings.validEmail}", context);
    } else if (proPasswordCon.text.toString().trim().isNotEmpty &&
        proPasswordCon.text.toString().trim().length < 6) {
      return showToastMessage("${Strings.validpassword}", context);
    } else {
      customerUpdate();
    }
  }

  saveToken(data) async {
    print("======================" + data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('TOKEN', data.toString());
  }

  getUserInfo(responseToken) async {
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
        '''{"query":"{\\r\\n  customer(customerAccessToken: \\"$responseToken\\"){\\r\\n    email\\r\\n    firstName\\r\\n    lastName\\r\\n    id\\r\\n    phone\\r\\n    }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      CommonFunctions().console(responseJson);
      setState(() {
        _isLoading = false;
      });
      dynamic mujson = json.decode(responseJson);

      CommonFunctions().console(mujson);
      fName = mujson['data']['customer']['firstName'];
      lName = mujson['data']['customer']['lastName'];
      email = mujson['data']['customer']['email'];
      var tokenLogin = responseToken;
      if (showLoading == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", email);
        data = {
          'id': tokenLogin.toString(),
          'lastName': lName.toString(),
          'firstName': fName.toString()
        };
        setState(() {
          saveToken(json.encode(data).toString());
          showLoading = false;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  customerUpdate() async {
    setState(() {
      proEmailCon.text.toString().trim().isEmpty
          ? emailAddress = email
          : emailAddress = proEmailCon.text.toString().trim();
      proFNameCon.text.toString().trim().isEmpty
          ? firstName = fName
          : firstName = proFNameCon.text.toString().trim();
      proLNameCon.text.toString().trim().isEmpty
          ? lastName = lName
          : lastName = proFNameCon.text.toString().trim();
      showLoading = true;
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
        '''{"query":"mutation customerUpdate(\$customerAccessToken: String!, \$customer: CustomerUpdateInput!) {\\r\\n  customerUpdate(customerAccessToken: \$customerAccessToken, customer: \$customer) {\\r\\n    customer {\\r\\n      id\\r\\n    }\\r\\n    customerAccessToken {\\r\\n      accessToken\\r\\n      expiresAt\\r\\n    }\\r\\n    customerUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n  }\\r\\n}\\r\\n","variables":{"customerAccessToken":"$responseToken","customer":{"firstName":"${firstName.toString()}","lastName":"${lastName.toString()}","email":"${emailAddress.toString()}","password":"${proPasswordCon.text.toString()}"}}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      CommonFunctions().console(responseJson);
      dynamic mujson = json.decode(responseJson);
      var tocken = mujson['data']['customerUpdate']['customerAccessToken']
          ['accessToken'];
      CommonFunctions().console(tocken);
      setState(() {
        removeTokenFromDisk();
        proEmailCon.clear();
        proFNameCon.clear();
        proLNameCon.clear();
        proCPasswordCon.clear();
        proCompanyCon.clear();
        proPasswordCon.clear();
        getUserInfo(tocken);
        showToastMessage('Profile update success', context);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  removeTokenFromDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("TOKEN");
  }
}
