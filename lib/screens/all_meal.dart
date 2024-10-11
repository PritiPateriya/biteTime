import 'dart:convert';

import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/sizedbox_common.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/model/count.dart';
import 'package:bitetime/screens/persionalize.dart';
// ignore: unused_import
import 'package:bitetime/screens/your_order.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AllMealsData extends StatefulWidget {
  final bool condition;
  AllMealsData({
    this.condition,
  });
  @override
  _AllMealsDataState createState() => _AllMealsDataState();
}

bool isFrom;

class _AllMealsDataState extends State<AllMealsData> {
  ScrollController controller = ScrollController();
  bool _isLoading;
  double rating = 4;
  dynamic mujson;
  dynamic collectionEdges;
  dynamic varjson;
  int pageData = 10;
  bool _loadMoreData = true;
  dynamic listAllMeal;
  bool abc;
  var num = 1;
//variPrice = "${variants['node']['price']}";
  @override
  void initState() {
    print("=====${widget.condition}condition");
    abc = widget.condition;
    _isLoading = true;
    callData(pageData);
    controller = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      setState(() {
        pageData += 50;
        _loadMoreData = true;
        callData(pageData);
      });
    }
  }

  bool get mounted => super.mounted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: abc == true
          ? AppBar(
              centerTitle: true,
              title: Text(
                "All meals",
                style: newAppbartextStyle,
              ),
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
            )
          : AppBar(
              toolbarHeight: 0.0,
            ),
      body: _isLoading == true
          ? LoaderIndicator(_isLoading)
          : ListView.builder(
              controller: controller,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: listAllMeal.length,
              itemBuilder: (ctx, index) {
                dynamic data = listAllMeal[index];

                Map<String, dynamic> img;
                Map<String, dynamic> variants;
                dynamic newText;

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

                variants = data['node']['variants']['edges'][1];

                if (variants['node']['title'] == '2' ||
                    variants['node']['title'] == '4' ||
                    variants['node']['title'] == '6') {
                  title = 'plate';
                } else {
                  title = variants['node']['title'];
                }
                print('$variants');

                if (index == listAllMeal.length - 1 && _loadMoreData == true) {
                  return listCicularIndicatorBottom();
                } else {
                  return GestureDetector(
                    onTap: () {
                      CommonFunctions()
                          .console("------------------------------data:-$data");
                      // ignore: unnecessary_statements
                      abc == true
                          ? Provider.of<AddMoreItems>(context, listen: false)
                              .addMoreItems(data)
                          // ignore: unnecessary_statements
                          : Navigator.of(context);
                      abc == true
                          // ? Navigator.pop(context)
                          // ? Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             Pesionalized(data: data, isFrom: true)),
                          //   )
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pesionalized(
                                        data: data,
                                        isFrom: true,
                                      )))
                          : Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pesionalized(
                                        data: data,
                                        isFrom: true,
                                      )));
                    },
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
                                          child: CachedNetworkImage(
                                            imageUrl: "${img['node']['src']}",
                                            height: 190,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                              color: Colors.white38,
                                              height: 180,
                                              width: double.infinity,
                                            ),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Container(
                                                    color: Colors.white38,
                                                    height: 180,
                                                    width: double.infinity,
                                                    child: Icon(Icons.error)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: newText == null
                                              ? Container()
                                              : Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffE2B981),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                        right: 8,
                                                        top: 3,
                                                        bottom: 2,
                                                      ),
                                                      child: Text(
                                                          "$newText"
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 10)),
                                                    ),
                                                  ),
                                                ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 20, 8, 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              10,
                                          child: Text(
                                            "${data['node']['productType']}"
                                                .toUpperCase(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: monsterdMidium,
                                                fontWeight: FontWeight.w400,
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
                                                "\u0024${double.parse(variants['node']['price']) / 4}",
                                                // String.fromCharCodes(new Runes(
                                                //     '\u0024' +
                                                //         "${variants['node']['price']} % (num)")),
                                                style: TextStyle(
                                                    fontFamily: mBold),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                  child: Text(
                                                "/plate",
                                                //  "/" + "$title",
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
                                        left: 8, right: 8),
                                    child: Text(
                                      "${data['node']['title']}".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: monsterdRegular,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                CommonSized(12),
                                // tagList(),
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xffD8F2E7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12,
                                                    right: 12,
                                                    top: 4,
                                                    bottom: 4),
                                                child: Text(
                                                  "${lacalTagdat[index]}"
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
    );
  }

  // Widget tagList() {
  //   return ((tagList.length> 0)
  //       ? Container(
  //           padding: EdgeInsets.symmetric(horizontal: 5),
  //           height: lacalTagdat.length > 4 ? 30 : 15,
  //           alignment: Alignment.centerLeft,
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             scrollDirection: Axis.horizontal,
  //             itemCount: lacalTagdat.length,
  //             itemBuilder: (context, index) {
  //               return Wrap(
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 2),
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                           color: Color(0xffD8F2E7),
  //                           borderRadius: BorderRadius.circular(15)),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(
  //                             left: 12, right: 12, top: 4, bottom: 4),
  //                         child: Text(
  //                           "${lacalTagdat[index]}".toUpperCase(),
  //                           style: TextStyle(
  //                               fontSize: 10,
  //                               fontWeight: FontWeight.w600,
  //                               //fontFamily: monsterdRegular,
  //                               color: Color(0xff2C3B36)),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             },
  //           ),
  //         )
  //       : Container());
  // }

  Widget listCicularIndicatorBottom() {
    return Container(
        child: _loadMoreData == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoaderIndicatorList(_loadMoreData),
              )
            : Container());
  }

  callData(pageData) async {
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
        '''{"query":"{\\r\\n  shop {\\r\\n    collections(first: $pageData, query: \\"All Meal\\") {\\r\\n      edges {\\r\\n        node {\\r\\n          id\\r\\n          title\\r\\n          products(first: $pageData) {\\r\\n            edges {\\r\\n              node {\\r\\n                id\\r\\n                title\\r\\n                productType\\r\\n                description\\r\\n                tags\\r\\n                images(first: $pageData) {\\r\\n                  edges {\\r\\n                    node {\\r\\n                       id\\r\\n                       src\\r\\n                 }\\r\\n             }\\r\\n            }\\r\\n            variants(first: $pageData){\\r\\n                edges{\\r\\n                    node{\\r\\n                    id\\r\\n                    price\\r\\n                    title\\r\\n                    available\\r\\n                    }\\r\\n                }\\r\\n            }\\r\\n            }\\r\\n            }\\r\\n          }\\r\\n        }\\r\\n      }\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      setState(() {
        _isLoading = false;
      });
      mujson = json.decode(responseJson);
      collectionEdges = mujson['data']['shop']['collections'];

      varjson = collectionEdges['edges'];

      // print(varjson);
      for (final allmeal in varjson) {
        dynamic title = allmeal['node']['title'];

        if (title == 'All meals') {
          listAllMeal = allmeal['node']['products']['edges'];
        }
      }

      CommonFunctions().console(listAllMeal);
    } else {
      print(response.reasonPhrase);
    }
  }
}
