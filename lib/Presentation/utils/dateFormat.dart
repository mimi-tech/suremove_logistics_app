import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
class DateFormatFunction extends StatelessWidget {
  const DateFormatFunction({Key? key, this.dateString}) : super(key: key);
  final String? dateString;
  @override
  Widget build(BuildContext context) {
    return  Text(DateFormat("EE, d MMM, yyyy h:mm a").format(DateTime.parse(dateString??"2021-10-04 22:25:13.733835"))

      ,style:TextStyle(color: kDarkRedColor) ,);
  }
}

dynamic day  = DateTime.now().day;
dynamic month  = DateTime.now().month;
dynamic year  = DateTime.now().year;
dynamic weekDay  = DateTime.now().weekday;

