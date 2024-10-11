import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/styles.dart';
// ignore: unused_import
import 'package:bitetime/model/count.dart';
import 'package:bitetime/screens/your_order.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Biteparks extends StatefulWidget {
  @override
  _BiteparksState createState() => _BiteparksState();
}

class _BiteparksState extends State<Biteparks> {
  @override
  Widget build(BuildContext context) {
    // var value = context.watch<Count>().value;
    // quant = context.watch<Quantity>().quantity;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 1.5,
      //   centerTitle: true,
      //   actions: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 10),
      //       child: GestureDetector(
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => YourOrder()));
      //         },
      //         child: Container(
      //           height: 29,
      //           padding: EdgeInsets.only(left: 12),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(20),
      //             color: Color(0xff00be61),
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Icon(
      //                 Icons.shopping_cart_outlined,
      //                 color: Colors.white,
      //                 size: 20,
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 10.0, left: 5),
      //                 child: Text(
      //                   "0",
      //                   // value == null ? "0" : "$value",
      //                   style: TextStyle(fontSize: 16, color: Colors.white),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      //   automaticallyImplyLeading: false,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: Image.asset(
      //       "assets/icons/Group Copy 3.png",
      //       height: 20,
      //       width: 20,
      //       color: Colors.black,
      //     ),
      //   ),
      //   title: Text("Biteparks", style: newAppbartextStyle),
      // ),

      // appBar: appBar(value),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: FsDimens.space28,
                ),
                Text(
                  String.fromCharCodes(Runes(
                      'Get \u00245 for every \u0024250 spent.\nUse your store credit at any time at checkout')),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: sansBold,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                    // letterSpacing: 0.8,
                  ),
                ),
                SizedBox(
                  height: FsDimens.space40,
                ),
                Text(
                  "STORE CREDIT BALANCE".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      fontFamily: montserratBold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: FsDimens.space8,
                ),
                Text(
                  String.fromCharCodes(Runes('\u002475.00')),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: sansSemiBold,
                      color: bGBottomColor,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: FsDimens.space28,
                ),
                offerCodeField(),
                SizedBox(
                  height: FsDimens.space20,
                ),
                GestureDetector(
                  onTap: () {
                    showToastMessage("Discount code copied", context);
                    Clipboard.setData(
                        new ClipboardData(text: "sfor5bhsb8kjt67f"));
                  },
                  child: Text(
                    "TAP TO COPY DISCOUNT CODE".toUpperCase(),
                    style: TextStyle(
                        fontSize: 14.5,
                        fontFamily: montserratBold,
                        color: Color(0xffAAAAAA),
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(
                  height: FsDimens.space20,
                ),
                Text(
                  "Add credit",
                  style: TextStyle(
                      fontSize: 21.0,
                      fontFamily: sansBold,
                      color: bGBottomColor,
                      // letterSpacing: 1.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: FsDimens.space32,
                ),
                DottedLine(
                  dashColor: Color(0xffCDCED3),
                ),
                SizedBox(
                  height: FsDimens.space20,
                ),
                Text(
                  "REFER TO FRIEND".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      fontFamily: montserratBold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: FsDimens.space8,
                ),
                Text(
                  String.fromCharCodes(
                      Runes("We give your friend \u002425, you get \u002425")),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.5,
                    fontFamily: sansSemiBold,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                    // letterSpacing: 0.4,
                    //  fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(
                  height: FsDimens.space28,
                ),
                linkField(),
                SizedBox(
                  height: FsDimens.space20,
                ),
                GestureDetector(
                  onTap: () {
                    showToastMessage("Link copied", context);
                    Clipboard.setData(new ClipboardData(
                        text: "https://bitetime.com/referral/801u"));
                  },
                  child: Text(
                    "TAP TO COPY LINK".toUpperCase(),
                    style: TextStyle(
                        fontSize: 14.5,
                        fontFamily: montserratBold,
                        color: Color(0xffAAAAAA),
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(
                  height: FsDimens.space24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Text(
                    String.fromCharCodes(Runes(
                      "Copy referral link and send it to your friend. Once they make their first purchase, we'll reward you with \u002425 store credit.",
                    )),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: sourceSansPro,
                        color: Colors.black,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: FsDimens.space32,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  appBar(value) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          //  Navigator.push(context MaterialPageRoute(builder: (context)))
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> ))
        },
        child: Image.asset(
          "assets/icons/Group Copy 3.png",
          height: 20,
          width: 20,
          color: Colors.black,
        ),
      ),
      title: Text(
        "Personalize",
        style: newAppbartextStyle,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => YourOrder()),
              );
            },
            child: Container(
              height: 29,
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff00be61),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 5),
                    child: Text(
                      value == null ? "0" : "$value",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget offerCodeField() {
    return Container(
        height: 55.0,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
            border: Border.all(color: bGBottomColor, width: 2)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: GestureDetector(
              onTap: () {
                showToastMessage("Discount code copied", context);
                Clipboard.setData(new ClipboardData(text: "sfor5bhsb8kjt67f"));
              },
              child: Text(
                "sfor5bhsb8kjt67f",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 21.0,
                    fontFamily: sourceSansPro,
                    color: bGBottomColor,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ));
  }

  Widget linkField() {
    return Container(
        height: 55.0,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
            border: Border.all(color: bGBottomColor, width: 2)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 8),
            child: GestureDetector(
              onTap: () {
                showToastMessage("Link copied", context);
                Clipboard.setData(new ClipboardData(
                    text: "https://bitetime.com/referral/801u"));
              },
              child: Text(
                "https://bitetime.com/referral/801u",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: sourceSansPro,
                    color: bGBottomColor,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ));
  }
}
