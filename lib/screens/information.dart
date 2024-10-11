import 'dart:convert';

import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/mytextfield.dart';
import 'package:bitetime/common_files/sizedbox_common.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/common_files/validation.dart';
import 'package:bitetime/screens/shipping.dart';
import 'package:http/http.dart' as http;
//import 'package:bitetime/screens/shipping.dart';
import 'package:bitetime/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Information extends StatefulWidget {
  // const Information({Key key}) : super(key: key);
  dynamic informationId;
  dynamic quntity;
  dynamic amount;
  Information({Key key, this.informationId, this.quntity, this.amount});

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  FocusNode myFocusNode;
  SharedPreferences preferences;
  FocusNode ffNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode lableFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode address2FocusNode = FocusNode();
  FocusNode cityConFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipConFocusNode = FocusNode();
  TextEditingController fNameCon = TextEditingController();
  TextEditingController lNameCon = TextEditingController();
  TextEditingController labelCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController address2Con = TextEditingController();
  TextEditingController cityCon = TextEditingController();
  TextEditingController zipCon = TextEditingController();
  TextEditingController phoneNumberCon = TextEditingController();

  List<String> _locations = [
    'indiana',
    'New york',
    'Usa',
    'lowa',
    'Order',
    //'Biteparks'
  ];
  String _selectedLocation;

  var howMuch;
  var pri;
  var num2;
  final _formKey = GlobalKey<FormState>();
  dynamic informationId;
  dynamic id;
  dynamic email;
  dynamic customerInformationId;
  bool showState;
  dynamic provinces = [];
  var values = [];
  String selectedCountry;
  String selectedState;
  var fName;
  var lName;
  var addressinfo;
  var comlebal;
  var responseToken;
  double checkoutAmount = 0.0;
  var cityinfo;
  var zipinfo;
  var stateinfo;
  var addresinfo;

  @override
  void initState() {
    print("============+ ${widget.amount}");
    checkoutAmount = 0.0;
    howMuch = widget.quntity;
    // getQuantity();
    initializePreference().whenComplete(() {
      setState(() {
        var responseJson = this.preferences.getString('TOKEN');
        var res = json.decode(responseJson);
        print("$res");
        responseToken = res['id'];
      });
    });
    // getToken();
    print("################" + "${widget.informationId}");
    countryApi();
    showState = true;
    customerInformationId = widget.informationId;
    print("$customerInformationId");
    super.initState();
  }

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
  }

  // getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print("Email..." + prefs.getString("email"));
  //   var responseJson = prefs.getString('TOKEN');
  //   var res = json.decode(responseJson);
  //   print("$res");
  //   setState(() {
  //     responseToken = res['id'];
  //     // getUserInfo(responseToken);
  //   });
  // }

  dynamic people;
  var vid;

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
                Navigator.pop(context);
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
        title: Text("Information", style: newAppbartextStyle),
      ),
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context)..requestFocus(FocusNode());
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    nameField(),
                    CommonSized(FsDimens.space14),
                    lastnameField(),
                    CommonSized(FsDimens.space14),
                    comNameField(),
                    CommonSized(FsDimens.space14),
                    address(),
                    CommonSized(FsDimens.space14),
                    address2(),
                    CommonSized(FsDimens.space14),
                    city(),
                    CommonSized(FsDimens.space14),
                    countryDropDown(),
                    //  CommonSized(FsDimens.space14),
                    Row(
                      children: [
                        zipField(),
                        SizedBox(
                          width: FsDimens.space14,
                        ),
                        stateDropDown()
                        // stateField(),
                      ],
                    ),
                    //CommonSized(FsDimens.space1),
                    phoneNumber(),
                    CommonSized(FsDimens.space32),
                    addtoOrderButton(),
                    CommonSized(FsDimens.space14),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nameField() {
    return AllInputDesign(
        key: Key("info_name"),
        inputHeaderName: "${Strings.firstName}",
        controller: fNameCon,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(lNameFocus)},
        hintText: "${this.preferences.getString("first_name")}",
        //   hintText: '$fName',
        //  validatorFieldValue: "${this.preferences.getString("first_name")}",
        validatorFieldValue: "${Strings.firstNameHint}",
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget lastnameField() {
    return AllInputDesign(
        key: Key("info_lastname"),
        inputHeaderName: "${Strings.lastName}",
        controller: lNameCon,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(lableFocusNode)},
        hintText: "${this.preferences.getString("last_name")}",
        // hintText: '$lName',
        validatorFieldValue: "${Strings.lastNameHint}",
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget comNameField() {
    return AllInputDesign(
        key: Key("com_name"),
        inputHeaderName: "${Strings.labelCon}",
        controller: labelCon,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(addressFocusNode)},
        hintText: "${this.preferences.getString("company")}",
        validatorFieldValue: "${Strings.labelConHint}",
        validator: userNameValidation,
        textInputAction: TextInputAction.next,
        keyBoardType: TextInputType.name);
  }

  Widget address() {
    return AllInputDesign(
      key: Key("Address"),
      inputHeaderName: "${Strings.addressCon}",
      hintText: "${this.preferences.getString("address1")}",
      controller: addressCon,
      onEditingComplete: () =>
          {FocusScope.of(context).requestFocus(address2FocusNode)},
      validatorFieldValue: "${Strings.addressConHint}",
      validator: userNameValidation,
      textInputAction: TextInputAction.next,
    );
  }

  Widget address2() {
    return AllInputDesign(
      key: Key(" Address2"),
      inputHeaderName: "${Strings.address2Con}",
      hintText: "${this.preferences.getString("address2")}",
      controller: address2Con,
      onEditingComplete: () =>
          {FocusScope.of(context).requestFocus(cityConFocusNode)},
      validatorFieldValue: "${Strings.address2Con}}",
      validator: userNameValidation,
      textInputAction: TextInputAction.next,
    );
  }

  Widget city() {
    return AllInputDesign(
      key: Key("City "),
      inputHeaderName: "${Strings.cityCon}",
      hintText: "${this.preferences.getString("city")}",
      controller: cityCon,
      onEditingComplete: () =>
          {FocusScope.of(context).requestFocus(zipConFocusNode)},
      validatorFieldValue: "${Strings.cityConHint}",
      validator: userNameValidation,
      textInputAction: TextInputAction.next,
      keyBoardType: TextInputType.text,
    );
  }

  Widget countryDropDown() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Country*",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          child: DropdownButtonFormField(
            focusNode: countryFocusNode,
            hint: Text(
              "Country",
              // "${this.preferences.getString("city")}",
              style: TextStyle(
                color: Color(0xFF66676E),
                fontSize: 18,
              ),
            ),
            //  hint: "${this.preferences.getString("city")}",
            items: values.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item['name'],
                child: Text(item['name']),
              );
            }).toList(),
            value: selectedCountry != null ? selectedCountry : null,
            onChanged: (newValue) {
              print('******** newValue $newValue');
              selectedCountry = newValue;
              getSelectedCountryId(newValue);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 0, 15, 0),
              labelStyle: TextStyle(color: Colors.green, fontSize: 14),
              focusColor: Colors.green,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey[300])),
              fillColor: Colors.green,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
      ],
    );
  }

  Widget phoneNumber() {
    return AllInputDesign(
      key: Key("Phone number"),
      inputHeaderName: "${Strings.phoneCon}",

      hintText: "${this.preferences.getString("phone_number")}",
      // onEditingComplete: () =>
      //     {FocusScope.of(context).requestFocus(addressFocusNode)},
      validatorFieldValue: "phone_number",
      validator: validPhoneNumber,
      textInputAction: TextInputAction.done,
      keyBoardType: TextInputType.phone,
    );
  }

  Widget zipField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Zip*",
          style: labelHintFontStyle,
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          height: 50.0,
          width: ((43.5 / 100) * MediaQuery.of(context).size.width),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Colors.black12, width: 0.2),
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            cursorColor: Colors.grey,
            style: TextStyle(
                color: Color(0xFF1F2D3D),
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                fontFamily: sourceSansPro),
            // keyboardType:
            // validator: ,
            controller: zipCon,
            // onChanged:
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0XFFFFFFFF),
                hintText: "${this.preferences.getString("zip_code")}",
                hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontFamily: sourceSansPro,
                    fontWeight: FontWeight.w800),
                // errorText: widget.errorText,
                errorStyle: TextStyle(
                    /*fontFamily: monsterdRegular*/),
                contentPadding: const EdgeInsets.only(left: 8, top: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.black54, width: 0.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.black54, width: 0.2),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.black54, width: 0.2))),
          ),
        ),
      ],
    );
  }

  Widget stateDropDown() {
    // print("countries");
    if (showState == false) {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 90, top: 8),
              child: Text(
                "State*",
                style: labelHintFontStyle,
              ),
            ),
          ),
          Container(
            height: 50.0,
            width: ((42 / 100) * MediaQuery.of(context).size.width),
            margin: EdgeInsets.only(
                // top: 15,
                ),
            child: DropdownButtonFormField(
              focusNode: stateFocusNode,
              hint: Text(
                "State",
                style: TextStyle(
                  color: Color(0xFF66676E),
                  fontSize: 18,
                ),
              ),
              items: provinces.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item['name'],
                  child: Text(item['name']),
                );
              }).toList(),
              value: selectedState != null ? selectedState : null,
              onChanged: (newValue) {
                //  print("countries");
                selectedState = newValue;
                //  FocusScope.of(context).requestFocus(phoneNumberCon);
                getSelectedCountryId(newValue);
              },
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                labelStyle: TextStyle(color: Colors.green, fontSize: 14),
                focusColor: Colors.green,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey[300])),
                fillColor: Colors.green,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          SizedBox(
            height: FsDimens.space20,
          ),
        ],
      );
    }
  }

  Widget stateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "State",
          style: labelHintFontStyle,
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          height: 45.0,
          width: ((43.5 / 100) * MediaQuery.of(context).size.width),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Colors.black45, width: 0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(
                  '${_locations[0]}',
                  style: TextStyle(
                    color: Color(0xFF1F2D3D),
                    fontSize: 14,
                  ),
                ),
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                },
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  // Add this
                  size: 10, // Add this
                ),
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    child: new Text(
                      location,
                      style: TextStyle(
                        color: Color(0xFF1F2D3D),
                        fontSize: 18,
                      ),
                    ),
                    value: location,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget addtoOrderButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // pri = double.parse(howMuch['price']);
      // pfinal = pri * _count;
      // num2 = double.parse(pfinal.toStringAsFixed(3));
      //CommonFunctions().console(num2);
      // var screenSize = MediaQuery.of(context).size.width - 40;
      child: GestureDetector(
        onTap: () {
          onInformationSubmit();
        },
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ShippingScreen()));
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
                          String.fromCharCodes(Runes(
                            '\u0024' + "${widget.amount}",
                          )),
                          // '\u0024' + "${widget.amount}",
                          style: TextStyle(
                            fontFamily: monsterdRegular,
                            color: Colors.white,
                            fontSize: 18,
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
    );
  }

  getSelectedCountryId(dynamic countries) {
    CommonFunctions().console(countries);
    for (dynamic object in values) {
      var stateId = object['name'];
      if (stateId == countries) {
        setState(() {
          provinces = object['provinces'];
          //FocusScope.of(context).requestFocus(stateFocusNode);

          if (provinces.length == 0) {
            showState = false;
            FocusScope.of(context).requestFocus(zipConFocusNode);
          } else {
            showState = true;
            FocusScope.of(context).requestFocus(stateFocusNode);
          }
        });
        CommonFunctions().console(provinces);
      }
    }
  }

  onInformationSubmit() {
    if (fNameCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter First Name", context);
    } else if (lNameCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter Last Name", context);
    }
    //  else if (labelCon.text.toString().trim().isEmpty) {
    //   return showToastMessage("Enter label", context);
    // }
    else if (addressCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter Address.", context);
    } else if (cityCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter City.", context);
    } else if (selectedCountry == null) {
      return showToastMessage("Select Country.", context);
    } else if (showState == true && selectedState == null) {
      return showToastMessage("Select state", context);
    } else if (zipCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter zip", context);
    }
    // else if (phoneNumberCon.text.toString().trim().isNotEmpty) {
    //   return showToastMessage("Enter Phone Number", context);
    // }
    else {
      saveCheckoutInfo();
      addInformations();
    }
  }

  saveCheckoutInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('first_name', fNameCon.text.toString().trim());
    prefs.setString('last_name', lNameCon.text.toString().trim());
    prefs.setString('company', labelCon.text.toString().trim());
    prefs.setString('address1', addressCon.text.toString().trim());
    prefs.setString('address2', address2Con.text.toString().trim());
    prefs.setString('city', cityCon.text.toString().trim());
    prefs.setString('state', selectedState.trim());
    prefs.setString('zip_code', zipCon.text.toString().trim());
    prefs.setString('phone_number', phoneNumberCon.text.toString().trim());
  }

  addInformations() async {
    var headers = {
      'Accept': 'application/json',
      'X-Shopify-Storefront-Access-Token': 'cda4fb2c7736fc030e88e093ed5e1aae',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://getbitetime.myshopify.com/api/2021-04/graphql.json'));
    // request.body =
    //     '''{"query":"mutation checkoutShippingAddressUpdate(\$shippingAddress: MailingAddressInput!, \$checkoutId: ID!) {\\n  checkoutShippingAddressUpdate(\\n    shippingAddress: \$shippingAddress\\n    checkoutId: \$checkoutId\\n  ) {\\n    checkout {\\n    id\\n      webUrl\\n    }\\n    checkoutUserErrors {\\n      code\\n      field\\n      message\\n    }\\n  }\\n}","variables":{"shippingAddress":{"address1":"${addressCon.text.toString()}","address2":"${address2Con.text.toString()}","city":"${cityCon.text.toString()}","firstName":"${fNameCon.text.toString()}","lastName":"${lNameCon.text.toString()}","country":"$selectedCountry","zip":"${zipCon.text.toString()}","province":"$selectedState","company":"${labelCon.text.toString()}","phone":"${phoneNumberCon.text.toString()}"},"checkoutId": "$customerInformationId"}}''';

    request.body =
        '''{"query":"mutation checkoutShippingAddressUpdateV2(\$shippingAddress: MailingAddressInput!, \$checkoutId: ID!) {\\n  checkoutShippingAddressUpdateV2(shippingAddress: \$shippingAddress, checkoutId: \$checkoutId) {\\n    userErrors {\\n      field\\n      message\\n    }\\n    checkout {\\n      id\\n      webUrl\\n    }\\n  }\\n}","variables":{"shippingAddress":{"lastName":"${lNameCon.text.toString()}","firstName":"${fNameCon.text.toString()}","address1":"${addressCon.text.toString()}","address2":"${address2Con.text.toString()}","province":"$selectedState","country":"$selectedCountry","zip":"${zipCon.text.toString()}","city":"${cityCon.text.toString()}","company":"${labelCon.text.toString()}","phone":"${phoneNumberCon.text.toString()}"},"checkoutId":"$customerInformationId"}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responsejson = await response.stream.bytesToString();
      print(responsejson);
      dynamic responseData = json.decode(responsejson);
      dynamic responsedata = responseData['data'];
      dynamic varjson = responsedata['checkoutShippingAddressUpdateV2'];
      print(varjson);
      Map<String, dynamic> checkout = varjson['checkout'];

      if (varjson != null) {
        dynamic checkoutUserErrors = varjson["userErrors"];
        if (checkout != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('checkout_id', checkout['id']);
          prefs.setString('web_url', checkout['webUrl']);
          // print("webUrl...${varjson['checkout']['webUrl']}");
          print("webUrl...${checkout['webUrl']}");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShippingScreen()));
          return showToastMessage("Checkout Created.", context);
        } else {
          dynamic showError = checkoutUserErrors[0]['message'];
          return showToastMessage(showError, context);
        }
      }
    } else {
      print(response.reasonPhrase);
      return showToastMessage(response.reasonPhrase, context);
    }
  }

  Future<void> countryApi() async {
    var headers = {
      'Cookie':
          '_master_udr=eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaEpJaWxpTTJRNE1XVXdZaTFsTURsbExUUXdObVl0T0dRNFpTMDJOVEJqWkRoallUZzVaVElHT2daRlJnPT0iLCJleHAiOiIyMDIzLTA1LTEyVDEyOjM4OjM3LjExMloiLCJwdXIiOiJjb29raWUuX21hc3Rlcl91ZHIifX0%3D--6d37ce0159f3ef838cddd4da1b875a9c7140338b; _secure_admin_session_id=3f21340794c72e53babdb760ad8727d9; _secure_admin_session_id_csrf=3f21340794c72e53babdb760ad8727d9; _landing_page=%2Fadmin%2Fauth%2Flogin; _orig_referrer=https%3A%2F%2Fgetbitetime.myshopify.com%2Fadmin%2Fapi%2F2021-04%2Fcountries%2Fcount.json; _shopify_y=187398c0-39d6-4757-b3dc-ecfbca4cfadc; _y=187398c0-39d6-4757-b3dc-ecfbca4cfadc; identity-state=BAhbCEkiJTZiOTg1YzFlYjI4MjExYTY2OTg0NjE0OTRmZjlhMTcyBjoGRUZJIiUxMzRlMWY5YjU1N2U1OGM2M2JlNzUwYTY3OWI4OGNiMgY7AEZJIiUwMGFlNzA1MGVhYWMxMTU5ODQ5ZjdlYzY5ZDkwZmRmZgY7AEY%3D--7965a75efc72d367fe75cf07452f34fd38a85409; identity-state-00ae7050eaac1159849f7ec69d90fdff=BAh7DEkiDnJldHVybi10bwY6BkVUSSI3aHR0cHM6Ly9nZXRiaXRldGltZS5teXNob3BpZnkuY29tL2FkbWluL2F1dGgvbG9naW4GOwBUSSIRcmVkaXJlY3QtdXJpBjsAVEkiQ2h0dHBzOi8vZ2V0Yml0ZXRpbWUubXlzaG9waWZ5LmNvbS9hZG1pbi9hdXRoL2lkZW50aXR5L2NhbGxiYWNrBjsAVEkiEHNlc3Npb24ta2V5BjsAVDoMYWNjb3VudEkiD2NyZWF0ZWQtYXQGOwBUZhcxNjIwODIzMzE5LjAyMTE3NzNJIgpub25jZQY7AFRJIiUyZTcxOTEyNmI1YmZkYTRhYjQyODI0N2NkYzE2NTBhMQY7AEZJIgpzY29wZQY7AFRbDUkiCmVtYWlsBjsAVEkiN2h0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvZGVzdGluYXRpb25zLnJlYWRvbmx5BjsAVEkiC29wZW5pZAY7AFRJIgxwcm9maWxlBjsAVEkiTmh0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvcGFydG5lcnMuY29sbGFib3JhdG9yLXJlbGF0aW9uc2hpcHMucmVhZG9ubHkGOwBUSSIwaHR0cHM6Ly9hcGkuc2hvcGlmeS5jb20vYXV0aC9iYW5raW5nLm1hbmFnZQY7AFRJIjxodHRwczovL2FwaS5zaG9waWZ5LmNvbS9hdXRoL3Nob3BpZnktY2hhdC5hZG1pbi5ncmFwaHFsBjsAVEkiN2h0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvZmxvdy53b3JrZmxvd3MubWFuYWdlBjsAVEkiD2NvbmZpZy1rZXkGOwBUSSIMZGVmYXVsdAY7AFQ%3D--1f9f4eb71de9a92c4a9ef8343106fe5449ecfbbc; identity-state-134e1f9b557e58c63be750a679b88cb2=BAh7DEkiDnJldHVybi10bwY6BkVUSSI3aHR0cHM6Ly9nZXRiaXRldGltZS5teXNob3BpZnkuY29tL2FkbWluL2F1dGgvbG9naW4GOwBUSSIRcmVkaXJlY3QtdXJpBjsAVEkiQ2h0dHBzOi8vZ2V0Yml0ZXRpbWUubXlzaG9waWZ5LmNvbS9hZG1pbi9hdXRoL2lkZW50aXR5L2NhbGxiYWNrBjsAVEkiEHNlc3Npb24ta2V5BjsAVDoMYWNjb3VudEkiD2NyZWF0ZWQtYXQGOwBUZhQxNjIwODIzMjY2LjY0MjlJIgpub25jZQY7AFRJIiU3MjgwODRkNzEwNjliMDM5NjQ0NzAyMDgxOTgyZTQ5YwY7AEZJIgpzY29wZQY7AFRbDUkiCmVtYWlsBjsAVEkiN2h0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvZGVzdGluYXRpb25zLnJlYWRvbmx5BjsAVEkiC29wZW5pZAY7AFRJIgxwcm9maWxlBjsAVEkiTmh0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvcGFydG5lcnMuY29sbGFib3JhdG9yLXJlbGF0aW9uc2hpcHMucmVhZG9ubHkGOwBUSSIwaHR0cHM6Ly9hcGkuc2hvcGlmeS5jb20vYXV0aC9iYW5raW5nLm1hbmFnZQY7AFRJIjxodHRwczovL2FwaS5zaG9waWZ5LmNvbS9hdXRoL3Nob3BpZnktY2hhdC5hZG1pbi5ncmFwaHFsBjsAVEkiN2h0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvZmxvdy53b3JrZmxvd3MubWFuYWdlBjsAVEkiD2NvbmZpZy1rZXkGOwBUSSIMZGVmYXVsdAY7AFQ%3D--21541b83ad42a66a2ae2a40e1f5c9f41cd9c5298; identity-state-6b985c1eb28211a6698461494ff9a172=BAh7DEkiDnJldHVybi10bwY6BkVUSSI3aHR0cHM6Ly9nZXRiaXRldGltZS5teXNob3BpZnkuY29tL2FkbWluL2F1dGgvbG9naW4GOwBUSSIRcmVkaXJlY3QtdXJpBjsAVEkiQ2h0dHBzOi8vZ2V0Yml0ZXRpbWUubXlzaG9waWZ5LmNvbS9hZG1pbi9hdXRoL2lkZW50aXR5L2NhbGxiYWNrBjsAVEkiEHNlc3Npb24ta2V5BjsAVDoMYWNjb3VudEkiD2NyZWF0ZWQtYXQGOwBUZhcxNjIwODIzMTE3LjEzMTgxMTRJIgpub25jZQY7AFRJIiU5ZjExZWEyMWFhMjJlZjViMjk4NTIzMjIwOWQwNzU5YwY7AEZJIgpzY29wZQY7AFRbDUkiCmVtYWlsBjsAVEkiN2h0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvZGVzdGluYXRpb25zLnJlYWRvbmx5BjsAVEkiC29wZW5pZAY7AFRJIgxwcm9maWxlBjsAVEkiTmh0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvcGFydG5lcnMuY29sbGFib3JhdG9yLXJlbGF0aW9uc2hpcHMucmVhZG9ubHkGOwBUSSIwaHR0cHM6Ly9hcGkuc2hvcGlmeS5jb20vYXV0aC9iYW5raW5nLm1hbmFnZQY7AFRJIjxodHRwczovL2FwaS5zaG9waWZ5LmNvbS9hdXRoL3Nob3BpZnktY2hhdC5hZG1pbi5ncmFwaHFsBjsAVEkiN2h0dHBzOi8vYXBpLnNob3BpZnkuY29tL2F1dGgvZmxvdy53b3JrZmxvd3MubWFuYWdlBjsAVEkiD2NvbmZpZy1rZXkGOwBUSSIMZGVmYXVsdAY7AFQ%3D--d11e01b1bb92b4b8a804c30b54194b22367e0b8d'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://fcf7c2c27302e9605dfc6fdcba825125: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@getbitetime.myshopify.com/admin/api/2021-04/countries.json'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();

      var mujson = json.decode(responseJson);

      var tmpPriceList = mujson['countries'];

      if (tmpPriceList != null && tmpPriceList.length > 0) {
        values = List.from(tmpPriceList);
        CommonFunctions().console(values);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
