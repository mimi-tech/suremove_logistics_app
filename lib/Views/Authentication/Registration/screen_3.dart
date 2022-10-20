import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Authentication/validation.dart';
import 'package:sure_move/utils/enums.dart';
import 'package:sure_move/utils/generalButton.dart';

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
  String? email;
  String? username;
  String? password;
  String? cPassword;

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
                          username = value!;
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
                  Navigator.pushNamed(context, registrationScreen2);
                },title: kRegister,)

              ],
            ),
          ),
        ));
  }
}
