import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/Views/Funds/Funding/creditCardFilter.dart';
import 'package:sure_move/Presentation/utils/generalAppbar.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class FundAccount extends StatefulWidget {
  const FundAccount({Key? key}) : super(key: key);

  @override
  State<FundAccount> createState() => _FundAccountState();
}

class _FundAccountState extends State<FundAccount> {
  final TextEditingController _exp = TextEditingController();
  final TextEditingController _cvv = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _paymentCard = PaymentCardDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GeneralAppbar(title: kWallet2,),
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          space(),
        Text("Enter card details"),
        space(),
        Form(
        key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cardNumber,
                autocorrect: true,
                autofocus: true,
                cursorColor: (kOrangeColor),
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.bodyText1,
                validator: CardUtils.validateCardNum,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardNumberInputFormatter()
                ],
                decoration: const InputDecoration(
                  labelText: "Card number",

                ),
                onSaved: (String? value) {
                  _paymentCard.number = CardUtils.getCleanedNumber(value!);
                },
              ),
              spacing(),
              TextFormField(
                controller: _name,
                autocorrect: true,
                autofocus: true,
                cursorColor: (kOrangeColor),
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                validator: CardUtils.validateCardName,
                decoration: const InputDecoration(
                  labelText: "Account holder Name",

                ),
                onSaved: (String? value) {
                },
              ),

              spacing(),
              TextFormField(
                controller: _exp,
                autocorrect: true,
                autofocus: true,
                cursorColor: (kOrangeColor),
                style: Theme.of(context).textTheme.bodyText1,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,

                  LengthLimitingTextInputFormatter(4),
                  CardMonthInputFormatter()
                ],
                validator: CardUtils.validateDate,
                decoration: const InputDecoration(
                  labelText: "Expiring date",

                ),
                onSaved: (String? value) {
                  List<int> expiryDate = CardUtils.getExpiryDate(value!);
                  _paymentCard.month = expiryDate[0];
                  _paymentCard.year = expiryDate[1];
                },
              ),
              spacing(),
              TextFormField(
                controller: _cvv,
                autocorrect: true,
                autofocus: true,
                cursorColor: (kOrangeColor),
                style: Theme.of(context).textTheme.bodyText1,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: CardUtils.validateCVV,
                decoration: const InputDecoration(
                  labelText: "cvv",

                ),
                onSaved: (String? value) {
                  _paymentCard.cvv = int.parse(value!);

                },
              ),
            ],
          ),
        ),
          space(),
          GeneralButton(title: "Fund", tapStudiesButton: (){})
        ],
      ),
    ));
  }
}
