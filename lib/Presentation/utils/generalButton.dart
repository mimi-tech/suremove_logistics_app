import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({Key? key,
    required this.title,
    required this.tapStudiesButton,
     this.color,
    this.textColor,

  }) : super(key: key);
  final String title;
  final VoidCallback tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        onPressed: tapStudiesButton,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
               EdgeInsets.symmetric(horizontal: 50.0.sp,vertical: 20.0.sp),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(color??kOrangeColor)),
        child:Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button),
        );
  }}


class YesOrNo extends StatelessWidget {
  const YesOrNo({Key? key,
    required this.title,
     this.tapStudiesButton,
    this.color,
    this.textColor,

  }) : super(key: key);
  final String title;
  final VoidCallback? tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: tapStudiesButton??(){Navigator.pop(context);},
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0))),

          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 20.0.sp,),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color??kOrangeColor)),
      child:Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button),
    );
  }}


class FundsGeneralButton extends StatelessWidget {
  const FundsGeneralButton({Key? key,
    required this.title,
    required this.tapStudiesButton,
    this.color,
    this.textColor,

  }) : super(key: key);
  final String title;
  final VoidCallback tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: tapStudiesButton,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),

          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 20.0.sp,vertical: 10.0.sp),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color??kOrangeColor)),
      child:Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button!.copyWith(color: textColor??kWhiteColor,fontSize: kFontSize13)),
    );
  }}


class LoadingButton extends StatelessWidget {
   LoadingButton({Key? key,this.color,
  }) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: null,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 50.0.sp,vertical: 20.0.sp),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color??kOrangeColor)),
      child:const CircularProgressIndicator()
    );
  }}