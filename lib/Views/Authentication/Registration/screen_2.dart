import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
