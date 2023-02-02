import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';

class ScaffoldMsg{
  errorMsg(context, title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title, style: Theme
          .of(context)
          .textTheme
          .caption!
          .copyWith(color: kRedColor),),
      duration: const Duration(seconds: 1),
    ));
  }

  successMsg(context, title){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title,style:  Theme.of(context).textTheme.caption!.copyWith(color: kGreen),),
      duration: const Duration(seconds: 5),

    ));
  }
}