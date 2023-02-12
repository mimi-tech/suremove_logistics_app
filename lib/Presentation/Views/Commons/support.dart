import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userEvent.dart';
import 'package:sure_move/Logic/UsersLogic/userState.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalAppbar.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';

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
    NewUser user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        appBar: const GeneralAppbar(title: kSupport,),
        body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {

      if(state is UserSuccess){
        Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
        ScaffoldMsg().successMsg(context, "message sent successfully");
      }
      if(state is UserDenied){
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
                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    if(user.isEmailVerified == true){
                    BlocProvider.of<UserBloc>(context).add(WriteToSupportRequested(_header.text, _message.text));
                  }else{
                      Navigator.pushReplacementNamed(context, usersData);
                      ScaffoldMsg().errorMsg(context, "Please verify your account");
                    }
                  }
                  },title: "Send",)

                ],
              ),
            ),
          ),
    );
    })
            );
  }
}
