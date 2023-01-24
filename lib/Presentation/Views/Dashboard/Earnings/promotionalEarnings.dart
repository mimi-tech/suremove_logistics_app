import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/dateFormat.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
class PromotionalEarning extends StatelessWidget {
  const PromotionalEarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(kReferrialEarnings),),
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin2),
      child: Column(children: [
        spacing(),
      Row(children: [
      const ProfilePicture(image: ""),
          SizedBox(width: 10.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ugo Zenith",style: Theme.of(context).textTheme.headline1,),
              const DateFormatFunction()
            ],)
          ],),
        Divider()
      ],),
    ));
  }
}
