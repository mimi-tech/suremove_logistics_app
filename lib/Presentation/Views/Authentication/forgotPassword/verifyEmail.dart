import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;

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

                Navigator.pushNamedAndRemoveUntil(context, verifyEmailCode, (route) => false);

              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: (state is AuthLoading)?true:false,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: kMargin),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/email.svg'),
                        spacing(),


                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              spacing(),
                              const Text(kEmail),
                              TextFormField(
                                controller: _email,
                                autocorrect: true,
                                autofocus: true,
                                cursorColor: (kOrangeColor),
                                keyboardType: TextInputType.emailAddress,
                                style: Theme.of(context).textTheme.bodyText1,
                                validator: Validator.validateEmail,
                                decoration: const InputDecoration(
                                  hintText: kEmail2,

                                ),
                                onSaved: (String? value) {
                                  email = value!;
                                },
                              ),

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
                            }

                            BlocProvider.of<AuthBloc>(context).add(AuthSendEmailVerificationCode(_email.text,null));
                          }
                        },title: kVerify,)

                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
