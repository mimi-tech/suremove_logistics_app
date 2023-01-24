import 'package:flutter/material.dart';
class AdminHeader extends StatelessWidget {
  const AdminHeader({Key? key,this.title}) : super(key: key);
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Text(title!,style: Theme.of(context).textTheme.subtitle1!.copyWith(decoration: TextDecoration.underline),);
  }
}