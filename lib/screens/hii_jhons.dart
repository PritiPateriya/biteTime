import 'dart:convert';

import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/media_quary_size_type.dart';
import 'package:bitetime/common_files/styles.dart';

import 'package:bitetime/screens/all_meal.dart';
import 'package:bitetime/screens/persionalize.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:page_indicator/page_indicator.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class HiiJhons extends StatefulWidget {
  @override
  _HiiJhonsState createState() => _HiiJhonsState();
}

dynamic data;

class _HiiJhonsState extends State<HiiJhons> {
  static dynamic reviewRattingData = '';
  TextEditingController searchController = TextEditingController();
  CarouselController buttonCarouselController = CarouselController();
  CarouselController imageSlindingController = CarouselController();
  PageController imagesController =
      PageController(initialPage: 0, viewportFraction: 1.1);
  // static dynamic extraProduct;
  int _current = 0;
  int pageData = 5;
  Map<String, dynamic> collectionEdges;
  bool abc;

  double rating = 3.5;
  ScrollController controller;
  var _isVisible;
  bool _isLoading;
  bool _loadMoreData;
  bool _isSearching;
  dynamic nameString;
  dynamic varjson;
  dynamic mujson;
  dynamic collectionEdgesSearch;

  final List<String> banner = [
    'assets/images/banner-1x.png',
    'assets/images/banner-2x.png',
    'assets/images/banner-3x.png'
  ];
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    reviewsProduct();
    callData(pageData);

    _isVisible = true;
    controller = new ScrollController();
    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.position.pixels == 0) {
          // You're at the top.
        } else {
          callMoreData();
        }
      }
      contollerEvent();
    });
    //  addExtras();
    super.initState();
  }

  contollerEvent() {
    if (controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isVisible == true) {
        setState(() {
          _isVisible = false;
        });
      }
    } else {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        if (_isVisible == false) {
          setState(() {
            _isVisible = true;
          });
        }
      }
    }
  }

  callMoreData() {
    pageData += 10;
    if (searchController.text.toString().trim().isEmpty) {
      setState(() {
        _loadMoreData = true;
        callData(pageData);
      });
    } else {
      setState(() {
        _loadMoreData = true;
        searchData(pageData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
    );
    SizeConfig().init(context);

    return Scaffold(
        body: _isLoading == true
            ? LoaderIndicator(_isLoading)
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 155,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              });
                            },
                            child: ListView(
                              controller: controller,
                              shrinkWrap: true,
                              physics: varjson.isEmpty
                                  ? NeverScrollableScrollPhysics()
                                  : ScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                topText(),
                                bannerImage(),
                                bannerIndicatr(),
                                searchBar(),
                                commonWidget(),
                              ],
                            ),
                          ),
                          //startOrderButton())
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    //startOrderButton(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Container(
                          width: double.infinity,
                          child: Container(
                            color: Colors.transparent,
                            child: MaterialButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              height: 50,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllMealsData(condition: true)));
                              },
                              color: greenColor,
                              textColor: Colors.white,
                              child: Text(
                                "Start my order",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: sourceSansPro),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ));
  }

  commonWidget() {
    return _isSearching == true
        ? searchingRwaponse()
        : Column(
            children: [
              offerListData(),
              // listCicularIndicatorBottom()   // change me
            ],
          );
  }

  searchingRwaponse() {
    return Container(
      height: MediaQuery.of(context).size.height - 300,
      child: LoaderIndicator(_isSearching),
    );
  }

  Widget noOfferItems() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      alignment: Alignment.center,
      height: 150,
      child: Text(
        "No offer available",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget startOrderButton() {
  //   final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
  //     child: showFab == true
  //         ? Container(
  //             width: double.infinity,
  //             child: Visibility(
  //                 visible: _isVisible,
  //                 child: Container(
  //                   color: Colors.transparent,
  //                   child: MaterialButton(
  //                     elevation: 0,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(25)),
  //                     height: 50,
  //                     onPressed: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => Information()));
  //                     },
  //                     color: greenColor,
  //                     textColor: Colors.white,
  //                     child: Text(
  //                       "Start my order",
  //                       style: TextStyle(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w600,
  //                           fontFamily: sourceSansPro),
  //                     ),
  //                   ),
  //                 )))
  //         : null,
  //   );
  // }

  Widget noOfferAvailable() {
    return Container(
      height: MediaQuery.of(context).size.height - 340,
      child: Center(
        child: Text(
          "No Data Found",
          style: TextStyle(fontSize: 17, fontFamily: sansBold),
        ),
      ),
    );
  }

  offerListData() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: varjson.isEmpty
            ? noOfferAvailable()
            : ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 1, // change me
                itemBuilder: (context, index) {
                  dynamic data = varjson[index];
                  dynamic nredata = data['node'];
                  dynamic prodata = nredata['products'];

                  dynamic edges = prodata['edges'];
                  print(edges);

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${data['node']['title']}".toUpperCase(),
                            style: TextStyle(
                                fontSize: 26,
//fontFamily: monsterdRegular,
                                fontFamily: monstExtrabold,
                                color: Color(0xff044239),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Container(
                          height: edges.isEmpty ? 220 : 340, //360
                          child: PageIndicatorContainer(
                            align: IndicatorAlign.bottom,
                            length: edges.length > 4 ? 4 : edges.length,
                            indicatorSpace: 10.0,
                            padding: const EdgeInsets.only(top: 10),
                            indicatorColor: Colors.grey[300],
                            indicatorSelectorColor: Colors.green,
                            shape: IndicatorShape.circle(size: 12),
                            child: edges.isEmpty
                                ? noOfferItems()
                                : PageView.builder(
                                    controller: imagesController,
                                    itemCount:
                                        edges.length > 4 ? 4 : edges.length,
                                    itemBuilder: (context, index) {
                                      dynamic items = edges[index];
                                      Map<String, dynamic> img;
                                      Map<String, dynamic> variants;
                                      dynamic newText;

                                      var title;
                                      var lacalTagdat = [];
                                      for (final list in items['node']
                                          ['tags']) {
                                        if (list == 'new') {
                                          newText = list;
                                        } else {
                                          lacalTagdat.add(list);
                                        }
                                      }

                                      CommonFunctions().console(lacalTagdat);
                                      img = items['node']['images']['edges'][0];
                                      variants =
                                          items['node']['variants']['edges'][1];

                                      if (variants['node']['title'] == '2' ||
                                          variants['node']['title'] == '4' ||
                                          variants['node']['title'] == '6') {
                                        title = 'plate';
                                      } else {
                                        title = variants['node']['title'];
                                      }
                                      return Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Pesionalized(
                                                            data: items,
                                                            isFrom: true,
                                                            isFromDB:
                                                                false), //AlldataList(data:data)
                                                  ));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 30),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.grey[300])),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                      //height: 150,
                                                      //image and new text
                                                      child: Stack(
                                                    children: [
                                                      //image
                                                      Container(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5)),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                "${img['node']['src']}",
                                                            height: 180,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(
                                                              color: Colors
                                                                  .white38,
                                                              height: 180,
                                                              width: double
                                                                  .infinity,
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Container(
                                                                    color: Colors
                                                                        .white38,
                                                                    height: 180,
                                                                    width: double
                                                                        .infinity,
                                                                    child: Icon(
                                                                        Icons
                                                                            .error)),
                                                          ),
                                                        ),
                                                      ),

                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: newText ==
                                                                    null
                                                                ? Container()
                                                                //new text
                                                                : Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xffE2B981),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15)),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left: 8,
                                                                        right:
                                                                            8,
                                                                        top: 3,
                                                                        bottom:
                                                                            2,
                                                                      ),
                                                                      child: Text(
                                                                          "$newText"
                                                                              .toUpperCase(),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 10)),
                                                                    ),
                                                                  ),
                                                          ))
                                                    ],
                                                  )),
                                                  //product type
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 10,
                                                            left: 8,
                                                            right: 8),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2 -
                                                                35,
                                                            child: Text(
                                                              "${items['node']['productType']}"
                                                                  .toUpperCase(),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      montserratBold,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              25,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  String.fromCharCodes(
                                                                      new Runes(
                                                                          '\u0024' +
                                                                              "${double.parse(variants['node']['price']) / 4}")),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          montserratBold),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child:
                                                                    Container(
                                                                  child: Text(
                                                                      "/plate",
                                                                      //+
                                                                      //"$title",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //title
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              bottom: 12,
                                                              right: 8),
                                                      child: Text(
                                                        "${items['node']['title']}"
                                                            .toUpperCase(),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                montserratBold,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                  ),
                                                  //container text
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4),
                                                    height: 25,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: lacalTagdat
                                                                  .length >=
                                                              3
                                                          ? 3
                                                          : lacalTagdat.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Wrap(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          2),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xffD8F2E7),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 12,
                                                                      right: 12,
                                                                      top: 4,
                                                                      bottom:
                                                                          4),
                                                                  child: Text(
                                                                    "${lacalTagdat[index]}"
                                                                        .toUpperCase(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10.5,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontFamily:
                                                                            montserratBold,
                                                                        color: Color(
                                                                            0xff2C3B36)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
      ),
    );
  }

  Widget listCicularIndicatorBottom() {
    return Container(
        child: _loadMoreData == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoaderIndicatorList(_loadMoreData),
              )
            : Container());
  }

  Widget topText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "You have",
                style: TextStyle(fontFamily: sansBold, fontSize: 18),
              ),
            ),
            Container(
              child: Text(
                  String.fromCharCodes(
                    new Runes(' \u002425 '),
                  ),
                  style: TextStyle(
                      fontFamily: sansBold, color: greenColor, fontSize: 18)),
            ),
            Container(
              child: Text(
                "store credit",
                style: TextStyle(fontFamily: sansBold, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bannerImage() {
    final double height = SizeConfig.screenHeight * 15;
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: SizeConfig.blockSizeVertical * 15,
        child: CarouselSlider(
          carouselController: buttonCarouselController,
          options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
              reverse: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: banner
              .map((item) => Container(
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Image.asset(
                        item,
                        fit: BoxFit.fitWidth,
                        height: height,
                      )),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget bannerIndicatr() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: banner.map((url) {
        int index = banner.indexOf(url);
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index ? greenColor : Colors.grey[300]),
        );
      }).toList(),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]),
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width - 120,
                child: TextField(
                  controller: searchController,
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                  onChanged: (value) {
                    if (value.length == 0) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _isSearching = true;
                        callData(pageData);
                      });
                    }
                  },
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    if (searchController.text.toString().trim().isNotEmpty) {
                      setState(() {
                        _isSearching = true;
                        searchData(pageData);
                      });
                    }
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30),
                      hintText: 'Search meals',
                      hintStyle: TextStyle(
                          fontFamily: sourceSansPro,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      border: InputBorder.none),
                )),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  if (searchController.text.toString().trim().isNotEmpty) {
                    setState(() {
                      _isSearching = true;
                      searchData(pageData);
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(23),
                        bottomRight: Radius.circular(23),
                      )),
                  height: 53,
                  width: 80,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  callData(pageDataCount) async {
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
        '''{"query":"{\\r\\n  shop {\\r\\n    collections(first: $pageDataCount) {\\r\\n      edges {\\r\\n        node {\\r\\n          id\\r\\n          title\\r\\n          products(first: $pageDataCount) {\\r\\n            edges {\\r\\n              node {\\r\\n                id\\r\\n                title\\r\\n                productType\\r\\n                description\\r\\n                tags\\r\\n                images(first: $pageDataCount) {\\r\\n                  edges {\\r\\n                    node {\\r\\n                       id\\r\\n                       src\\r\\n                 }\\r\\n             }\\r\\n            }\\r\\n            variants(first: $pageDataCount){\\r\\n                edges{\\r\\n                    node{\\r\\n                    id\\r\\n                    price\\r\\n                    title\\r\\n                    available\\r\\n                    }\\r\\n                }\\r\\n            }\\r\\n            }\\r\\n            }\\r\\n          }\\r\\n        }\\r\\n      }\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';

    //print(['data']);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      setState(() {
        _isLoading = false;
        _isSearching = false;
      });
      mujson = json.decode(responseJson);
      collectionEdges = mujson['data']['shop']['collections'];

      varjson = collectionEdges['edges'];
    } else {
      print(response.reasonPhrase);
    }
  }

  searchData(pageData) async {
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
        '''{"query":"{\\r\\n  shop {\\r\\n    collections(first: $pageData, query: \\"${searchController.text.toString().trim()}\\") {\\r\\n      edges {\\r\\n        node {\\r\\n          id\\r\\n          title\\r\\n          products(first: $pageData) {\\r\\n            edges {\\r\\n              node {\\r\\n                id\\r\\n                title\\r\\n                productType\\r\\n                description\\r\\n                tags\\r\\n                images(first: $pageData) {\\r\\n                  edges {\\r\\n                    node {\\r\\n                       id\\r\\n                       src\\r\\n                 }\\r\\n             }\\r\\n            }\\r\\n            variants(first: $pageData){\\r\\n                edges{\\r\\n                    node{\\r\\n                    id\\r\\n                    price\\r\\n                    title\\r\\n                    available\\r\\n                    }\\r\\n                }\\r\\n            }\\r\\n            }\\r\\n            }\\r\\n          }\\r\\n        }\\r\\n      }\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';

    // '''{"query":"{\\r\\n  shop {\\r\\n    collections(first: $pageData, query: \\"${searchController.text.toString().trim()}\\") {\\r\\n      edges {\\r\\n        node {\\r\\n          id\\r\\n          title\\r\\n          products(first: 50) {\\r\\n            edges {\\r\\n              node {\\r\\n                id\\r\\n                title\\r\\n                productType\\r\\n                description\\r\\n                images(first: 50) {\\r\\n                  edges {\\r\\n                    node {\\r\\n                       id\\r\\n                       src\\r\\n                 }\\r\\n             }\\r\\n            }\\r\\n            variants(first: 50){\\r\\n                edges{\\r\\n                    node{\\r\\n                    price\\r\\n                    title\\r\\n                    }\\r\\n                }\\r\\n\\r\\n            }\\r\\n              }\\r\\n            }\\r\\n          }\\r\\n        }\\r\\n      }\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      setState(() {
        _isSearching = false;
        _loadMoreData = false;
      });
      // print("$responseJson");
      dynamic mujsonSearch = json.decode(responseJson);
      varjson = mujsonSearch['data']['shop']['collections']['edges'];

      //   print("$varjson");
    } else {
      print(response.reasonPhrase);
    }
  }

  reviewsProduct() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic cHVia2V5LXQ0cjM1NU9CMDg1S0wwd1pFOTFIQjNITVdoNDQ1NTprZXktaTNwNzg3OHFqNml6Mk92cjRhYk83OTZ4aVpVMkJj'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://stamped.io/api/v2/160111/dashboard/products?page=1'));
    request.body = json.encode({
      "productId": 123456,
      "productTitle": "iPod",
      "productImageUrl": "https://store.com/image.png",
      "productUrl": "https://store.com/product",
      "type": "product type",
      "brand": "product brand",
      "sku": "product sku"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      Review.reviewRatingList.clear();
      dynamic responseJson = await response.stream.bytesToString();
      dynamic result = json.decode(responseJson);
      Review.reviewRatingData = result['results'];
      for (var product in Review.reviewRatingData) {
        Review.reviewRatingList.add(product);
      }
      reviews2Product();
      // print("Totoal_Recors...${Review.reviewRatingList.length}");
    } else {
      print(response.reasonPhrase);
    }
  }

  reviews2Product() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic cHVia2V5LXQ0cjM1NU9CMDg1S0wwd1pFOTFIQjNITVdoNDQ1NTprZXktaTNwNzg3OHFqNml6Mk92cjRhYk83OTZ4aVpVMkJj'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://stamped.io/api/v2/160111/dashboard/products?page=2'));
    request.body = json.encode({
      "productId": 123456,
      "productTitle": "iPod",
      "productImageUrl": "https://store.com/image.png",
      "productUrl": "https://store.com/product",
      "type": "product type",
      "brand": "product brand",
      "sku": "product sku"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      dynamic result = json.decode(responseJson);
      Review.reviewRatingData = result['results'];
      for (var product in Review.reviewRatingData) {
        Review.reviewRatingList.add(product);
      }
      reviews3Product();
      // print("Totoal_Recors...${Review.reviewRatingList.length}");
    } else {
      print(response.reasonPhrase);
    }
  }

  reviews3Product() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic cHVia2V5LXQ0cjM1NU9CMDg1S0wwd1pFOTFIQjNITVdoNDQ1NTprZXktaTNwNzg3OHFqNml6Mk92cjRhYk83OTZ4aVpVMkJj'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://stamped.io/api/v2/160111/dashboard/products?page=3'));
    request.body = json.encode({
      "productId": 123456,
      "productTitle": "iPod",
      "productImageUrl": "https://store.com/image.png",
      "productUrl": "https://store.com/product",
      "type": "product type",
      "brand": "product brand",
      "sku": "product sku"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      dynamic result = json.decode(responseJson);
      Review.reviewRatingData = result['results'];
      for (var product in Review.reviewRatingData) {
        Review.reviewRatingList.add(product);
      }
      reviews4Product();
      //print("Totoal_Recors...${Review.reviewRatingList.length}");
    } else {
      print(response.reasonPhrase);
    }
  }

  reviews4Product() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic cHVia2V5LXQ0cjM1NU9CMDg1S0wwd1pFOTFIQjNITVdoNDQ1NTprZXktaTNwNzg3OHFqNml6Mk92cjRhYk83OTZ4aVpVMkJj'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://stamped.io/api/v2/160111/dashboard/products?page=4'));
    request.body = json.encode({
      "productId": 123456,
      "productTitle": "iPod",
      "productImageUrl": "https://store.com/image.png",
      "productUrl": "https://store.com/product",
      "type": "product type",
      "brand": "product brand",
      "sku": "product sku"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      dynamic responseJson = await response.stream.bytesToString();
      dynamic result = json.decode(responseJson);
      Review.reviewRatingData = result['results'];
      for (var product in Review.reviewRatingData) {
        Review.reviewRatingList.add(product);
      }

      print("total_records...${Review.reviewRatingList.length}");
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
