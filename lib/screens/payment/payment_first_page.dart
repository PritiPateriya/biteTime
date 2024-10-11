import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
// ignore: unused_import
import 'package:bitetime/common_files/styles.dart';
// ignore: unused_import
import 'package:bitetime/screens/address/edit_address.dart';
import 'package:bitetime/screens/payment/payment_new_address.dart';
import 'package:flutter/material.dart';

class PaymentFirst extends StatefulWidget {
  @override
  _PaymentFirstState createState() => _PaymentFirstState();
}

class _PaymentFirstState extends State<PaymentFirst> {
  //----edit dailog
  editing(context) async {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.white,
                //     blurRadius: 0,
                //     spreadRadius: 0.2,
                //     offset: Offset(
                //       0.0,
                //       1.0,
                //     ),
                //   )
                // ],
                ),
            height: 180,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      "assets/icons/Group Copy 3.png",
                      height: 20,
                      width: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: FsDimens.space14,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentNewAddress()));
                    });
                  },
                  child: Text("Edit"),
                ),
                SizedBox(
                  height: FsDimens.space24,
                ),
                Text("Make primary"),
                SizedBox(
                  height: FsDimens.space24,
                ),
                Text("Delete"),
                SizedBox(
                  height: FsDimens.space24,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  //////edit dailog

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    editing(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: FsDimens.space12,
                      ),
                      Text("PRIMARY",
                          style: TextStyle(
                              color: Color(0xffA2A4AD),
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                              fontSize: 13.5)),
                      SizedBox(
                        height: FsDimens.space12,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 16, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(width: 1.0, color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 35,
                                          color: Colors.transparent,
                                          child: Image.asset(
                                            "assets/icons/visa@3x.png",
                                            fit: BoxFit.fill,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 10),
                                        child: Text("Ending 9005",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.more_vert,
                                  color: Color(0xffCCCFD6),
                                  size: 30,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: FsDimens.space12,
                            ),
                            Text("Jason Gries",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16)),
                            SizedBox(
                              height: FsDimens.space2,
                            ),
                            Text("Exp.02 / 2020",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16)),
                            SizedBox(
                              height: FsDimens.space10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: FsDimens.space28,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: FsDimens.space12,
                    ),
                    Text("OTHER CARDS",
                        style: TextStyle(
                            color: Color(0xffA2A4AD),
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                            fontSize: 13.5)),
                    SizedBox(
                      height: FsDimens.space12,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5, left: 16, bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(width: 1.0, color: Colors.black12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 35,
                                        color: Colors.transparent,
                                        child: Image.asset(
                                          "assets/icons/amex@3x.png",
                                          fit: BoxFit.fill,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 10),
                                      child: Text("Ending 9005",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Color(0xffCCCFD6),
                                size: 30,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: FsDimens.space12,
                          ),
                          Text("Jason Gries",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16)),
                          SizedBox(
                            height: FsDimens.space2,
                          ),
                          Text("Exp.02 / 2020",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16)),
                          SizedBox(
                            height: FsDimens.space10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: FsDimens.space18,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5, left: 16, bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(width: 1.0, color: Colors.black12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 35,
                                        color: Colors.transparent,
                                        child: Image.asset(
                                          "assets/icons/visa@3x.png",
                                          fit: BoxFit.fill,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 10),
                                      child: Text("Ending 9005",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Color(0xffCCCFD6),
                                size: 30,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: FsDimens.space12,
                          ),
                          Text("Jason Gries",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16)),
                          SizedBox(
                            height: FsDimens.space2,
                          ),
                          Text("Exp.02 / 2023",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16)),
                          SizedBox(
                            height: FsDimens.space10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: FsDimens.space48,
                ),
                submitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GreenButton(
        key: Key('add_new_card_button'),
        buttonName: "Add new card",
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentNewAddress()));
        },
      ),
    );
  }
}
