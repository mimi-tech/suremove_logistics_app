import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';

class GeneralAppbar extends StatefulWidget implements PreferredSizeWidget{
  const GeneralAppbar({Key? key, required this. title}) : super(key: key);
  final String title;

  @override
  State<GeneralAppbar> createState() => _GeneralAppbarState();
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);

}

class _GeneralAppbarState extends State<GeneralAppbar> {
  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: kWhiteColor,
      elevation: 5.0,
     title: Text(widget.title.toUpperCase(),style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kBlackColor),),
      iconTheme: const IconThemeData(color: kBlackColor),
    );
  }
}
