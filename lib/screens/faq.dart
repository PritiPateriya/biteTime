import 'package:bitetime/common_files/styles.dart';
import 'package:flutter/material.dart';

class Faq extends StatefulWidget {
  const Faq({Key key}) : super(key: key);

  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  bool _color;
  // bool styleColor = false;

  // changeColor() {
  //   if (styleColor == false) {
  //     setState(() {
  //       styleColor = true;
  //       Colors.amber;
  //     });
  //   } else {}
  //   setState(() {
  //     setState(() {
  //       styleColor = false;
  //       Colors.amberAccent;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _color = true;
  }

  var _dynamicTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.5,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
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
          title: Text("FAQ", style: newAppbartextStyle),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300])),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 30),
                          hintText: 'Start typing',
                          hintStyle: TextStyle(
                              fontFamily: sourceSansPro,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          border: InputBorder.none),
                    )),
              ),
              Divider(
                thickness: 1.5,
                color: Colors.black12,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Home meals orders ",
                      style: TextStyle(
                          fontFamily: montserratBold,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff00B864)),
                    )),
              ),
              // Divider(
              //   thickness: 1.5,
              //   color: Colors.black12,
              // ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      title: GestureDetector(
                          onTap: () {
                            setState(() {
                              _dynamicTextColor = Colors.green;
                            });
                          },
                          child: Text(" It there a minimun order amount?",
                              style: TextStyle(
                                //   color: styleOBJ ? Colors.black : Colors.green,

                                color: _dynamicTextColor,
                                fontFamily: sansSemiBold,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ))),
                      children: [
                        Text(
                          "yes Follow us on social media for extra savings",
                          style: TextStyle(
                              //  fontFamily: sourceSansPro,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  // changeColor() {
  //   if (isPressed == true) {
  //     color = Colors.green;
  //     isPressed = false;
  //   } else {
  //     color = Colors.black;
  //     isPressed = true;
  // }  }
  // }
}
