import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/themes/input_decoration_theme.dart';
import 'package:sure_move/themes/text_styles.dart';


class CustomTheme {
  static ThemeData  lightTheme() { //1
    return ThemeData( //2
        primaryColor: kOrangeColor,
        scaffoldBackgroundColor: Colors.white,

        // buttonTheme: ButtonThemeData( // 4
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   buttonColor: kNavyColor,
        //   height: 40.0.sp,
        // ),

        colorScheme: ThemeData().colorScheme.copyWith(
          primary: kWhiteColor,
          secondary: kOrangeColor,
        ),
        appBarTheme:  AppBarTheme(
          elevation: 0.0,
          backgroundColor: kOrangeColor,
          iconTheme: IconThemeData(color: kWhiteColor,size: 30.0.sp),
        ),
        fontFamily: GoogleFonts.oxanium().fontFamily,

        // textButtonTheme: TextButtonThemeData(
        //   style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(kNavyColor),
        //     textStyle: MaterialStateProperty.all(
        //       TextStyle(
        //         color: kWhiteColor,
        //         fontSize: 14.0.sp,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //   ),
        // ),
        inputDecorationTheme: kInputDecorationTheme(),
         textTheme:  TextTheme(
           headline1: kHeadLine1Style,
           headline2: kHeadLine2Style,
           headline4: kHeadLine4Style,
           headline5: kHeadLine5Style,
           headline6: kHeadLine6Style,
           bodyText1: kBodyText1Style,
           bodyText2: kBodyText2Style,
           subtitle1: kSubTitle1Style,
           subtitle2: kSubTitle2Style,
           caption: kCaptionStyle,
           overline: kOverLineStyle,
           button: kButtonTextStyle,
         ),
        cardTheme: kCardTheme,
        dividerColor: kRadioColor,
        hintColor: kHintColor,
        errorColor: kRedColor,
        // dialogBackgroundColor: Colors.blue,

        iconTheme: IconThemeData(size: 30.0.sp),
        listTileTheme:const ListTileThemeData(textColor: kBlackColor,selectedColor: kOrangeColor)
    );
  }
}