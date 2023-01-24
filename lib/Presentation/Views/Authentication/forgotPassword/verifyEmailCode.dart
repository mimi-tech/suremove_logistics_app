import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
class VerifyEmailCode extends StatefulWidget {
  const VerifyEmailCode({Key? key}) : super(key: key);

  @override
  State<VerifyEmailCode> createState() => _VerifyEmailCodeState();
}

class _VerifyEmailCodeState extends State<VerifyEmailCode> {
  final TextEditingController _otp = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),

        body: SingleChildScrollView(
            child: Container(
                    margin: EdgeInsets.symmetric(horizontal: kMargin),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/email.svg'),

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
                                    keyboardType: TextInputType.number,
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
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            Navigator.pushNamed(context, updatePassword);
                          }
                        },title: "Validate",)
                      ],
                    ),
                  ),
                ));
  }
}
