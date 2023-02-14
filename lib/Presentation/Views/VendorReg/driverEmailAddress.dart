import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Logic/ProviderViewModel/userNotifier.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/Views/Profile/verifyEmailOtp.dart';
import 'package:sure_move/Presentation/Views/VendorReg/vendorRegCollections.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';

class DriverEmailAddress extends StatefulWidget {
  const DriverEmailAddress({Key? key}) : super(key: key);

  @override
  State<DriverEmailAddress> createState() => _DriverEmailAddressState();
}

class _DriverEmailAddressState extends State<DriverEmailAddress> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _newEmail = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kCreateDriverAccount.toUpperCase()),),
        body:  BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
      if (state is AuthDenied) {
        ScaffoldMsg().errorMsg(context, state.errors[0]);
      }
      if (state is AuthDoNotCreateDriversAccount) {
        ScaffoldMsg().errorMsg(context, "This account cannot be used to create drivers account");
      }
      if(state is AuthCreateDriversAccount) {
        VendorRegData().driverRegDataJson(profileImageUrl: state.success!.profileImageUrl);

        Navigator.pushReplacementNamed(context, verifyDriverEmailOTP);

      }
    },
    builder: (context, state) {
    return SingleChildScrollView(
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
                                  RegConstants().email = value!;
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
                            VendorRegData().driverRegDataJson(driverEmail: _newEmail.text.trim());
                            BlocProvider.of<AuthBloc>(context).add(AuthSendEmailVerificationCode(_newEmail.text.trim(),null,));

                          }},title:kVerify,)

                      ],
                    ),
                  ),
                );
              }));

  }
}
