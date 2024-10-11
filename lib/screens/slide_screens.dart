import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/media_quary_size_type.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/screens/login.dart';
import 'package:bitetime/strings/asset_image.dart';
import 'package:bitetime/strings/strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

final List<String> imgList = [
//'${AssetImageOfApp.dish_8}',
  '${AssetImageOfApp.icon5}',
  '${AssetImageOfApp.icon2}',
  '${AssetImageOfApp.icon3}',
  '${AssetImageOfApp.icon4}',
  //'assets/icons/dish8.png'
];

final List<String> txtList = [
  'FRESH, CHEF-MADE HOME MEALS',
  'ORDER AHEAD',
  'PERSONALIZE IT',
  'HOME DELIVERY',
];

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

bool isFromOnbord;

class _SliderScreenState extends State<SliderScreen> {
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFF00B864),
          statusBarIconBrightness: Brightness.dark),
    );
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF00B864),
                  Color(0xFF044239),
                ],
              )),
            ),
            Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //logo
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: SizeConfig.blockSizeVertical * 8,
                      child: Image.asset(
                        '${AssetImageOfApp.logoimage}',
                        fit: BoxFit.fitHeight,
                        height: SizeConfig.blockSizeVertical * 6.5,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Column(
                      children: [
                        Container(
                          height:
                              MediaQuery.of(context).size.height * (40 / 100),
                          child: CarouselSlider(
                            options: CarouselOptions(
                                height: SizeConfig.blockSizeVertical * 45,
                                viewportFraction: 1.0,
                                enlargeCenterPage: false,
                                autoPlay: true,
                                reverse: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                            items: imgList
                                .map((item) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              (50 / 100),
                                          height: 160,
                                          // child: Container(
                                          //   child: Image.asset(item),
                                          // ),
                                          child: SvgPicture.asset(
                                            item,
//fit: BoxFit.fill,
                                          ),
                                        ),
                                        //  ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Text(
                                                "${txtList[_current]}"
                                                    .toUpperCase(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: 0.5,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: montserratBold,
                                                )),
                                          ),
                                        )
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.map((url) {
                        int index = imgList.indexOf(url);
                        return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0), //change
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Colors.green
                                  : Colors.white),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: FsDimens.space60,
                    ),
                  ],
                );
              },
            ),
            getStartButton(),
          ],
        ),
      ),
    );
  }

  Widget getStartButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0, left: 10, right: 10),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: GreenButton(
            key: Key('${Strings.getStartButtonKey}'),
            buttonName: "${Strings.getStartButton}",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(isFromOnbord: true)));
            },
          ),
        ),
      ),
    );
  }
}
