import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Authentication/validation.dart';
import 'package:sure_move/utils/generalButton.dart';
class VerifyMobileNumber extends StatefulWidget {
  const VerifyMobileNumber({Key? key}) : super(key: key);

  @override
  State<VerifyMobileNumber> createState() => _VerifyMobileNumberState();
}

class _VerifyMobileNumberState extends State<VerifyMobileNumber> {
  final TextEditingController _otp = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),

        body: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          SvgPicture.asset('assets/mobile.svg'),

          spacing(),
          const Text(kPinError),
          spacing(),
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    spacing(),

                    TextFormField(
                      controller: _otp,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validatePhoneNumber,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],

                      decoration: const InputDecoration(
                        hintText: "Enter OTP",


                      ),
                      onSaved: (String? value) {
                        otp = value!;
                      },
                    ),

                    spacing(),
                  ])),

          spacing(),
          GeneralButton(tapStudiesButton: (){
            Navigator.pushNamed(context, registrationScreen1);
          },title: "Validate",)
        ],
      ),
    ));
  }
}
