import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
class ShowProgressIndicator extends StatelessWidget {
  const ShowProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS?const Center(child: CupertinoActivityIndicator(
      animating: true,
      radius: 30,
    ))
        :const Center(child: CircularProgressIndicator(backgroundColor: kLightDoneColor,));

  }
}
