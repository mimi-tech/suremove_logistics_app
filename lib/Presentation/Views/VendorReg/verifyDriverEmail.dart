import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';


class VerifyDriverEmailOTP extends StatefulWidget {
  const VerifyDriverEmailOTP({Key? key}) : super(key: key);

  @override
  State<VerifyDriverEmailOTP> createState() => _VerifyDriverEmailOTPState();
}

class _VerifyDriverEmailOTPState extends State<VerifyDriverEmailOTP> {

  @override
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
        if(_pinPutController.text != emailCode){
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

    return Scaffold(
        appBar: AppBar(title: Text(kCreateDriverAccount.toUpperCase()),),

        body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthDenied) {
                ScaffoldMsg().errorMsg(context, state.errors[0]);
              }
              if(state is AuthSuccess){
                Navigator.pushReplacementNamed(context, pickCompany);
                ScaffoldMsg().successMsg(context, "Email verified successfully");
                AuthBloc().onGettingUserRequested(context);
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
                      Text(kVerifyEmail,style: Theme.of(context).textTheme.bodyText1,),
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
