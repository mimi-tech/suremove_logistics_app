import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/userModel.dart';
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
import 'package:sure_move/Providers/userProvider.dart';
class FundAccount extends StatefulWidget {
  const FundAccount({Key? key, this.amount}) : super(key: key);
final dynamic amount;
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
  dynamic cardNumbers;
  dynamic cardCvv;
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
     UserPreferences().getCardDetailsNew().then((value) =>{
       _cardNumber.text = value.formattedCardNumber.toString(),
       _exp.text = "${value.expiringMonth}/${value.expiringYear}",
       _cvv.text = value.cvv.toString(),
       cardNumbers = value.cardNumber,
       cardCvv  = value.cvv
     });

    return Scaffold(
        appBar: const GeneralAppbar(title: kWallet2,),
        body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {

      if(state is PaymentSuccessful){
       Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
       ScaffoldMsg().successMsg(context, "Successful transaction");
      }
      if(state is BookingDenied){

        ScaffoldMsg().errorMsg(context, state.errors[0]);

      }

    },
    builder: (context, state) {

    return ModalProgressHUD(
      inAsyncCall: (state is BookingLoading)?true:false,
      child: SingleChildScrollView(
        child: Container(
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
                  // TextFormField(
                  //   controller: _name,
                  //   autocorrect: true,
                  //   autofocus: true,
                  //   cursorColor: (kOrangeColor),
                  //   style: Theme.of(context).textTheme.bodyText1,
                  //   keyboardType: TextInputType.text,
                  //   textInputAction: TextInputAction.next,
                  //   textCapitalization: TextCapitalization.sentences,
                  //   validator: CardUtils.validateCardName,
                  //   decoration: const InputDecoration(
                  //     labelText: "Account holder Name",
                  //
                  //   ),
                  //   onSaved: (String? value) {
                  //   },
                  // ),
                  //
                  // spacing(),
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
              GeneralButton(title: "Fund ${widget.amount}.00", tapStudiesButton: () async {
                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    if(cardNumbers == _paymentCard.number && cardCvv == _cvv.text){

                      BlocProvider.of<BookingBloc>(context).add(CustomerTransactionRequested(user.email!,user.firstName!,user.lastName!, user.phoneNumber!,widget.amount, context, user.userId, "fund", user.email!));

                    }else{

                      BlocProvider.of<BookingBloc>(context).add(UserAddCardRequested(
                        _paymentCard.number.toString(),
                        _paymentCard.month.toString(),
                        _paymentCard.year.toString(),
                        _paymentCard.cvv.toString(),
                        _paymentCard.number!.substring(0,4),
                        _paymentCard.number!.substring(12,16),
                        _cardNumber.text
                      ));

                      BlocProvider.of<BookingBloc>(context).add(CustomerTransactionRequested(user.email!,user.firstName!,user.lastName!, user.phoneNumber!,widget.amount, context, user.userId, "fund", user.email!));
                    }

                  }
              })
            ],
          ),
        ),
      ),
    );
    }));
  }
}
