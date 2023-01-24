import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
final fontFamily = GoogleFonts.oxanium();
final secondaryFontFamily = GoogleFonts.berkshireSwash().toString();

const _fontColor = kTextColor;

final kHeadLine1Style = TextStyle(
  fontSize: kFontSize12,
  fontWeight: FontWeight.bold,
  color: _fontColor,
);

final kHeadLine2Style = TextStyle(
  fontSize: kFontSize12,
  fontWeight: FontWeight.bold,
  color: kDoneColor,
);

final kHeadLine4Style = TextStyle(
  fontSize: kFontSize12,
  fontWeight: FontWeight.bold,
  color: kOrangeColor,
);

final kHeadLine5Style = TextStyle(
  fontSize: kFontSize12,
  fontWeight: FontWeight.bold,
  color: kSeaGreen,
);

/// Also used for [navTitleTextStyle] CupertinoTextThemeData
final kHeadLine6Style = TextStyle(
  fontSize: kFontSize12,
  fontWeight: FontWeight.bold,
  color: kRadioColor,
);

final kBodyText1Style = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.bold,
  color: _fontColor,
);

/// Also used for [textStyle] CupertinoTextThemeData
final kBodyText2Style = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.w500,
  color: _fontColor,
);

/// Also used for [navTitleTextStyle] CupertinoTextThemeData
final kSubTitle1Style = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.bold,
  color: kDoneColor,
);

final kSubTitle2Style = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.w500,
  color: kDoneColor,
);

final kCaptionStyle = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.bold,
  color: kOrangeColor,
);

final kOverLineStyle = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.bold,
  color: kWhiteColor,
);

final kButtonTextStyle = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.bold,
  color: kWhiteColor,

);

final kCardTheme =  CardTheme(
shape: RoundedRectangleBorder(
    side: const BorderSide(color: Colors.transparent, width: 1.0),
borderRadius:  BorderRadius.circular(10.0))
);
