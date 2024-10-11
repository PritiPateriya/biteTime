import 'package:bitetime/common_files/sizedbox_common.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/screens/persionalize.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AllDataList extends StatefulWidget {
  final dynamic data;
  AllDataList({Key key, this.data}) : super(key: key);
  @override
  _AllDataListState createState() => _AllDataListState();
}

bool isFrom;

class _AllDataListState extends State<AllDataList> {
  dynamic dataOfList;
  double rating = 4;
  @override
  void initState() {
    dataOfList = widget.data;
    listData = dataOfList['node']['products']['edges'];
    super.initState();
  }

  dynamic listData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:
            Text("${dataOfList['node']['title']}", style: newAppbartextStyle),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: listData.length,
                itemBuilder: (ctx, index) {
                  dynamic data = listData[index];

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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Pesionalized(data: data, isFrom: true)),
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // height: 290,
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
                                            height: 180,
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
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      left: 8,
                                      right: 10,
                                      bottom: 10),
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
                                                String.fromCharCodes(new Runes(
                                                    '\u0024' +
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
                                        left: 8, right: 8),
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
                                                      fontFamily:
                                                          monsterdRegular,
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
                }),
          )
        ],
      ),
    );
  }
}
