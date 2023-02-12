import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';
class VerifyUserTxn extends StatefulWidget {
  const VerifyUserTxn({Key? key}) : super(key: key);

  @override
  State<VerifyUserTxn> createState() => _VerifyUserTxnState();
}

class _VerifyUserTxnState extends State<VerifyUserTxn> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String errorText = "";
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color:kTextColor, fontWeight: FontWeight.w600),

    decoration: BoxDecoration(
      border: Border.all(color: kOrangeColor),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  Widget animatingBorders(NewUser user) {

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
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: kOrangeColor),
            borderRadius: BorderRadius.circular(8),
          )
      ),

      submittedPinTheme: PinTheme(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: kGreen),
            borderRadius: BorderRadius.circular(8),
          )
      ),
      pinAnimationType: PinAnimationType.slide,
      onCompleted: (String value){
        if(_pinPutController.text != user.txnPin){
          setState(() {errorText = kTxnError;});
        }
      },
      onChanged: (String value){
        setState(() {errorText = "";});
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;

    return SingleChildScrollView(child: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          spacing(),
          Text(kTxnDetails,style: Theme.of(context).textTheme.bodyText1,),
          spacing(),
          animatingBorders(user),
          Text(errorText,style: TextStyle(color: kRedColor),),
          spacing(),

          GeneralButton(title: kVerify, tapStudiesButton: (){
           if(_pinPutController.text == user.txnPin){
             Navigator.pushNamed(context, transferCash);
           }

          }),

          space(),
        ],
      ),
    ));
  }
}
