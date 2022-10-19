import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Authentication/validation.dart';
import 'package:sure_move/utils/generalButton.dart';

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

                    ],
                  ),
                ),
                spacing(),

                spacing(),
                GeneralButton(tapStudiesButton: (){
                  Navigator.pushNamed(context, updatePassword);
                },title: kVerify,)

              ],
            ),
          ),
        ));
  }
}
