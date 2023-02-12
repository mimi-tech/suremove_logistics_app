import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/cardDetailsModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/Views/Funds/Funding/creditCardFilter.dart';
import 'package:sure_move/Presentation/utils/generalAppbar.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class SaveCard extends StatefulWidget {
  const SaveCard({Key? key}) : super(key: key);

  @override
  State<SaveCard> createState() => _SaveCardState();
}

class _SaveCardState extends State<SaveCard> {
  final TextEditingController _exp = TextEditingController();
  final TextEditingController _cvv = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _paymentCard = PaymentCardDetails();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
              children: [
                spacing(),
                const Text("Enter card details"),
                spacing(),
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
                      Row(
                        children: [
                          SizedBox(
                            width:150.w,
                            child: TextFormField(
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
                          ),
                          const SizedBox(width: 10.0,),
                          SizedBox(
                            width:150.w,
                            child: TextFormField(
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
                          ),
                        ],
                      ),
                      spacing(),

                    ],
                  ),
                ),
                spacing(),
                GeneralButton(title: "Save", tapStudiesButton: (){
                final form = _formKey.currentState;

                if (form!.validate()) {
                form.save();
                BlocProvider.of<BookingBloc>(context).add(UserAddCardRequested(
                   _paymentCard.number.toString(),
                    _paymentCard.month.toString(),
                  _paymentCard.year.toString(),
                  _paymentCard.cvv.toString(),
                  _paymentCard.number!.substring(0,4),
                  _paymentCard.number!.substring(12,16),
                  _cardNumber.text
                ));

                 Navigator.pop(context);
                ScaffoldMsg().successMsg(context, "Card saved successfully");
                }}),
                spacing(),
              ],
            ),
          ),
    );
  }
}
