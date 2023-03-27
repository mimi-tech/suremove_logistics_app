import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userState.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';
class VerifyUpdatedMobileNumber extends StatefulWidget {
  const VerifyUpdatedMobileNumber({Key? key,this.verificationCode, this.phoneNumber}) : super(key: key);
 final String? verificationCode;
 final String? phoneNumber;
  @override
  State<VerifyUpdatedMobileNumber> createState() => _VerifyUpdatedMobileNumberState();
}

class _VerifyUpdatedMobileNumberState extends State<VerifyUpdatedMobileNumber> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),

        body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthDenied) {
                ScaffoldMsg().errorMsg(context, state.errors[0]);
              }

              if(state is UpdatePhoneNumberSuccess){
                Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
                ScaffoldMsg().successMsg(context,state.success);
              }

            },
            builder: (context, state) {

              return  ModalProgressHUD(
                inAsyncCall: (state is AuthLoading)?true:false,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/mobile.svg'),

                      spacing(),
                      spacing(),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "$kVerifyPhoneNumber: ",
                            style: Theme.of(context).textTheme.bodyText1,
                            children: <TextSpan>[
                              TextSpan(
                                text:widget.phoneNumber,
                                style: Theme.of(context).textTheme.headline5!.copyWith(color: kDarkRedColor),
                              ),


                            ]

                        ),
                      ),

                      spacing(),
                  Pinput(

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

                        setState(() {
                          showError = !showError;
                        });
                      }else{
                        BlocProvider.of<AuthBloc>(context).add(AuthUpdatePhoneNumberRequested(widget.phoneNumber!));

                      }

                    },
                    onChanged: (String value){
                      setState(() {
                        showError = false;
                      });
                    },
                  ),
                      showError?Text(errorText,style: const TextStyle(color: kRedColor),):const Text(""),
                      spacing(),

                      ],
                  ),
                ));

            }));
  }
}
