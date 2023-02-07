import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/secrets.dart';
import 'package:sure_move/Providers/userProvider.dart';
class VerifyCustomerTxn extends StatefulWidget {
  const VerifyCustomerTxn({Key? key}) : super(key: key);

  @override
  State<VerifyCustomerTxn> createState() => _VerifyCustomerTxnState();
}

class _VerifyCustomerTxnState extends State<VerifyCustomerTxn> {
  @override
  void initState() {
    PaystackPlugin().initialize(publicKey: testPublicKey);
    print("initialized");
    super.initState();
  }
  @override
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String errorText = "Invalid Transaction";
  bool showError = false;
  final defaultPinTheme = PinTheme(

    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color:kTextColor, fontWeight: FontWeight.w600),

    decoration: BoxDecoration(
      border: Border.all(color: kOrangeColor),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  Widget animatingBorders(NewUser user) {

    return Pinput(

      autofocus: true,
      obscureText: true,
      obscuringCharacter: "*",
      keyboardType:TextInputType.number,
      length: 6,
      focusNode: _pinPutFocusNode,
      controller: _pinPutController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: PinTheme(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: kOrangeColor),
            borderRadius: BorderRadius.circular(8),
          )
      ),

      submittedPinTheme: PinTheme(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: kGreen),
            borderRadius: BorderRadius.circular(8),
          )
      ),
      pinAnimationType: PinAnimationType.slide,
      onCompleted: (String value){
        if(_pinPutController.text != user.txnPin){
          setState(() {
            showError = !showError;
          });
        }

      },
      onChanged: (String value){
        setState(() {
          showError = false;
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var result;
    NewUser user = Provider.of<UserProvider>(context).user;
      UserPreferences().getPaymentType().then((value) => result = value);
    return SingleChildScrollView(child: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          spacing(),
          Text(kTxnDetails,style: Theme.of(context).textTheme.bodyText1,),
          spacing(),
          animatingBorders(user),
          showError?Text(errorText,style: const TextStyle(color: kRedColor),):const Text(""),
          spacing(),

          GeneralButton(title: kVerify, tapStudiesButton: (){


            if(_pinPutController.text == user.txnPin){
                        print(user.email);
                        UserPreferences().getPaymentType().then((value) => result = value);
                        if (result == kCard) {
                        print("yes its card");
                        BlocProvider.of<BookingBloc>(context).add(
                        CustomerTransactionRequested(
                        user.email!,
                        user.firstName!,
                        user.lastName!,
                        user.phoneNumber!,
                        BookingCollections.bookingDetails[0].amount,
                        context,
                        user.userId,
                        "funds",
                        user.email
                        ));
                        Navigator.pushNamedAndRemoveUntil(context, ripplesAnimation, (route) => false);
                        } else {
                          print("No not card");
                        String fullName = "${user.firstName} ${user.lastName}";
                        BlocProvider.of<BookingBloc>(context).add(
                        MatchADriverRequested(
                        fullName,
                        user.phoneNumber,
                        context,
                        user.email!,
                        user.firstName!,
                        user.lastName!,
                        BookingCollections.bookingDetails[0].amount,
                        ));
                          Navigator.pushNamedAndRemoveUntil(context, ripplesAnimation, (route) => false);

                        }
                        }

            }


            ),

          space(),
        ],
      ),
    ));
  }
}
