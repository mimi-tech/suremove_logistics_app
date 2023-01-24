import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class VerifyUserTxn extends StatefulWidget {
  const VerifyUserTxn({Key? key}) : super(key: key);

  @override
  State<VerifyUserTxn> createState() => _VerifyUserTxnState();
}

class _VerifyUserTxnState extends State<VerifyUserTxn> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color:kTextColor, fontWeight: FontWeight.w600),

    decoration: BoxDecoration(
      border: Border.all(color: kOrangeColor),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  Widget animatingBorders() {

    return Pinput(

      autofocus: true,
      //validator: Variables.validatePin,
      obscureText: true,
      obscuringCharacter: "*",
      keyboardType:TextInputType.number,
      length: 6,
      focusNode: _pinPutFocusNode,
      controller: _pinPutController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: PinTheme(
          decoration: BoxDecoration(
            border: Border.all(color: kOrangeColor),
            borderRadius: BorderRadius.circular(8),
          )
      ),

      submittedPinTheme: PinTheme(
          decoration: BoxDecoration(
            border: Border.all(color: kGreen),
            borderRadius: BorderRadius.circular(8),
          )
      ),
      pinAnimationType: PinAnimationType.slide,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          spacing(),
          Text(kTxnDetails,style: Theme.of(context).textTheme.bodyText1,),
          spacing(),
          animatingBorders(),
          spacing(),

          GeneralButton(title: kVerify, tapStudiesButton: (){
            Navigator.pushNamed(context, transferCash);
          }),

          space(),
        ],
      ),
    ));
  }
}
