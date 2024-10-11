import 'dart:convert';
import 'dart:io';

import 'package:bitetime/common_files/common_widget.dart';
import 'package:bitetime/common_files/fs_dimens.dart';
import 'package:bitetime/common_files/greenButton.dart';
import 'package:bitetime/common_files/loader_indicator.dart';
import 'package:bitetime/common_files/logger_print.dart';
import 'package:bitetime/common_files/mytextfield.dart';
import 'package:bitetime/common_files/styles.dart';
import 'package:bitetime/common_files/validation.dart';
import 'package:bitetime/screens/thank_you.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WriteReview extends StatefulWidget {
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  SharedPreferences preferences;
  TextEditingController rNameCon = TextEditingController();
  TextEditingController rEmailCon = TextEditingController();
  TextEditingController exCon = TextEditingController();
  TextEditingController rTitleCon = TextEditingController();
  TextEditingController rMessageCon = TextEditingController();
  double rating = 0.0;

  var responseToken;

  @override
  void initState() {
    initializePreference().whenComplete(() {
      setState(() {
        var responseJson = this.preferences.getString('TOKEN');
        var res = json.decode(responseJson);
        print("$res");
        responseToken = res['id'];
      });
    });

    super.initState();
  }

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
  }

  File _image;
  final picker = ImagePicker();
  bool _isLoading;
  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        showToastMessage("Added photo", context);
        setState(() {
          _image = image;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      showToastMessage("Added Gallery Image", context);
      setState(() {
        _image = image;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Image Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImageCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text("Write a review", style: newAppbartextStyle),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 20, left: 15),
                child: Column(
                  children: [
                    Text(
                      "Three cheese beef lasagna",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          fontFamily: montserratBold,
                          letterSpacing: 0.5,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    nameField(),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    emailField(),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    starField(),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    titleOfReviewField(),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("How was your overall experience?",
                          style: TextStyle(
                            color: Color(0xff1F2D3D),
                            fontSize: 18,
                            fontFamily: sourceSansPro,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          )),
                    ),
                    SizedBox(
                      height: FsDimens.space10,
                    ),
                    feedBackField(),
                    SizedBox(
                      height: FsDimens.space10,
                    ),
                    _image == null ? Container() : imagee(),
                    SizedBox(
                      height: FsDimens.space52,
                    ),
                    addPhotosField(),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                    submitButton(),
                    SizedBox(
                      height: FsDimens.space20,
                    ),
                  ],
                ),
              ),
            ),
            LoaderIndicator(_isLoading)
          ],
        ),
      ),
    );
  }

  Widget nameField() {
    return AllInputDesign(
        key: Key("review_name"),
        inputHeaderName: 'Name',
        controller: rNameCon,
        hintText: '${this.preferences?.getString("first_name")}',
        validatorFieldValue: '${this.preferences?.getString("first_name")}',
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget emailField() {
    return AllInputDesign(
        key: Key("write_review"),
        textInputAction: TextInputAction.next,
        inputHeaderName: 'Email',
        controller: rEmailCon,
        hintText: '${this.preferences?.getString("email")},',
        validatorFieldValue: 'Email',
        validator: validEmailField,
        keyBoardType: TextInputType.emailAddress);
  }

  Widget starField() {
    return Align(
      alignment: Alignment.center,
      child: SmoothStarRating(
          allowHalfRating: true,
          halfFilledIconData: Icons.star_half,
          onRated: (v) {
            this.rating = v;
            setState(() {});
          },
          starCount: 5,
          rating: rating,
          size: 50.0,
          filledIconData: Icons.star,
          color: greenColor,
          borderColor: greenColor,
          spacing: 2.0),
    );
  }

  Widget titleOfReviewField() {
    return AllInputDesign(
        key: Key("title_name"),
        inputHeaderName: 'Title of review',
        controller: rTitleCon,
        hintText: 'Title of review',
        validatorFieldValue: 'Title of review',
        validator: userNameValidation,
        keyBoardType: TextInputType.name);
  }

  Widget feedBackField() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(color: Colors.black54, width: 0.2)),
      child: TextFormField(
        controller: rMessageCon,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.grey,
        maxLines: 8,
        autocorrect: true,
        decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.red),

            // errorText: feedError,
            contentPadding: const EdgeInsets.only(left: 8, top: 10),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black54, width: 0.2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black54, width: 0.2),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black54, width: 0.2))),
        style: TextStyle(color: univerBackgCBlue, fontSize: 20),
        key: Key("Experience_field"),

        // validator: ,
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget imagee() {
    return Container(
      height: 200,
      width: 100,
      child: Image.file(_image),
    );
  }

  Widget addPhotosField() {
    var screenSize = MediaQuery.of(context).size.width - 40;
    return Container(
      height: 48.0,
      width: MediaQuery.of(context).size.width - 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
          border: Border.all(color: Color(0xff0BBC6B), width: 2)),
      // ignore: deprecated_member_use
      child: RaisedButton(
          key: Key('add_photo'),
          elevation: 1.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Text(
            "Add photos",
            style: TextStyle(
              inherit: true,
              color: Color(0xff0BBC6B),
              fontSize: screenSize <= 350 ? 18.0 : 20.0,
              letterSpacing: 1,
              fontFamily: sourceSansPro,
              fontWeight: FontWeight.w900,
            ),
          ),
          onPressed: () {
            _showPicker(context);
          }),
    );
  }

  Widget submitButton() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          child: GreenButton(
            key: Key('review_submit'),
            buttonName: "Submit",
            onPressed: () {
              onPressSubmitButton();
            },
          ),
        ));
  }

  onPressSubmitButton() {
    CommonFunctions().console("hefdkvdljiobjbmdkb");
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (rNameCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter name", context);
    } else if (rEmailCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter Email", context);
    } else if (rEmailCon.text.toString().trim().isNotEmpty &&
        !regExp.hasMatch(rEmailCon.text.toString().trim())) {
      return showToastMessage("Enter valid Email", context);
    } else if (rTitleCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter title", context);
    } else if (rMessageCon.text.toString().trim().isEmpty) {
      return showToastMessage("Enter discription", context);
    } else {
      postReviews();
    }
  }

  postReviews() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': rEmailCon.text.toString().trim(),
      'location': 'indore',
      'reviewRating': rating.toString(),
      'reviewTitle': rTitleCon.text.toString().trim(),
      'reviewMessage': rMessageCon.text.toString().trim(),
      'productImageUrl': _image.toString(),
      'author': rNameCon.text.toString()
    };
    var headers = {'Authorization': 'Basic Og=='};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://stamped.io/api/reviews3?apiKey=pubkey-t4r355OB085KL0wZE91HB3HMWh4455&sId=160111'));
    request.fields.addAll(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      dynamic responseJson = await response.stream.bytesToString();
      CommonFunctions().console(responseJson);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThankYou()),
      );
    } else {
      print(response.reasonPhrase);
    }
  }
}
