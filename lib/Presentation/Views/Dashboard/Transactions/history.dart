import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/headers.dart';
class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          automaticallyImplyLeading: false,
          title: AnalysisHeaders(title2: "Details",title1: "Date",),),
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin2),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("3/34/4342",style: Theme.of(context).textTheme.headline6,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order",style: Theme.of(context).textTheme.headline6,),
              Text("4:54pm",style: Theme.of(context).textTheme.headline1,)

            ],
          ),
            Text("NGN 43434",style: Theme.of(context).textTheme.headline5,)

          ],
        )
      ],),
    ));
  }
}
