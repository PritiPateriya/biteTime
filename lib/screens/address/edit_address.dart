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
import 'package:bitetime/screens/address/address.dart';
import 'package:bitetime/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditAddress extends StatefulWidget {
  final dynamic editAddresId;
  EditAddress({Key key, this.editAddresId});
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  // List<String> _locations = [
  //   'indiana',
  //   'New york',
  //   'Usa',
  //   'lowa',
  //   'Order',
  //   //'Biteparks'
  // ];
  // String _selectedLocation;

  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode;
  FocusNode lableFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode address2FocusNode = FocusNode();
  FocusNode cityConFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipConFocusNode = FocusNode();
  TextEditingController labelCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController address2Con = TextEditingController();
  TextEditingController cityCon = TextEditingController();
  TextEditingController zipCon = TextEditingController();
  dynamic firstName;
  dynamic lastName;
  dynamic id;
  dynamic customerEditAddId;
  dynamic provinces = [];
  String selectedCountry;
  String selectedState;
  var values = [];
  bool showState;
  // bool _isLoading;
  bool _showCenterLoader = false;
  @override
  void initState() {
    print("################ Pritiiii" + "${widget.editAddresId}");
    countryApi();
    showState = true;

    getToken();
    customerEditAddId = widget.editAddresId;
    print("$customerEditAddId");
    super.initState();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseJson = prefs.getString('TOKEN');
    var res = json.decode(responseJson);
    setState(() {
      firstName = res['firstName'];
      lastName = res['lastName'];
      id = res['id'];
      print(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // body: _isLoading == true
      //     ? LoaderIndicator(_isLoading)
      //     :
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context)..requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 650,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add new address",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: sourceSansPro,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                      fontSize: 22),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 20,
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      'assets/icons/Group Copy 3@3x.png',
                                      fit: BoxFit.fill,
                                      color: Colors.black,
                                      height:
                                          MediaQuery.of(context).size.height,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CommonSized(FsDimens.space12),
                            labelField(),
                            CommonSized(FsDimens.space12),
                            address1Field(),
                            CommonSized(FsDimens.space12),
                            address2Field(),
                            CommonSized(FsDimens.space12),
                            cityField(),
                            CommonSized(FsDimens.space12),
                            countryDropDown(),
                            // // CommonSized(FsDimens.space20),

                            Row(
                              children: [
                                zipField(),
                                SizedBox(
                                  width: FsDimens.space10,
                                ),
                                // stateField(),
                                stateDropDown()
                              ],
                            ),
                            CommonSized(FsDimens.space20),
                            submitButton(),
                            CommonSized(FsDimens.space14),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _showCenterLoader == true
                      ? LoaderIndicator(_showCenterLoader)
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget labelField() {
    // print('${Strings.labelCon}');
    return AllInputDesign(
        key: Key("label_field"),
        focusNode: lableFocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(addressFocusNode)},
        inputHeaderName: '${Strings.labelCon}',
        controller: labelCon,
        hintText: '${Strings.labelConHint}',
        validatorFieldValue: '${Strings.labelConHint}',
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget address1Field() {
    //  print('${Strings.addressCon}');
    return AllInputDesign(
        key: Key("address"),
        inputHeaderName: '${Strings.addressCon}',
        focusNode: addressFocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(address2FocusNode)},
        controller: addressCon,
        hintText: '${Strings.addressConHint}',
        validatorFieldValue: '${Strings.addressConHint}',
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget address2Field() {
    //  print('${Strings.address2Con}');
    return AllInputDesign(
        key: Key("address_2"),
        inputHeaderName: '${Strings.address2Con}',
        focusNode: address2FocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(cityConFocusNode)},
        controller: address2Con,
        hintText: '${Strings.address2ConHint}',
        validatorFieldValue: '${Strings.address2ConHint}',
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget cityField() {
    //   print('${Strings.cityCon}');
    return AllInputDesign(
        key: Key("city"),
        inputHeaderName: '${Strings.cityCon}',
        focusNode: cityConFocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () =>
            {FocusScope.of(context).requestFocus(countryFocusNode)},
        controller: cityCon,
        hintText: '${Strings.cityConHint}',
        validatorFieldValue: '${Strings.cityConHint}',
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget zipField() {
    // print('${Strings.zipConHint}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          //  '${String.zipCon}',
          " Zip",
          style: labelHintFontStyle,
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          height: 50.0,
          width: ((36 / 100) * MediaQuery.of(context).size.width),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Colors.black12, width: 0.2),
          ),
          child: TextFormField(
            controller: zipCon,
            keyboardType: TextInputType.number,
            cursorColor: Colors.grey,

            style: TextStyle(
                color: Color(0xFF1F2D3D),
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                fontFamily: sourceSansPro),
            // keyboardType:

            //controller: dateCon,
            // onChanged:
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0XFFFFFFFF),
                hintText: '${Strings.zipConHint}',
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

  // Widget stateField() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         "State",
  //         style: labelHintFontStyle,
  //       ),
  //       SizedBox(
  //         height: 6.0,
  //       ),
  //       Container(
  //         height: 50.0,
  //         width: ((38 / 100) * MediaQuery.of(context).size.width),
  //         decoration: BoxDecoration(
  //           color: Colors.white54,
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           border: Border.all(color: Colors.black45, width: 0.2),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 10),
  //           child: DropdownButtonHideUnderline(
  //             child: DropdownButton(
  //               hint: Text(
  //                 '${_locations[0]}',
  //                 style: TextStyle(
  //                   color: Color(0xFF1F2D3D),
  //                   fontSize: 18,
  //                 ),
  //               ),
  //               value: _selectedLocation,
  //               onChanged: (newValue) {
  //                 setState(() {
  //                   _selectedLocation = newValue;
  //                 });
  //               },
  //               isExpanded: true,
  //               icon: Icon(
  //                 // Add this
  //                 Icons.keyboard_arrow_down_sharp,
  //                 // Add this
  //                 size: 25, // Add this
  //               ),
  //               items: _locations.map((location) {
  //                 return DropdownMenuItem(
  //                   child: new Text(
  //                     location,
  //                     style: TextStyle(
  //                       color: Color(0xFF1F2D3D),
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                   value: location,
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget zipField() {
  //   return AllInputDesign(
  //       key: Key("zip"),
  //       inputHeaderName: 'Zip',
  //       focusNode: zipConFocusNode,
  //       textInputAction: TextInputAction.done,
  //       controller: zipCon,
  //       hintText: 'Zip',
  //       validatorFieldValue: 'Zip',
  //       validator: userNameValidation,
  //       keyBoardType: TextInputType.number);
  // }

  Widget submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GreenButton(
        key: Key('login_button'),
        buttonName: "Save",
        onPressed: () {
          onSubmitButton();
        },
      ),
    );
  }

  Widget countryDropDown() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Country",
            style: labelHintFontStyle,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          child: DropdownButtonFormField(
            focusNode: countryFocusNode,
            hint: Text("Country",
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: sourceSansPro,
                    letterSpacing: 0.6)),
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
              padding: const EdgeInsets.only(right: 100, top: 10),
              child: Text(
                "State",
                style: labelHintFontStyle,
              ),
            ),
          ),
          Container(
            height: 50.0,
            width: ((40 / 100) * MediaQuery.of(context).size.width),
            margin: EdgeInsets.only(
                // top: 15,
                ),
            child: DropdownButtonFormField(
              focusNode: stateFocusNode,
              hint: Text(
                "State",
                style: TextStyle(
                  color: Color(0xFF1F2D3D),
                  fontSize: 18,
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
                size: 20,
              ),
              isExpanded: true,
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
                //FocusScope.of(context).requestFocus(zipConFocusNode);
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
          SizedBox(
            height: FsDimens.space20,
          ),
        ],
      );
    }
  }

  onSubmitButton() {
    if (labelCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter label", context);
    } else if (addressCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter address", context);
    } else if (cityCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter city", context);
    } else if (selectedCountry == null) {
      return showToastMessage("Select country", context);
    } else if (showState == true && selectedState == null) {
      return showToastMessage("Select state", context);
    } else if (zipCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter zip", context);
    } else {
      // addressAdd();
      customerEditAddId == null ? addressAdd() : editAddresApi();
      //editAddresApi();
    }
  }

  getSelectedCountryId(dynamic countries) {
    //  print(countries);
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

  //--------------Edit Address Api -------------//
  editAddresApi() async {
    // setState(() {
    //   _showCenterLoader = true;
    // });
    // var headers = Strings.hraders;
    // var request = http.Request(
    //     'POST',
    //     Uri.parse(
    //         'https://getbitetime.myshopify.com/api/2021-04/graphql.json'));
    // request.body =
    //     '''{"query":"mutation customerAddressUpdate(\$customerAccessToken: String!, \$id: ID!, \$address: MailingAddressInput!) {\\r\\n  customerAddressUpdate(\\r\\n    customerAccessToken: \$customerAccessToken\\r\\n    id: \$id\\r\\n    address: \$address\\r\\n  ) {\\r\\n    customerAddress {\\r\\n      id\\r\\n      address1\\r\\n    }\\r\\n    customerUserErrors {\\r\\n      code\\r\\n      field\\r\\n      message\\r\\n    }\\r\\n  }\\r\\n}","variables":{"customerAccessToken":"$id","id":"$customerEditAddId","address":{"address1":"${addressCon.text.toString()}","address2":"${address2Con.text.toString()}","city":"${cityCon.text.toString()}","company":"${labelCon.text.toString()}","country":"$selectedCountry","firstName":"$firstName","lastName":"$lastName","phone":"","province":"$selectedState","zip":"${zipCon.text.toString()}"}}}''';

    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   setState(() {
    //     _showCenterLoader = false;
    //   });
    //   dynamic responseJson = await response.stream.bytesToString();
    //   print(responseJson);
    //   // ignore: unused_local_variable
    //   dynamic responseData = json.decode(responseJson);

    //   if (customerEditAddId != null) {
    //     return Navigator.of(context).pop();
    //   }
    // } else {
    //   print(response.reasonPhrase);
    // }

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
        '''{"query":"mutation customerAddressUpdate(\$customerAccessToken: String!, \$id: ID!, \$address: MailingAddressInput!) {\\n  customerAddressUpdate(\\n    customerAccessToken: \$customerAccessToken\\n    id: \$id\\n    address: \$address\\n  ) {\\n    customerAddress {\\n      id\\n       address1\\n      address2\\n      city\\n      company\\n      country\\n      firstName\\n      lastName\\n      phone\\n      province\\n      zip\\n    }\\n    customerUserErrors {\\n      code\\n      field\\n      message\\n    }\\n  }\\n}\\n","variables":{"customerAccessToken":"$id","id":"$customerEditAddId","address":{"address1":"${addressCon.text.toString()}","address2":"${address2Con.text.toString()}","city":"${cityCon.text.toString()}","company":"${labelCon.text.toString()}","country":"$selectedCountry","firstName":"Manish","lastName":"Jain","phone":"+918342005282","province":"$selectedState","zip":"${zipCon.text.toString()}"}}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      print(responseJson);
      // ignore: unused_local_variable
      dynamic responseData = json.decode(responseJson);

      if (customerEditAddId != null) {
        return Navigator.of(context).pop();
      }
    } else {
      print(response.reasonPhrase);
    }
  }
//--------------Edit Address Api -------------//

//-----------Add New Address Start-----------//
  addressAdd() async {
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
        '''{"query":"mutation customerAddressCreate(\$customerAccessToken: String!, \$address: MailingAddressInput!) {\\n  customerAddressCreate(\\n    customerAccessToken: \$customerAccessToken\\n    address: \$address\\n  ) {\\n    customerAddress {\\n      id\\n      address1\\n      address2\\n      city\\n      company\\n      country\\n      firstName\\n      lastName\\n      phone\\n      province\\n      zip\\n    }\\n    customerUserErrors {\\n      code\\n      field\\n      message\\n    }\\n  }\\n}","variables":{"customerAccessToken":"$id","address":{"address1":"${addressCon.text.toString()}","address2":"${address2Con.text.toString()}","city":"${cityCon.text.toString()}","company":"${labelCon.text.toString()}","country":"$selectedCountry","firstName":"KeyBoard","lastName":"Jain","phone":"+918342005282","province":"$selectedState","zip":"${zipCon.text.toString()}"}}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      print(responseJson);
      dynamic responseData = json.decode(responseJson);
      dynamic responsedata = responseData['data'];
      dynamic data = responsedata['customerAddressCreate'];
      print(data);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Address()));
      return showToastMessage("Successfully address added", context);

      // Map<String, dynamic> datavar = data["datares"];
      // print("@@@@######@@@@" + datavar.toString());

      // if (datavar != null) {
      //   //  dynamic customerUserError = data["checkoutUserErrors"];
      //   labelCon.clear();
      //   addressCon.clear();
      //   address2Con.clear();
      //   cityCon.clear();
      //   zipCon.clear();
      //   // Navigator.of(context).pop();
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => Address()));
      //   return showToastMessage("Successfully address added", context);
      // }
      // else {
      //   //  dynamic showError = customerUserError[0]['message'];
      //   return showToastMessage("Address not add ", context);
      // }
    } else {
      print(response.reasonPhrase);
    }
  }
//-----------Add New Address End-----------//

  //-------------Country Api Start------//
  countryApi() async {
    // setState(() {
    //   _isLoading = true;
    // });
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

  //-------------Country Api End------//

  @override
  void dispose() {
    super.dispose();
  }
}
