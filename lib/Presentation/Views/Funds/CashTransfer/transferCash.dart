import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

class TransferCash extends StatefulWidget {
  const TransferCash({Key? key}) : super(key: key);

  @override
  State<TransferCash> createState() => _TransferCashState();
}

class _TransferCashState extends State<TransferCash> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? amount;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Transfer cash".toUpperCase()),),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
              children: [

                spacing(),


                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      spacing(),
                      const Text("Enter recipient email"),
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
                      Text(kEnterAmount.toUpperCase(),style: Theme.of(context).textTheme.bodyText2),

                      TextFormField(
                        controller: _amount,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateAmount,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: kEnterAmountHint,

                        ),
                        onSaved: (String? value) {

                        },
                      ),


                    ],
                  ),
                ),
                spacing(),

                spacing(),
                GeneralButton(tapStudiesButton: (){
                  Navigator.pushNamed(context, registrationScreen2);
                },title: "Transfer",)

              ],
            ),
          ),
        ));
  }
}
