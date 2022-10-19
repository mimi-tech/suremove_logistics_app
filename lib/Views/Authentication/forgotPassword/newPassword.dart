import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Authentication/validation.dart';
import 'package:sure_move/utils/generalButton.dart';

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
        body: SingleChildScrollView(
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
                },title: kUpdate,)

              ],
            ),
          ),
        ));
  }
}
