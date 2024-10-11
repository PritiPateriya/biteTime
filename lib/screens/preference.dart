import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:flutter/material.dart';

class Preference extends StatefulWidget {
  @override
  _PreferenceState createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  bool value = false;
  bool value1 = false;
  bool value2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: FsDimens.space20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text("ORDER STATUS",
                        style: TextStyle(
                            color: Color(0xffB4B6BD),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            fontSize: 14)),
                  ),
                  SizedBox(
                    height: FsDimens.space8,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.green,
                        value: this.value,
                        onChanged: (bool value1) {
                          setState(() {
                            this.value = value1;
                          });
                        },
                      ),
                      SizedBox(
                        width: 08,
                      ),
                      Container(
                        child: Text('Update me on my orders via SMS',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                // fontFamily:
                                // :sansBold,
                                //      sourceSansPro,
                                fontSize: 18)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.green,
                        value: this.value2,
                        onChanged: (bool value1) {
                          setState(() {
                            this.value2 = value1;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                            String.fromCharCodes(
                                Runes('Allow push notification')),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                // fontFamily:
                                // :sansBold,
                                //      sourceSansPro,
                                fontSize: 18)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: FsDimens.space12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, bottom: 10),
                    child: Text("PROMOTIONAL DEALS",
                        style: TextStyle(
                            color: Color(0xffB4B6BD),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            fontSize: 14)),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.green,
                        value: this.value1,
                        onChanged: (bool value1) {
                          setState(() {
                            this.value1 = value1;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: Text('Get my deals and insentives via',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Text('email',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: FsDimens.space240,
          ),
          cPaymentButton(),
          SizedBox(
            height: FsDimens.space24,
          ),
        ],
      ),
    );
  }

  Widget cPaymentButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GreenButton(
        key: Key('continue_payment_submit'),
        buttonName: "Save",
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => OrderScreen()));
        },
      ),
    );
  }
}
