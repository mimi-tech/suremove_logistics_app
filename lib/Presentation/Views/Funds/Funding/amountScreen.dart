import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/Views/Funds/Funding/fundAccount.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class AmountScreen extends StatefulWidget {
  const AmountScreen({Key? key}) : super(key: key);

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  final TextEditingController _amount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? amount;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kMargin,vertical: kMargin),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/credit_card.svg',color: kBlackColor,),
                SizedBox(width: 10.0.w,),

                Text(kWallet2,style: Theme.of(context).textTheme.bodyText1),

              ],
            ),
            spacing(),
            Text(kEnterAmount.toUpperCase(),style: Theme.of(context).textTheme.subtitle2),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  spacing(),

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
                    amount = value;
                    },
                  ),

                  spacing(),



                ],
              ),
            ),

            FundsGeneralButton(tapStudiesButton: (){
                final form = _formKey.currentState;

                if (form!.validate()) {
                  UserBloc().amount = _amount.text.trim();

                  form.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FundAccount(amount:_amount.text.trim())),
                  );
                }

            },title: kNextBtn,)

          ],
        ),
      ),
    );
  }
}
