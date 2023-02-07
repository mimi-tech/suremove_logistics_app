import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

class GeneralDialog{
 static String selectedSize = "";
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


  static showBookingRequirementDialog({ required content,required context, required header}){
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
                 ListView.builder(
                  itemCount: content.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text("${index + 1}",

                        style: Theme.of(context).textTheme.caption,),
                      title: Text(content[index].toString(),
                        style: Theme.of(context).textTheme.subtitle1,),
                      onTap: (){selectedSize = content[index];},
                    );
                  }

                 ),
                  spacing(),

                ]
            ));
  }
}


