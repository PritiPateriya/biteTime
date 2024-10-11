import 'package:flutter/material.dart';

dynamic lightBlack = Colors.black26;
dynamic darkBlack = Colors.black;
dynamic decoration = BoxDecoration(
    color: greenColor,
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ));
dynamic emptyDecoration = BoxDecoration();

TextStyle appBarTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontFamily: monsterdRegular,
);
dynamic blackColorDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5.0),
  border: Border.all(width: 2.5, color: Colors.black26),
);
dynamic greenColorDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5.0),
  border: Border.all(width: 2.5, color: Color(0xff0BBC6B)),
);
TextStyle headingStyletext = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontFamily: monsterdRegular,
);

TextStyle drawertextStyle = TextStyle(
  fontSize: 30.0,
  color: Colors.black,
  letterSpacing: 0.5,
  fontWeight: FontWeight.w400,
);
TextStyle drawerEmptytextStyle = TextStyle(
  fontSize: 30.0,
  color: Colors.white,
  letterSpacing: 0.5,
  fontWeight: FontWeight.w400,
);

TextStyle middleTextstyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontFamily: monsterdRegular,
);

TextStyle mealPlanTableCStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontFamily: monsterdRegular,
);

TextStyle mealPlanTableRDataStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.red,
  fontWeight: FontWeight.w500,
  fontFamily: monsterdRegular,
);

TextStyle noRecordtextsTyle = TextStyle(
  fontSize: 15.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontFamily: monsterdRegular,
);

const textFontColor = Color(0xFF00B5CA);
const drawerIconColor = Color(0xFFFFFFFF);
const settingIconColor = Color(0xFFFFFFFF);
const textFieldPrefixiconColor = Color(0xFF0f1e3d);
const textFontColorr = Colors.deepPurple;
const iconColor = Colors.yellow;

const universalColor = Color(0xFF044239);
const univerBackgCBlue = Color(0xFF0f1e3d);

const pAvoidBackgroundShrink = false;

const montserratBold = 'montserrat-bold';
const sourceSansPro = 'sourceSansPro-Light';
const monstExtrabold = 'monsterrad-extrabold';
const monsterdMidium = 'monsterrad-midium';
const monsterdRegular = 'monsterrad-regular';
const sansBold = 'sanspro-bold';
const sansSemiBold = 'sanspro-SemiBold';
const mBold = montserratBold;
const pCommonTextColor = Colors.black87;
const greenColor = Color(0xff00be61);

TextStyle legalPageTextStyle =
    TextStyle(color: Colors.black54, fontSize: 14.0, fontFamily: monsterdRegular
//fontWeight: FontWeight.bold
        );
Color pGlobalColor = Color(0XFF9380D5);
Color pGlobalBlack = Colors.black;
const pCommonIconColor = Color(0XFF357A93);
const pNewAppbarBackgroundColor = Colors.white;
const newScaffoldBackgroundColor = Color(0xFF0f1e3d);

const pGlobalFontFamily = monsterdRegular;
Color pGlobalListContainerBackColor = Color(0XFFF6F6F6);
Color pGlobalHeaderTextColor = Color(0XFF676767);

// Error Massage Color
const baseErrorColor = Colors.blueGrey;
Color errorColor = Colors.red.shade200;
const errorFontField = 13.0;
const buildErrBoxColor = Color(0xFFFCE0E0);
// slideBox textStyle

TextStyle newAppbartextStyle = TextStyle(
    fontFamily: sansBold,
    fontWeight: FontWeight.w100,
    fontSize: 21,
    // letterSpacing: 0.5,
    color: Color(0xff1B1C1C));

TextStyle detailViewtextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20);

TextStyle detailViewApitextStyle = TextStyle(
    color: univerBackgCBlue, fontWeight: FontWeight.w400, fontSize: 18);

TextStyle dashboradtitletextStyle = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 1);

TextStyle subtitletextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 16.0,
);

TextStyle dashboardIconFont = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    fontFamily: monsterdRegular,
    color: Colors.black);

TextStyle settingtextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  letterSpacing: 0.5,
);

TextStyle listViewDataFont = TextStyle(
    color: univerBackgCBlue, fontSize: 14, fontWeight: FontWeight.w400);

// slideBox textStyle

// listing Style

TextStyle listingHeaderTextStyle = TextStyle(
    fontSize: 17.0,
    color: Colors.black54,
    fontFamily: monsterdRegular,
    fontWeight: FontWeight.w600);

const bGBottomColor = Color(0xFF00B864);
const viewHistorybottonColor = Colors.green;
final dividecardBox = Divider(
  indent: 20.0,
  height: 20.0,
  color: Colors.grey,
);
const leftRightMargin = 0.0;
Decoration dateBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(6.0),
);

TextStyle listingDateTextStyle = TextStyle(
  color: Colors.grey.shade400,
  fontSize: 15.0,
);

Decoration pListContainerDecoration = BoxDecoration(
  color: Color(0xFFEEEEEE),
  borderRadius: BorderRadius.circular(6.0),
);

TextStyle listingNameTextStyle = TextStyle(
  color: Colors.black87,
  fontSize: 18.0,
  fontFamily: monsterdRegular,
);

TextStyle listingTimeTextStyle = TextStyle(
  color: Color(0XFFACACAC),
  fontSize: 15.0,
);
TextStyle inputLabel = TextStyle(
  color: Colors.black87,
  fontSize: 14,
  fontFamily: sourceSansPro,
);

Decoration pListBlueBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(4.0),
  color: Color(0XFF82CDEE),
);

TextStyle pListBlueBoxTextStyle = TextStyle(
  fontFamily: monsterdRegular,
  color: Colors.white,
  letterSpacing: 0.5,
  fontSize: 13.0,
);
TextStyle pListAmountTextStyle = TextStyle(
  letterSpacing: 0.5,
  color: Colors.black87,
  fontSize: 19.0,
  fontFamily: monsterdRegular,
  fontWeight: FontWeight.w600,
);
TextStyle smallFontSizeTextStyle = TextStyle(
  color: Colors.black45,
  fontSize: 13.5,
  fontFamily: monsterdRegular,
);
TextStyle pListCreditAmountTextStyle = TextStyle(
  letterSpacing: 0.3,
  color: Color(0XFF409402),
  fontSize: 19.0,
  fontWeight: FontWeight.w900,
  fontFamily: monsterdRegular,
);

TextStyle pListMinusAmountTextStyle = TextStyle(
  letterSpacing: 0.3,
  color: Color(0XFFBB0000),
  fontSize: 19.0,
  fontFamily: monsterdRegular,
  fontWeight: FontWeight.w900,
);

Decoration pListRedBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(4.0),
  color: Color(0XFFBB0000),
);
Decoration pListRefundBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(4.0),
  color: bGBottomColor,
);
Decoration pListPendingBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(4.0),
  color: Colors.amber,
);
TextStyle pListRedBoxTextStyle = TextStyle(
  fontFamily: monsterdRegular,
  color: Colors.white,
  fontSize: 15.0,
);

// listing Style

//pExpandedTileTextStyle
TextStyle pExpandedTileLeadingTextStyle = TextStyle(
  color: Color(0XFFACACAC),
  fontFamily: monsterdRegular,
  fontSize: 15.0,
  letterSpacing: 2.0,
);
TextStyle pExpandedTileSubTextTextStyle = TextStyle(
  color: Color(0XFFACACAC),
  fontSize: 16.0,
);
TextStyle expandWhiteBoxTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 13.0,
  fontFamily: monsterdRegular,
  color: Colors.grey,
);

TextStyle liteHadder = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 12.0,
  fontFamily: monsterdRegular,
  color: Colors.black54,
);

TextStyle pListSubTitleTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.black,
  fontFamily: monsterdRegular,
  letterSpacing: 1.0,
);
Decoration pExpandedTileGreyBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Colors.grey));

TextStyle pExpandedTileBlueBoxTextStyle = TextStyle(
  fontFamily: monsterdRegular,
  color: Colors.white,
  letterSpacing: 0.5,
  fontSize: 15.0,
);

// modalSheetTextStyle

TextStyle pModalSheetTextStyle = TextStyle(
  letterSpacing: 1.0,
  fontSize: 20.0,
  fontFamily: monsterdRegular,
  color: Colors.black87,
);
TextStyle newHintFontStyle = TextStyle(
  color: Colors.black87,
  // fontWeight: FontWeight.w600,
  fontSize: 15,
  //fontFamily: pCommonLightFont,
);

//hint lable style
TextStyle labelHintFontStyle = TextStyle(
    color: Colors.black,
    fontSize: 19,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.4,
    fontFamily: sourceSansPro);

TextStyle pModalSheetCardTextStyle =
    TextStyle(fontSize: 17.0, color: Colors.grey.shade400, letterSpacing: 5.0);

InputDecoration newFieldDecorationStyle() {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 12.0, top: 12.0),
    filled: true,
    fillColor: Color(0xFFEEEEEE),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(6.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFEEEEEE),
      ),
    ),
  );
}

//_____________________________________

//text field Style
const pTextFieldLabelFontSize = 16.0;
const pTextFieldFontColor = Color(0XFF357A93);
const pTextFieldBlackFontColor = Color(0xFF818181);
const pTextFieldLabelFontColor = Color(0xFFC1EAFF);
const pTextFieldFontWeight = FontWeight.w300;
const pTextLabelFieldFontColor = Colors.white;
const pTextLabelFieldFontSize = 16.0;
const pTextBigFontSize = 22.0;

const pRobotoLightFont = monsterdRegular;
const pPrimaryColor = Color(0xFFC1EAFF);
const pButtonColors = Colors.blue;
const pButtonTextColors = Colors.white;
const pBackgroundColor = Color(0xFF183845);

const pAppbarBackgroundColor = Color(0xFFfafafa);

// Common Button Style
const pButtonBackgroundColor = Color(0xFFF356a83);
const pButtonTextColor = Color(0xFFFffffff);
const pButtonHeight = 50.0;
const pButtonTextSize = 18.0;
const pButtonTextSmallSize = 16.0;
const pButtonFontWeight = FontWeight.w300;

//Flat Button
const pFlatButtonFontColor = Color(0xFFDCDCDC);

// TextColor
const pTextFontColor = Color(0xFFDCDCDC);
const pTextFontWeight = FontWeight.w300;
const pTextFontWeightstatus = FontWeight.w400;
const pTextFontFamily = monsterdRegular;
const pHeaderTextFontSize = 16.0;
const pBoxDecorationColor = Color(0x88417891);
const pTextColorOpeity = 0.6;
const pTextMidFontSize = 14.0;

// Dropdown Style
const lDropdownBackColor = Color(0xFFE0F6FF);
const lDropdownBackColorOpacity = 0.2;
const lDropdownBorderColorOpacity = 0.6;
const lDropdownBorderRadius = 8.0;
const lDropdownBorderColor = Colors.white;
const pDropdownFontSize = 16.0;
BoxDecoration pDropdownBoxDecoration = BoxDecoration(
  border: new Border.all(color: Color(0XFFF3F3F3), width: 1.0),
  color: Color(0XFFF3F3F3),
  borderRadius: new BorderRadius.circular(lDropdownBorderRadius),
);

// Error Massage Color

// Drawer
const pDrawerIconSize = 25.0;
const pDrawerFontSize = 17.0;
const pDrawerIconColor = Color(0xFFB6C2CA);
//transaction font color

const pTransactionHeaderColor = Color(0xFFB6C2CA);
const pTransactionHeaderFontSize = 13.0;
const pTransactionAmountIconSize = 15.0;
const pTransactionTitleFontSize = 15.0;
const pTransactionTimeFontSize = 12.0;
const pTransactionAmountFontSize = 20.0;
const pTextFieldFontFamily = monsterdRegular;

TextStyle textStyleFieldDropDown = TextStyle(
  color: Colors.black,
  fontSize: pTextLabelFieldFontSize,
  fontFamily: monsterdRegular,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);

TextStyle textStyleTermsAndConditions = TextStyle(
  fontSize: 16.0,
  color: pCommonTextColor,
  fontFamily: monsterdRegular,
);

pFontStyle(context) {
  var screenSize = MediaQuery.of(context).size.width;
  TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w500,
      fontSize: screenSize <= 350 ? 13.0 : 15.0,
      fontFamily: monsterdRegular);
}
// Employee ProfileTextStyle

TextStyle employeeHeaderTextStyle = TextStyle(
  fontSize: 17.0,
  color: Colors.grey.shade400,
  fontFamily: monsterdRegular,
);

TextStyle employeeTextStyle = TextStyle(
    fontSize: 20.0,
    color: Color(0XFF666666),
    fontFamily: monsterdRegular,
    fontWeight: FontWeight.w500);

topPad() {
  return Padding(padding: EdgeInsets.only(top: 15.0));
}

InputDecoration fieldDecorationStyle(label, {String error = 'no'}) {
  return InputDecoration(
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF818181),
      ),
    ),
    contentPadding: EdgeInsets.only(top: 0.0, bottom: 5.0),
    labelText: label,
    labelStyle: new TextStyle(
      color: pCommonTextColor,
      fontSize: pTextLabelFieldFontSize,
    ),
    errorText: error == 'no' ? "" : error,
  );
}

Decoration shadowContainer = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(8),
  boxShadow: [
    BoxShadow(
      color: Color(0XFFE2E2E2),
      blurRadius: 2.0,
      spreadRadius: 1.0,
      offset: Offset(
        0.4,
        1.0,
      ),
    )
  ],
);

TextStyle textStyleField = TextStyle(
    color: Colors.black87,
    fontSize: pTextLabelFieldFontSize,
    fontFamily: monsterdRegular,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5);

//color codes company

const compBackgroundColor = Color(0xFF2F7E9F);
const compButtonBackgroundColor = Color(0xFF104A63);
const compTextLabelColor = Color(0XFF676767);
const compTextLabelColor1 = Color(0xFF3F6272);
const compHeadernBackgroundColor = Color(0xFF104A63);
const compListTileBackgroundColor = Color(0xFF8DDDFF);
const compMedTextColor = Colors.grey;
const compLargeTextColor = Color(0xFF3F6272);

// for settting
//const pTextFieldFontColor = Color(0xFF818181);
const pSettingIconSize = 30.0;
const pSettingFontSize = 18.0;
const pSettingHeaderFontSize = 20.0;

class Review {
  static dynamic reviewRatingData = '';
  static List<dynamic> reviewRatingList = [];
}
