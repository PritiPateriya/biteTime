import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/mytextfield.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/common_files/validation.dart';
import 'package:flutter/material.dart';

class PaymentNewAddress extends StatefulWidget {
  @override
  _PaymentNewAddressState createState() => _PaymentNewAddressState();
}

class _PaymentNewAddressState extends State<PaymentNewAddress> {
  TextEditingController cardNumCon = TextEditingController();
  TextEditingController cardNameCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController cvvCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // return Dialog(
    //   child: Container(
    //     height: 400,
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 20.0,
    //             vertical: 10.0,
    //           ),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: FsDimens.space10,
    //               ),
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     "Add new card",
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.w800,
    //                         fontSize: 22),
    //                   ),
    //                   GestureDetector(
    //                     onTap: () {
    //                       Navigator.of(context).pop();
    //                       // Navigator.of(context).pop();
    //                     },
    //                     child: Container(
    //                       height: 20,
    //                       color: Colors.transparent,
    //                       child: Image.asset(
    //                         'assets/icons/Group Copy 3@3x.png',
    //                         fit: BoxFit.fill,
    //                         color: Colors.black,
    //                         height: MediaQuery.of(context).size.height,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: FsDimens.space20,
    //               ),
    //               Text(
    //                 "Card number",
    //                 style: labelHintFontStyle,
    //               ),
    //               SizedBox(
    //                 height: 6.0,
    //               ),
    //               cardNumField(),
    //               SizedBox(
    //                 height: FsDimens.space20,
    //               ),
    //               cardNameField(),
    //               SizedBox(
    //                 height: FsDimens.space20,
    //               ),
    //               Row(
    //                 children: [
    //                   monthYearField(),
    //                   SizedBox(
    //                     width: FsDimens.space20,
    //                   ),
    //                   cvvField(),
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: FsDimens.space100,
    //               ),
    //               Align(
    //                   alignment: Alignment.bottomCenter,
    //                   child: saveCardButton()),
    //               SizedBox(
    //                 height: FsDimens.space10,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  //vertical: 5.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Credit Card",
                          style: TextStyle(
                              fontFamily: sansSemiBold,
                              color: Color(0xff1F2D3D),
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w900,
                              fontSize: 22),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 20,
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/icons/Group Copy 3@3x.png',
                              fit: BoxFit.fill,
                              color: Colors.black,
                              height: MediaQuery.of(context).size.height,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    Text(
                      "Card number",
                      style: labelHintFontStyle,
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    cardNumField(),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    cardNameField(),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    Row(
                      children: [
                        monthYearField(),
                        SizedBox(
                          width: FsDimens.space14,
                        ),
                        cvvField(),
                      ],
                    ),
                    SizedBox(
                      height: FsDimens.space60,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: saveCardButton()),
                    SizedBox(
                      height: FsDimens.space10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardNumField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.94,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          border: Border.all(color: Colors.black12)),
      child: TextFormField(
        cursorColor: Colors.grey,
        controller: cardNumCon,
        keyboardType: TextInputType.number,
        style: TextStyle(
            color: Color(0xFF1F2D3D),
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
            fontFamily: sourceSansPro),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black12, width: 0.2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black12, width: 0.2),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black12, width: 0.2)),
            hintText: "Card number",
            hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 18,
                fontFamily: sourceSansPro,
                fontWeight: FontWeight.w400),
            filled: true,
            fillColor: Color(0XFFFFFFFF),
            suffixIcon: IconButton(
                icon: Container(
                    height: 35,
                    color: Colors.transparent,
                    child: Image.asset(
                      "assets/icons/visa@3x.png",
                      fit: BoxFit.fill,
                    )),
                onPressed: () {}),
            contentPadding: EdgeInsets.only(left: 16, top: 14)),
        onTap: () {
          // _selectDate(context);
        },
      ),
    );
  }

  Widget cardNameField() {
    return AllInputDesign(
        key: Key("card_name"),
        inputHeaderName: 'Name on card',
        controller: cardNameCon,
        hintText: 'Name on card',
        validatorFieldValue: 'Name on card',
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget monthYearField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "MM/YY",
          style: labelHintFontStyle,
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          height: 45.0,
          width: ((37.5 / 100) * MediaQuery.of(context).size.width),
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
            controller: dateCon,
            // onChanged:
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0XFFFFFFFF),
                hintText: "MM/YY",
                hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 18,
                    fontFamily: sourceSansPro,
                    fontWeight: FontWeight.w400),
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

  Widget cvvField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "CVV",
          style: labelHintFontStyle,
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          height: 45.0,
          width: ((37.5 / 100) * MediaQuery.of(context).size.width),
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
            controller: dateCon,
            // onChanged:
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0XFFFFFFFF),
                hintText: "CVV",
                hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 18,
                    fontFamily: sourceSansPro,
                    fontWeight: FontWeight.w400),
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

  Widget saveCardButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GreenButton(
        key: Key('save_card_button'),
        buttonName: "Save",
        onPressed: () {
          // signUpUser();
        },
      ),
    );
  }
}
