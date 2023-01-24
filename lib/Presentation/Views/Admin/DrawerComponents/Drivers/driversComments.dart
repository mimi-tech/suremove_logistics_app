import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Views/Admin/Widgets/header.dart';
class DriversComment extends StatelessWidget {
  const DriversComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      margin: EdgeInsets.symmetric(horizontal: kMargin2),
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.all(18.0),
          child:  AdminHeader(title: "Ugo Zenith comments"),
        ),
      SizedBox(
        height: 400.h,
        child: ListView.builder(
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Text("${index + 1}",style: Theme.of(context).textTheme.caption,),
          title: Text("How are you",style: Theme.of(context).textTheme.bodyText2,),
        );
    }),
      )
      ],),
    );
  }
}
