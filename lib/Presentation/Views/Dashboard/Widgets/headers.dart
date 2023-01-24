import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
class AnalysisHeaders extends StatelessWidget {
  const AnalysisHeaders({Key? key,
  this.title1,
  this.title2,
  this.title3,
  }) : super(key: key);
final String? title1;
final String? title2;
final String? title3;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title1??kToday,style: Theme.of(context).textTheme.headline4,),
        Text(title2??"Orders",style: Theme.of(context).textTheme.headline1,),
        Text(title3??"Amount",style: Theme.of(context).textTheme.headline4,),

      ],
    );
  }
}
