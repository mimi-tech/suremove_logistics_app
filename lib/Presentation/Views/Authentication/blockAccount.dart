import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class BlockAccount extends StatelessWidget {
  const BlockAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          spacing(),
          Text(kBlockUser.toUpperCase(),style: Theme.of(context).textTheme.caption,),
          spacing(),
          const Text(kBlockUserText,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500),),
          spacing(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              YesOrNo(title: kNo,tapStudiesButton: (){},color: kRadioColor,),
              YesOrNo(title: kYes,tapStudiesButton: (){},),
            ],
          ),
          spacing(),
        ],
      ),
    ));
  }
}
