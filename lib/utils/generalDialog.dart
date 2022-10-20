import 'package:flutter/material.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/utils/generalButton.dart';

class GeneralDialog{
  static showGeneralDialog({required content,context,header}){
    showDialog(
        context: context,
        builder: (context) =>

    SimpleDialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
    ),
    elevation: 4,
    title: Text(header.toString().toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.subtitle1,),
    children: <Widget>[
      Text(content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,),
      spacing(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const YesOrNo(title: kNo,color: kRadioColor,),
          YesOrNo(title: kYes, tapStudiesButton: (){},),
        ],
      )
    ]
    ));
  }
}