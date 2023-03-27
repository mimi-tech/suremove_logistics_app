import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Models/userModel.dart';
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

class UpdateEmailAddress extends StatefulWidget {
  const UpdateEmailAddress({Key? key}) : super(key: key);

  @override
  State<UpdateEmailAddress> createState() => _UpdateEmailAddressState();
}

class _UpdateEmailAddressState extends State<UpdateEmailAddress> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _oldEmail = TextEditingController();
  final TextEditingController _newEmail = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    _oldEmail.text = user.email.toString();
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthDenied) {
                ScaffoldMsg().errorMsg(context, state.errors[0]);
              }
              if(state is AuthSuccess){
                Navigator.pushReplacementNamed(context, verifyEmailOTP);
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: (state is AuthLoading)?true:false,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: kMargin),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/email.svg'),
                        spacing(),


                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              spacing(),
                              const Text(kEmail3),
                              TextFormField(
                                controller: _oldEmail,
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

                                },
                              ),

                              spacing(),
                              const Text(kEmail4),
                              TextFormField(
                                controller: _newEmail,
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



                            ],
                          ),
                        ),
                        spacing(),

                        spacing(),
                       GeneralButton(tapStudiesButton:(){
                          final form = _formKey.currentState;

                          if (form!.validate()) {
                            form.save();
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            BlocProvider.of<AuthBloc>(context).add(UserSendEmailCodeRequested(_newEmail.text.trim(),));

                          }},title:kVerify,)

                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
