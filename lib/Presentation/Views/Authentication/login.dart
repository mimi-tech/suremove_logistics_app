import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/logo.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Container(
          decoration: const BoxDecoration(
              image:  DecorationImage(
                image:  AssetImage('assets/home_bg.png'),
                fit: BoxFit.cover,)),
        margin: EdgeInsets.symmetric(horizontal: kMargin),
        child: Column(
          children: [
            space(),
         const  LogoDesign(),
            space(),
            const Text(kLoginText),

            Form(
            key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        spacing(),

        TextFormField(
          controller: _email,
          autocorrect: true,
          autofocus: true,
          cursorColor: (kOrangeColor),
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyText1,
          validator: Validator.validateEmail,
          decoration: const InputDecoration(
            hintText: kEmail,

          ),
          onSaved: (String? value) {
            email = value!;
          },
        ),

        spacing(),

        TextFormField(
          controller: _password,
          autocorrect: true,
          autofocus: true,
          cursorColor: (kOrangeColor),
          keyboardType: TextInputType.text,
          style: Theme.of(context).textTheme.bodyText1,
          validator: Validator.validatePassword,
          decoration: const InputDecoration(
            hintText: kPassword,

          ),
          onSaved: (String? value) {
            password = value!;
          },
        ),

          ],
        ),
            ),
            spacing(),
            GestureDetector(
              onTap: (){Navigator.pushNamed(context, phoneNumberPage);},
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "$kLoginText2 ",
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                        text: kSignUp,
                        style: Theme.of(context).textTheme.caption,
                      ),


                    ]

                ),
              ),
            ),
            spacing(),
            GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, verifyEmail);
                },
                child: Text(kForgotPassword,style: Theme.of(context).textTheme.subtitle2,)),
            spacing(),
            GeneralButton(tapStudiesButton: (){},title: kLogin,)

          ]
      )
      ),
    ));
  }
}
