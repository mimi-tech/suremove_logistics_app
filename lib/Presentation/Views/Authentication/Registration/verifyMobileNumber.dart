import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class VerifyMobileNumber extends StatefulWidget {
  const VerifyMobileNumber({Key? key}) : super(key: key);

  @override
  State<VerifyMobileNumber> createState() => _VerifyMobileNumberState();
}

class _VerifyMobileNumberState extends State<VerifyMobileNumber> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String errorText = "Invalid code";
  bool showError = false;

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
        if(_pinPutController.text != phoneNumberCode){
          print(emailCode);
          setState(() {
            showError = !showError;
          });
        }

      },
      onChanged: (String value){
        setState(() {
          showError = false;
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),

        body: SingleChildScrollView(
    child: Column(
    children: [
      SvgPicture.asset('assets/mobile.svg'),

      spacing(),
    spacing(),
    Text(kVerifyPhoneNumber,style: Theme.of(context).textTheme.bodyText1,),
    spacing(),
    animatingBorders(),
    showError?Text(errorText,style: const TextStyle(color: kRedColor),):const Text(""),
    spacing(),

          GeneralButton(title: kVerify, tapStudiesButton: (){
            if(_pinPutController.text == phoneNumberCode){
              BlocProvider.of<AuthBloc>(context).add(AuthVerifyEmailCode());
            }}
          )],
    ),
    ));
  }
}
