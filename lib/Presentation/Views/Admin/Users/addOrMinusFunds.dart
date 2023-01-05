import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

class AddOrMinusFunds extends StatefulWidget {
  const AddOrMinusFunds({Key? key}) : super(key: key);

  @override
  State<AddOrMinusFunds> createState() => _AddOrMinusFundsState();
}

class _AddOrMinusFundsState extends State<AddOrMinusFunds> {
  final TextEditingController _amount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

                    },
                  ),

                  spacing(),



                ],
              ),
            ),

            FundsGeneralButton(tapStudiesButton: (){
              Navigator.pushNamed(context, fundAccount);
            },title: kNextBtn,)

          ],
        ),
      ),
    );
  }
}
