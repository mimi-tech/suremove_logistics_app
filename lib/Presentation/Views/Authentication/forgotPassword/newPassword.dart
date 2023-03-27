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

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? password;
  String? cPassword;

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
            ScaffoldMsg().successMsg(context, state.message);
          Navigator.pushNamedAndRemoveUntil(context, loginPage, (route) => false);
          }
          },
          builder: (context, state) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: ModalProgressHUD(
              inAsyncCall: (state is AuthLoading)?true:false,
              child: SingleChildScrollView(
                child: Container(
                margin: EdgeInsets.symmetric(horizontal: kMargin),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/unlock.svg'),
                    spacing(),


                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [


                          spacing(),
                          const Text(kPassword2),
                          TextFormField(
                            controller: _password,
                            autocorrect: true,
                            autofocus: true,
                            cursorColor: (kOrangeColor),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            obscuringCharacter: ".",
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: Validator.validateLastName,
                            decoration: const InputDecoration(
                              hintText: "Password",

                            ),
                            onSaved: (String? value) {
                              password = value!;
                            },
                          ),

                          spacing(),
                          const Text(kRePassword),
                          TextFormField(
                            controller: _cPassword,
                            autocorrect: true,
                            autofocus: true,
                            cursorColor: (kOrangeColor),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            obscuringCharacter: ".",
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: Validator.validateLastName,
                            decoration: const InputDecoration(
                              hintText: "Confirm Password",

                            ),
                            onSaved: (String? value) {
                              cPassword = value!;
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
                        if(_password.text == _cPassword.text){
                          BlocProvider.of<AuthBloc>(context).add(AuthUpdatePasswordRequested(_password.text, email!));

                        }else{
                          ScaffoldMsg().errorMsg(context, "Password dose not match");
                        }
                      }
                    },title: kUpdate,)


                  ],
                ),
        ),
              ),
            ),
          );
        }));
  }
}
