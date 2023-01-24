import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/themes/input_decoration_theme.dart';
import 'package:sure_move/Presentation/themes/text_styles.dart';



class CustomTheme {
  static ThemeData  lightTheme() { //1
    return ThemeData( //2
        primaryColor: kOrangeColor,
        scaffoldBackgroundColor: Colors.white,

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: kDarkBlue,// 4
          elevation: 5.0,
          selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
          selectedItemColor: kYellow,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedIconTheme: IconThemeData(
            color: kWhiteColor
          ),
          unselectedItemColor: kWhiteColor,
        ),

        colorScheme: ThemeData().colorScheme.copyWith(
          primary: kWhiteColor,
          secondary: kOrangeColor,
        ),
        appBarTheme:  AppBarTheme(
          elevation: 0.0,
          backgroundColor: kOrangeColor,
          iconTheme: IconThemeData(color: kWhiteColor,size: 30.0.sp),
           titleTextStyle: TextStyle(fontWeight: FontWeight.bold,
           fontSize: kFontSize16
           )
        ),
        fontFamily: GoogleFonts.oxanium().fontFamily,

       tabBarTheme: TabBarTheme(
            indicatorSize: TabBarIndicatorSize.tab,
              indicator: const BoxDecoration(color: kLightDoneColor),
             labelColor: kWhiteColor,
             unselectedLabelColor: kCartoonColor,
             labelStyle:  TextStyle(fontWeight: FontWeight.bold,fontSize: kFontSize14),
             unselectedLabelStyle:  TextStyle(fontWeight: FontWeight.w500,fontSize: kFontSize14),
         overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
           if (states.contains(MaterialState.pressed)) {
             return kWhiteColor;
           } if (states.contains(MaterialState.focused)) {
             return Colors.orange;
           } else if (states.contains(MaterialState.hovered)) {
             return Colors.pinkAccent;
           }

           return Colors.transparent;
         }),

       ),


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

        iconTheme: IconThemeData(size: 25.0.sp),
        listTileTheme:const ListTileThemeData(textColor: kBlackColor,selectedColor: kOrangeColor),
          popupMenuTheme: PopupMenuThemeData(textStyle: TextStyle(color: kBlackColor,fontSize: kFontSize13,fontWeight: FontWeight.bold))
    );
  }
}