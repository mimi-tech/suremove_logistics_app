import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class LegalBookingConfirmation extends StatelessWidget {
  const LegalBookingConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            spacing(),
             Text("Is this item a legal item?",style: Theme.of(context).textTheme.bodyText1),
            spacing(),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Note: ",
              style: Theme.of(context).textTheme.headline6,
              children: <TextSpan>[
                TextSpan(
                  text: "Selecting Yes while this item is not legal calls for a penalty",
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
                ),


              ]

          ),),
           spacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                YesOrNo(title: kNo,tapStudiesButton: (){},color: kRadioColor ,),
                YesOrNo(title: kYes,tapStudiesButton: (){} ,),
              ],
            )

          ],
        ),
      ),
    );
  }
}
