import 'package:flutter/material.dart';
class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key,required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,style: Theme.of(context).textTheme.headline2,);
  }
}
