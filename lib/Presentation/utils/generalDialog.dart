import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

class GeneralDialog{
  static showGeneralDialog({ required content,required context, required header,required tapFunction}){
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
           YesOrNo(title: kNo,color: kRadioColor,tapStudiesButton: ()=>Navigator.pop(context),),
          YesOrNo(title: kYes, tapStudiesButton: tapFunction,),
        ],
      )
    ]
    ));
  }
}


