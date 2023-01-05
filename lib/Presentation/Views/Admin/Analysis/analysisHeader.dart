import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
class AnalysisHeader extends StatefulWidget {
  const AnalysisHeader({Key? key,
    this.todayColor,
    this.weeklyColor,
    this.monthlyColor,
    this.yearlyColor,

  }) : super(key: key);
 final Color? todayColor;
 final Color? weeklyColor;
 final Color? monthlyColor;
 final Color? yearlyColor;
  @override
  State<AnalysisHeader> createState() => _AnalysisHeaderState();
}

class _AnalysisHeaderState extends State<AnalysisHeader> {
  double padding = 12.0;
  @override
  Widget build(BuildContext context) {
    return   SliverAppBar(
            backgroundColor: kWhiteColor,
            snap: false,
            pinned: true,
            floating: false,
            expandedHeight: 150.h,
            flexibleSpace: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                  Card(
                    child: Padding(
                      padding:  EdgeInsets.all(padding),
                      child: Text(kToday,style: TextStyle(color: widget.todayColor??kRadioColor),),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding:  EdgeInsets.all(padding),
                      child: Text(kWeekly,style: TextStyle(color: widget.weeklyColor??kRadioColor),),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding:  EdgeInsets.all(padding),
                      child: Text(kMonthly,style: TextStyle(color: widget.monthlyColor??kRadioColor),),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding:  EdgeInsets.all(padding),
                      child: Text(kYearly,style: TextStyle(color: widget.yearlyColor??kRadioColor),),
                    ),
                  ),
                ],),
              spacing(),
                Divider(),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Date".toUpperCase())),
                      ),
                      VerticalDivider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Order".toUpperCase())),
                      ),
                      VerticalDivider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Amount".toUpperCase())),
                      )
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          );



  }
}
