import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';

class LogoDesign extends StatelessWidget {
  const LogoDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset('assets/logo.svg'),
        SizedBox(width: 10.w,),
        Text(kAppTitle,style: Theme.of(context).textTheme.subtitle1),

      ],
    );
  }
}
