import 'dart:convert';
import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/sizedbox_common.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/model/count.dart';
import 'package:bitetime/model/data.dart';
//import 'package:bitetime/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

bool isFrom;

class _CartScreenState extends State<CartScreen> {
  final dbHelper = DatabaseHelper.instance;
  dynamic itemCont;
  List<Car> cars = [];
  List<Car> carsByName = [];
  dynamic allRows;

  bool _isLoading;

  var listD;
  var value;
  var nameData = [];
  var dataId = [];
  void _queryAll() async {
    setState(() {
      _isLoading = true;
    });
    allRows = await dbHelper.queryAllRows();
    cars.clear();
    allRows.forEach((row) => cars.add(Car.fromMap(row)));
    CommonFunctions().console(allRows);

    setState(() {
      for (final list in allRows) {
        dataId.add(list['ids']);
        listD = list['name'];
        CommonFunctions().console("list data response " + listD);
        nameData.add(jsonDecode(listD));
      }
      CommonFunctions().console(nameData);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _queryAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.7,
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
          title: Text(
            "Cart",
            style: newAppbartextStyle,
          ),
          centerTitle: true,
        ),
        body: _isLoading == true
            ? LoaderIndicator(_isLoading)
            : Container(
                child: allRows.length == 0
                    ? Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: Text(
                          "No data available",
                          style:
                              TextStyle(fontFamily: sansSemiBold, fontSize: 18),
                        ),
                      )
                    : listData(),
              ));
  }

  Widget listData() {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: nameData.length,
        itemBuilder: (context, index) {
          dynamic data = nameData[index];
          CommonFunctions().console("Carttttttt----------$data");

          Map<String, dynamic> img;
          Map<String, dynamic> variants;
          dynamic newText;
          // dynamic xyz;
          // for (final price in data[index]['node']['variants']['edges']) {
          //   xyz = price;
          //   print("XYZ====$xyz");
          // }
          var title;
          var lacalTagdat = [];
          for (final list in data['node']['tags']) {
            if (list == 'new') {
              newText = list;
            } else {
              lacalTagdat.add(list);
            }
          }

          img = data['node']['images']['edges'][0];
          variants = data['node']['variants']['edges'][0];

          if (variants['node']['title'] == '2' ||
              variants['node']['title'] == '4' ||
              variants['node']['title'] == '6') {
            title = 'plate';
          } else {
            title = variants['node']['title'];
          }
          print('$variants');

          return GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.network(
                                    "${img['node']['src']}",
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: newText == null
                                      ? Container()
                                      : Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xffE2B981),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 3,
                                                bottom: 2,
                                              ),
                                              child: Text(
                                                  "$newText".toUpperCase(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10)),
                                            ),
                                          ),
                                        )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      10,
                                  child: Text(
                                    "${data['node']['productType']}"
                                        .toUpperCase(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: montserratBold,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        // String.fromCharCodes(Runes(
                                        //   '\u0024' +
                                        //       "${newText['node']['price']}",
                                        // )),
                                        String.fromCharCodes(new Runes('\u0024' +
                                            "${variants['node']['price']}")),
                                        style: TextStyle(
                                            fontFamily: montserratBold),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                          child: Text(
                                        "/" + "$title",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5),
                            child: Text(
                              "${data['node']['title']}".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: montserratBold,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        CommonSized(10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          height: lacalTagdat.length > 4 ? 30 : 15,
                          alignment: Alignment.centerLeft,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: lacalTagdat.length,
                            itemBuilder: (context, index) {
                              return Wrap(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xffD8F2E7),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12,
                                            right: 12,
                                            top: 4,
                                            bottom: 4),
                                        child: Text(
                                          "${lacalTagdat[index]}".toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w600,
                                              //fontFamily: monsterdRegular,
                                              color: Color(0xff2C3B36)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                //  _delete(dataId[index]);
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: Text('Cart item Delete '),
                                          content: Text(
                                            'Do you accept ?',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: montserratBold,
                                                fontSize: 16),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          actions: [
                                            // ignore: deprecated_member_use
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CartScreen()));
                                                },
                                                child: Text(
                                                  "Cencel",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontFamily: sansSemiBold,
                                                      fontSize: 16),
                                                )),
                                            // ignore: deprecated_member_use
                                            FlatButton(
                                                onPressed: () {
                                                  _delete(dataId[index]);
                                                },
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontFamily: sansSemiBold,
                                                      fontSize: 16),
                                                ))
                                          ],
                                        ));

                                // AlertDialog(
                                //   title: Text("Cart Item Delete ?"),
                                //   content: Text("Do you accept ?"),
                                //   actions: [
                                //     // ignore: deprecated_member_use
                                //     FlatButton(
                                //         onPressed: () {
                                //           Navigator.pop(context);
                                //         },
                                //         child: Text("Cencel")),
                                //     // ignore: deprecated_member_use
                                //     FlatButton(
                                //         onPressed: () {
                                //           _delete(dataId[index]);
                                //         },
                                //         child: Text("Delete"))
                                //   ],
                                // );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: greenColor),
                                    borderRadius: BorderRadius.circular(3)),
                                padding: const EdgeInsets.only(
                                    left: 4, right: 4, top: 1, bottom: 1),
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                      fontFamily: sansSemiBold,
                                      fontSize: 16,
                                      letterSpacing: 0.3),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _delete(id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    setState(() {
      nameData = [];
      allRows = null;
      _count();
      _queryAll();
    });
    CommonFunctions().console(rowsDeleted);
  }

  void _count() async {
    itemCont = await dbHelper.queryAllRows();
    cars.clear();

    setState(() {
      itemCont.forEach((row) => cars.add(Car.fromMap(row)));

      if (itemCont != null) {
        Provider.of<Count>(context, listen: false).change(itemCont.length);
      } else {
        Provider.of<Count>(context, listen: false).change(0);
      }
    });
  }

  // showAlertDialog(BuildContext context) {
  //   // set up the buttons
  //   // ignore: deprecated_member_use
  //   Widget cancelButton = FlatButton(
  //     child: Text("Cancel"),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );
  //   // ignore: deprecated_member_use
  //   Widget continueButton = FlatButton(
  //     child: Text("Continue"),
  //     onPressed: () {
  //      _delete(dataId[index]);
  //     },
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("AlertDialog"),
  //     content: Text(
  //         "Would you like to continue learning how to use Flutter alerts?"),
  //     actions: [
  //       cancelButton,
  //       continueButton,
  //     ],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
