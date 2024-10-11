import 'dart:convert';
import 'dart:math' as math;

import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/media_quary_size_type.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/screens/registration.dart';
// ignore: unused_import
import 'package:bitetime/screens/thank_you.dart';
import 'package:bitetime/screens/write_review/write_revieww.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Reviews extends StatefulWidget {
  final dynamic ratingPId;

  Reviews({
    Key key,
    this.ratingPId,
  }) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  int likeCount = 0;
  int dirLikeCount = 0;
  var resulstsData;
  bool _isLoading;
  dynamic ratingPId = '';

  like() {
    setState(() {
      likeCount++;
    });
  }

  disLike() {
    setState(() {
      dirLikeCount++;
    });
  }

  @override
  void initState() {
    ratingPId = widget.ratingPId;
    reviewListApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
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
        title: Text("Reviews", style: newAppbartextStyle),
      ),
      body: _isLoading == true
          ? LoaderIndicator(_isLoading)
          : Stack(
              children: [
                ListView(
                  children: [
                    Column(children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 30),
                      //   child: Text(resulstsData['productName'].toString(),
                      //       style: TextStyle(
                      //           fontFamily: montserratBold,
                      //           letterSpacing: 0.5,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w700,
                      //           fontSize: 18)),
                      // ),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: resulstsData.length,
                            itemBuilder: (context, index) {
                              dynamic data = resulstsData[index];
                              CommonFunctions().console(data);
                              double ratingVal =
                                  double.parse("${data['reviewRating']}");
                              dynamic isConfirmed =
                                  "${data['reviewVerifiedType']}";
                              //  CommonFunctions().console(isConfirmed);
                              // var dateFormate = DateFormat("dd/MM/yyyy").format(
                              //     DateTime.parse("${data['reviewDate']}"));
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                        "${resulstsData[index]['productName']}",
                                        style: TextStyle(
                                            fontFamily: montserratBold,
                                            letterSpacing: 0.5,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15)),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                (56 / 100),
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 16,
                                            right: 16,
                                            bottom: 20),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.5,
                                              color: Colors.black12),
                                        ),
                                        child: ListView(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SmoothStarRating(
                                                    allowHalfRating: true,
                                                    onRated: (v) {},
                                                    starCount: 5,
                                                    rating: ratingVal,
                                                    size: 19.0,
                                                    isReadOnly: true,
                                                    filledIconData: Icons.star,
                                                    color: Color(0xff0AB36C),
                                                    borderColor:
                                                        Color(0xff0AB36C),
                                                    spacing: 2.0),
                                                Text("${data['reviewDate']}",
                                                    //  "$dateFormate",
                                                    style: TextStyle(
                                                        // fontFamily: sourceSansPro,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14))
                                              ],
                                            ),
                                            SizedBox(
                                              height: FsDimens.space20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("${data['author']}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontFamily:
                                                            sansSemiBold,
                                                        fontSize: 16)),
                                                SizedBox(
                                                  width: FsDimens.space10,
                                                ),
                                                // isConfirmed == "true"
                                                (isConfirmed.length > 0)
                                                    ? Text(
                                                        //"${data['reviewVerifiedType']}",
                                                        "Verified Buyer",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff0AB36C),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16))
                                                    : Text(''),
                                              ],
                                            ),
                                            SizedBox(
                                              height: FsDimens.space32,
                                            ),
                                            Text("${data['reviewTitle']}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: sansBold,
                                                    fontSize: 16)),
                                            SizedBox(
                                              height: FsDimens.space24,
                                            ),
                                            Text("${data['reviewMessage']}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: sansSemiBold,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16)),
                                            SizedBox(
                                              height: FsDimens.space100,
                                            ),
                                            Text(
                                                "${resulstsData[index]['productName']}",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: sansBold,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16)),
                                            SizedBox(
                                              height: FsDimens.space10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Share.share(
                                                    'check out my website https://example.com',
                                                    subject:
                                                        'Look what I made!');
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.screen_share_outlined,
                                                    color: Colors.black54,
                                                    size: 22,
                                                  ),
                                                  SizedBox(
                                                    width: FsDimens.space4,
                                                  ),
                                                  Text("Share",
                                                      style: TextStyle(
                                                          // fontFamily: sourceSansPro,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: FsDimens.space4,
                                            ),
                                            Row(
                                              children: [
                                                Text("Was this helpful?",
                                                    style: TextStyle(
                                                        // fontFamily: sourceSansPro,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15)),
                                                SizedBox(
                                                  width: FsDimens.space8,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    like();
                                                  },
                                                  child: Icon(
                                                    Icons.thumb_up,
                                                    color: Colors.black87,
                                                    size: 15,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: FsDimens.space8,
                                                ),
                                                Text("$likeCount",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            sourceSansPro,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15)),
                                                SizedBox(
                                                  width: FsDimens.space8,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    disLike();
                                                  },
                                                  child: Transform(
                                                    alignment: Alignment.center,
                                                    transform:
                                                        Matrix4.rotationY(
                                                            math.pi),
                                                    child: Icon(
                                                      Icons.thumb_down,
                                                      color: Colors.black87,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: FsDimens.space8,
                                                ),
                                                Text("$dirLikeCount",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            sourceSansPro,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ]),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    writeReviewButton(),
                    // SizedBox(
                    //   height: FsDimens.space20,
                    // ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget writeReviewButton() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          child: GreenButton(
            key: Key('write_review_submit'),
            buttonName: "Write a review",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WriteReview()));
            },
          ),
        ));
  }

  reviewListApi() async {
    setState(() {
      _isLoading = true;
    });
    var headers = {
      'Authorization':
          'Basic cHVia2V5LXQ0cjM1NU9CMDg1S0wwd1pFOTFIQjNITVdoNDQ1NTprZXktaTNwNzg3OHFqNml6Mk92cjRhYk83OTZ4aVpVMkJj'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://stamped.io/api/widget/reviews?productId=$ratingPId&productType&productTitle&email&isWithPhotos&minRating&take&page&dateFrom&dateTo&sortReviews&tags&storeUrl=getbitetime.myshopify.com&apiKey=pubkey-t4r355OB085KL0wZE91HB3HMWh4455'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dynamic responseJson = await response.stream.bytesToString();
      dynamic jsonData = json.decode(responseJson);
      setState(() {
        _isLoading = false;
      });
      resulstsData = jsonData['data'];

      print('review....$resulstsData');
    } else {
      print(response.reasonPhrase);
    }
  }
}
