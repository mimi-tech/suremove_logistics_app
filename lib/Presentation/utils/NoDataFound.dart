import 'package:flutter/material.dart';
class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key,required this.title}) : super(key: key);
final String title;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title,style: Theme.of(context).textTheme.bodyText1,));
  }
}
