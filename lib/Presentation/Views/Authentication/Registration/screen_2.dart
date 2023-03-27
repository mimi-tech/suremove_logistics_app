import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

class RegistrationScreen2 extends StatefulWidget {
  const RegistrationScreen2({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen2> createState() => _RegistrationScreen2State();
}

class _RegistrationScreen2State extends State<RegistrationScreen2> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _referral = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      onChanged: (String? value){
        txnPin = value!;
      },
      pinAnimationType: PinAnimationType.slide,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
              children: [
                SvgPicture.asset('assets/unlock.svg'),
                spacing(),
                const Text(kTransactionPin,textAlign: TextAlign.center,),

                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [

                      animatingBorders(),
                      spacing(),  spacing(),
                      const Text(kReferal,textAlign: TextAlign.center,),

                      TextFormField(
                        controller: _referral,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: const InputDecoration(
                          hintText: "Referral username [optional]",

                        ),
                        onSaved: (String? value) {
                          referralId = value!;
                        },
                      ),

                      spacing(),



                    ],
                  ),
                ),
                spacing(),

                spacing(),
                GeneralButton(tapStudiesButton: (){
                final form = _formKey.currentState;

                if (form!.validate()) {
                form.save();
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
                }}
                  Navigator.pushNamed(context, registrationScreen3);
                },title: kNextBtn,)

              ],
            ),
          ),
        ));
  }
}
