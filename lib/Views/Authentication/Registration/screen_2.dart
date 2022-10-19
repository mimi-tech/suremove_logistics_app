import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Views/Authentication/validation.dart';
import 'package:sure_move/utils/enums.dart';
import 'package:sure_move/utils/generalButton.dart';

class RegistrationScreen2 extends StatefulWidget {
  const RegistrationScreen2({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen2> createState() => _RegistrationScreen2State();
}

class _RegistrationScreen2State extends State<RegistrationScreen2> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _referral = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? referral;
  Gender _gender = Gender.male;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color:kTextColor, fontWeight: FontWeight.w600),

    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
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
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: kMargin),
              child: Column(
                children: [
                  SvgPicture.asset('assets/unlock.svg'),
                  spacing(),
                  const Text(kReferal,textAlign: TextAlign.center,),
                  spacing(),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        spacing(),
                        animatingBorders(),
                        spacing(),
                        TextFormField(
                          controller: _referral,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: const InputDecoration(
                            hintText: "Referral username",

                          ),
                          onSaved: (String? value) {
                            referral = value!;
                          },
                        ),

                        spacing(),



                      ],
                    ),
                  ),
                  spacing(),

                  spacing(),
                  GeneralButton(tapStudiesButton: (){},title: kNextBtn,)

                ],
              ),
            ),
          ),
        ));
  }
}
