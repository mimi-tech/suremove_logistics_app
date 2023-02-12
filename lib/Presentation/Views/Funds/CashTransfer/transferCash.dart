import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userEvent.dart';
import 'package:sure_move/Logic/UsersLogic/userState.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';

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
        body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) async {

      if(state is UserDataSuccess){
        ScaffoldMsg().successMsg(context, state.message[0]);
       await AuthBloc().onGettingUserRequested(context);
       Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
      }
      if(state is UserDenied){
        ScaffoldMsg().errorMsg(context, state.errors[0]);
      }


    },
    builder: (context, state) {

    return ModalProgressHUD(
      inAsyncCall: (state is UserLoading)?true:false,
      child: SingleChildScrollView(
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
                           amount = value;
                          },
                        ),


                      ],
                    ),
                  ),
                  spacing(),

                  spacing(),
                  GeneralButton(tapStudiesButton: (){
                    final form = _formKey.currentState;

                    if (form!.validate()) {
                      form.save();

                      BlocProvider.of<UserBloc>(context).add(UserTransferCashRequested(int.parse(amount!), _email.text));
                    }
                  },title: "Transfer",)

                ],
              ),
            ),
          ),
    );
            }));
  }
}
