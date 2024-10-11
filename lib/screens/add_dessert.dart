import 'dart:convert';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/database.dart';
import 'package:bitetime/model/count.dart';
import 'package:bitetime/model/data.dart';
import 'package:bitetime/screens/your_order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddDessert extends StatefulWidget {
  final dynamic data;
  final bool isFrom;

  AddDessert({
    Key key,
    this.data,
    this.isFrom,
  }) : super(key: key);

  @override
  _AddDessertState createState() => _AddDessertState();
}

class _AddDessertState extends State<AddDessert> {
  List<dynamic> selectedItemValue = List<dynamic>();
  final dbHelper = DatabaseHelper.instance;
  List<Car> cars = [];
  dynamic itemCont;
  bool _isLoading;
  dynamic varjson;
  dynamic productsJson;
  String selectedvariants;
  dynamic temp;
  var value;
  var pageData = 10;
  var values = [];
  var prices;
  var suffixtype;
  var sendData;
  int dropState = 0;

  @override
  void initState() {
    dropState = 0;

    CommonFunctions().console(widget.data);
    _queryAll();
    _isLoading = true;
    searchData(pageData);
    super.initState();
  }

  ///-----------dataBase-----------
  void _queryAll() async {
    itemCont = await dbHelper.queryAllRows();
    cars.clear();
    setState(() {
      itemCont.forEach((row) => cars.add(Car.fromMap(row)));
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = context.watch<Count>().value;
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: appBar(value),
      body: _isLoading == true
          ? LoaderIndicator(_isLoading)
          : Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 15.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding:
                                  EdgeInsets.only(top: 0, left: 8, bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    width: 1.0, color: Colors.black12),
                              ),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: varjson.length,
                                  itemBuilder: (context, index) {
                                    for (int i = 0; i < varjson.length; i++) {
                                      selectedItemValue.add(varjson[i]['node']
                                              ['variants']['edges'][0]['node']
                                          ['title']);
                                    }
                                    // print("Hello....$selectedItemValue"
                                    //     .toString());
                                    dynamic data = varjson[index];
                                    CommonFunctions().console(data);
                                    return Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (13 / 100),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.4,
                                                  color: Color(0xffD9D9D9),
                                                  child: Image.network(
                                                    "${data['node']['images']['edges'][0]['node']['src']}",
                                                    fit: BoxFit.fill,
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (15 / 100),
                                                  width: 160,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "${data['node']['title']}",
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff2D2D2D),
                                                                fontFamily:
                                                                    montserratBold,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 13)),

                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5.0),
                                                          height: 38.0,
                                                          width: ((48 / 100) *
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4)),
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .black26),
                                                          ),
                                                          child:
                                                              DropdownButtonHideUnderline(
                                                            child:
                                                                DropdownButton(
                                                              value:
                                                                  selectedItemValue[
                                                                          index]
                                                                      .toString(),
                                                              items: (data['node']
                                                                              [
                                                                              'variants']
                                                                          [
                                                                          'edges']
                                                                      as List)
                                                                  .map((node) {
                                                                return new DropdownMenuItem<
                                                                    dynamic>(
                                                                  value: node[
                                                                          'node']
                                                                      ['title'],
                                                                  child: new Text(
                                                                      node['node']
                                                                          [
                                                                          'title'],
                                                                      style: new TextStyle(
                                                                          color:
                                                                              Colors.black)),
                                                                );
                                                              }).toList(),
                                                              icon: Icon(
                                                                Icons
                                                                    .keyboard_arrow_down_rounded,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              ),
                                                              iconEnabledColor:
                                                                  Colors.black,
                                                              iconDisabledColor:
                                                                  Colors.black,
                                                              isExpanded: true,
                                                              elevation: 16,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff1B1C1C),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 16),
                                                              onChanged:
                                                                  (newValue) {
                                                                selectedItemValue[
                                                                        index] =
                                                                    newValue;
                                                                setState(() {
                                                                  if (data['node']['variants']['edges'][0]
                                                                              [
                                                                              'node']
                                                                          [
                                                                          'title'] ==
                                                                      newValue) {
                                                                    dropState =
                                                                        0;
                                                                  } else if (data['node']['variants']['edges'][1]
                                                                              [
                                                                              'node']
                                                                          [
                                                                          'title'] ==
                                                                      newValue) {
                                                                    dropState =
                                                                        1;
                                                                  }
                                                                });
                                                                print(
                                                                    'selected_value... $newValue..$dropState..$index');
                                                              },
                                                            ),
                                                          ),
                                                        ),

                                                        //index
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                              height: 32.0,
                                                              width: 130,
                                                              child:
                                                                  // ignore: deprecated_member_use
                                                                  RaisedButton(
                                                                elevation: 1.0,
                                                                color:
                                                                    bGBottomColor,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                ),
                                                                onPressed: () {
                                                                  int temp = 1;
                                                                  print(
                                                                      "index...$index");
                                                                  _insert(
                                                                      jsonEncode(
                                                                          data),
                                                                      temp,
                                                                      data['node'][
                                                                          'id'],
                                                                      data['node'][
                                                                          'title'],
                                                                      data['node'][
                                                                          'description'],
                                                                      data['node'][
                                                                          'productType'],
                                                                      data['node']['images']['edges'][0]
                                                                              ['node'][
                                                                          'image'],
                                                                      "1",
                                                                      data['node']
                                                                              ['variants']['edges'][dropState]['node'][
                                                                          'id'],
                                                                      data['node']
                                                                              ['variants']['edges'][dropState]['node']
                                                                          [
                                                                          'price'],
                                                                      data['node']
                                                                              ['variants']['edges'][dropState]['node']
                                                                          ['title'],
                                                                      (double.parse(data['node']['variants']['edges'][dropState]['node']['price']) * 1).toStringAsFixed(2).toString());

                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              YourOrder()));
                                                                },
                                                                child: Text(
                                                                  "ADD",
                                                                  style:
                                                                      TextStyle(
                                                                    inherit:
                                                                        true,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        1.6,
                                                                    fontFamily:
                                                                        sourceSansPro,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                              )),
                                                        )
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: FsDimens.space10,
                                        ),
                                      ],
                                    );
                                  })),
                        ],
                      ),
                    ),
                  ],
                ),
                // Align(
                //     alignment: Alignment.bottomCenter,
                //     child: addToOrderButton()),
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
          Navigator.of(context).pop();
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => StatusDialog()));
        },
        child: Image.asset(
          "assets/icons/Group Copy 3.png",
          height: 20,
          width: 20,
          color: Colors.black,
        ),
      ),
      title: Text(
        "Add desserts",
        style: newAppbartextStyle,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => YourOrder()));
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

  void _insert(name, miles, pid, title, description, productType, image, qty,
      varientId, varientPrice, varientTitle, totalPrice) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnNamed: name, // pnode
      DatabaseHelper.columnMiles: miles,
      DatabaseHelper.columnPId: pid,
      DatabaseHelper.columnTitle: title,
      DatabaseHelper.columnDecription: description,
      DatabaseHelper.columnProductType: productType,
      DatabaseHelper.columnImage: image,
      DatabaseHelper.columnQty: qty,
      DatabaseHelper.columnVId: varientId,
      DatabaseHelper.columnVPrice: varientPrice,
      DatabaseHelper.columnVTitle: varientTitle,
      DatabaseHelper.columnTotalPrice: totalPrice,
      DatabaseHelper.columnVSauce: "",
      DatabaseHelper.columnVSide: "",
    };

    Car car = Car.fromMap(row);

    bool idProductExists = await dbHelper.isDessertsExists(pid, varientPrice);
    print("Android_U...$idProductExists");
    if (idProductExists) {
      //int ins = await dbHelper.insert(car);
      // print("Android_I...$ins");
    } else {
      int ins = await dbHelper.insert(car);
      print("Android_I...$ins");
    }
  }

  searchData(pageData) async {
    var headers =
        //Strings.hraders;
        {
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
        '''{"query":"{\\n  shop {\\n    collections(query: \\"desserts\\",first: 10) {\\n      edges {\\n        node {\\n          id\\n          title\\n          products(first: 50) {\\n            edges {\\n              node {\\n                id\\n                title\\n                productType\\n                description\\n                tags\\n                images(first: 4) {\\n                  edges {\\n                    node {\\n                       id\\n                       src\\n                 }\\n             }\\n            }\\n            variants(first: 4){\\n                edges{\\n                    node{\\n                        id\\n                    price\\n                    title\\n                    }\\n                }\\n\\n            }\\n              }\\n            }\\n          }\\n        }\\n      }\\n    }\\n  }\\n}","variables":{}}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      setState(() {
        _isLoading = false;
//_loadMoreData = false;
      });
      print("$responseJson +  priti");

      dynamic mujsonSearch = json.decode(responseJson);
      var collectionEdges = mujsonSearch['data']['shop']['collections'];

      varjson = collectionEdges['edges'];

      varjson = varjson[0]['node']['products']['edges'];
      print("$varjson + ##############");

      CommonFunctions().console(varjson);
    } else {
      print(response.reasonPhrase);
    }
  }
}
