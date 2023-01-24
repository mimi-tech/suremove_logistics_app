import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalAppbar.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _header = TextEditingController();
  final TextEditingController _message = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? header;
  String? message;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GeneralAppbar(title: kSupport,),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
              children: [
                spacing(),
                SvgPicture.asset('assets/email.svg'),
                spacing(),


                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      spacing(),
                      const Text("Message heading"),
                      TextFormField(
                        controller: _header,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateEmail,
                        decoration: const InputDecoration(
                          hintText: "Heading...",

                        ),
                        onSaved: (String? value) {
                          header = value!;
                        },
                      ),

                      spacing(),
                      const Text("Your message"),
                      TextFormField(
                        controller: _message,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateUsername,
                        decoration: const InputDecoration(
                          hintText: "Message...",

                        ),
                        onSaved: (String? value) {
                          message = value!;
                        },
                      ),

                    ],
                  ),
                ),
                spacing(),

                spacing(),
                GeneralButton(tapStudiesButton: (){
                  Navigator.pushNamed(context, registrationScreen2);
                },title: "Send",)

              ],
            ),
          ),
        ));
  }
}
