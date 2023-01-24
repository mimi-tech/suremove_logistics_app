import 'package:flutter/material.dart';
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
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

class RegistrationScreen3 extends StatefulWidget {
  const RegistrationScreen3({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen3> createState() => _RegistrationScreen3State();
}

class _RegistrationScreen3State extends State<RegistrationScreen3> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),
        body: SingleChildScrollView(
          child:BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
    if (state is AuthDenied) {
    ScaffoldMsg().errorMsg(context, state.errors[0]);
    }
    if(state is AuthSuccess){
    Navigator.pushNamed(context, homePage);
    }
    },
    builder: (context, state) {
    return Container(
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
                          RegConstants().email = value!;
                        },
                      ),

                      spacing(),
                      const Text(kUsername),
                      TextFormField(
                        controller: _username,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateUsername,
                        decoration: const InputDecoration(
                          hintText: kUsername2,

                        ),
                        onSaved: (String? value) {
                          RegConstants().username = value!;
                        },
                      ),

                      spacing(),
                      const Text(kPassword),
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
                          RegConstants().password = value!;
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
                          RegConstants().cPassword = value!;
                        },
                      ),

                    ],
                  ),
                ),
                spacing(),

                spacing(),
                (state is AuthLoading)? LoadingButton() : GeneralButton(tapStudiesButton:(){
                  final form = _formKey.currentState;

                  if (form!.validate()) {
                    form.save();
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    BlocProvider.of<AuthBloc>(context).add(AuthRegisterRequested(
                        RegConstants().email!,
                      RegConstants().password!,
                      RegConstants().phoneNumber!,
                      RegConstants().username!,
                      RegConstants().profileImageUrl!,
                      RegConstants().firstname!,
                      RegConstants().lastname!,
                      RegConstants().gender!,
                      RegConstants().referralId!,
                        AccountType.customer,
                      RegConstants().txnPin!,

                    ));

                  }},title:kRegister,)

              ],
            ),
          );
        })));
  }
}
