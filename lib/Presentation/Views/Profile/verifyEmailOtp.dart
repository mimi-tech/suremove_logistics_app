import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
import 'package:sure_move/Presentation/utils/generalButton.dart';


class VerifyEmailOTP extends StatefulWidget {
  const VerifyEmailOTP({Key? key}) : super(key: key);

  @override
  State<VerifyEmailOTP> createState() => _VerifyEmailOTPState();
}

class _VerifyEmailOTPState extends State<VerifyEmailOTP> {

  @override
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String errorText = "Invalid Transaction";
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
        if(_pinPutController.text != emailCode){
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

    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),

        body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
      if (state is AuthDenied) {
        ScaffoldMsg().errorMsg(context, state.errors[0]);
      }
      if(state is AuthSuccess){
       Navigator.pushNamedAndRemoveUntil(context, loginPage, (route) => false);
       ScaffoldMsg().successMsg(context, state.message);
      }
    },
    builder: (context, state) {
    return ModalProgressHUD(
    inAsyncCall: (state is AuthLoading)?true:false,
    child: SingleChildScrollView(child: Container(
        margin: EdgeInsets.symmetric(horizontal: kMargin),
        child: Column(
          children: [
            spacing(),
            SvgPicture.asset('assets/email.svg'),
            spacing(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "$kVerifyEmail: ",
                  style: Theme.of(context).textTheme.bodyText1,
                  children: <TextSpan>[
                    TextSpan(
                      text: email.toString(),
                      style: Theme.of(context).textTheme.headline5!.copyWith(color: kDarkRedColor),
                    ),


                  ]

              ),
            ),
            spacing(),
            animatingBorders(),
            showError?Text(errorText,style: const TextStyle(color: kRedColor),):const Text(""),
            spacing(),

            GeneralButton(title: kVerify, tapStudiesButton: (){
             if(_pinPutController.text == emailCode){
              BlocProvider.of<AuthBloc>(context).add(AuthVerifyEmailCode());
            }}


            ),

            space(),
          ],
        ),
      )),
    );}));

}}
