import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class VerifyMobileNumber extends StatefulWidget {
  const VerifyMobileNumber({Key? key}) : super(key: key);

  @override
  State<VerifyMobileNumber> createState() => _VerifyMobileNumberState();
}

class _VerifyMobileNumberState extends State<VerifyMobileNumber> {
  final TextEditingController _otp = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? otp;
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),

        body: SingleChildScrollView(
          child:BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
    if (state is AuthDenied) {
    ScaffoldMsg().errorMsg(context, state.errors[0]);
    }
    if(state is AuthSuccess){
    Navigator.pushNamed(context, registrationScreen1);
    }
    },
    builder: (context, state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
          children: [
            SvgPicture.asset('assets/mobile.svg'),

            spacing(),
            const Text(kPinError),
            spacing(),
            Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      spacing(),

                      TextFormField(
                        controller: _otp,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validatePhoneNumber,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],

                        decoration: const InputDecoration(
                          hintText: "Enter OTP",


                        ),
                        onSaved: (String? value) {
                          otp = value!;
                        },
                      ),

                      spacing(),
                    ])),

            spacing(),
            (state is AuthLoading)?LoadingButton():GeneralButton(tapStudiesButton: (){
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      BlocProvider.of<AuthBloc>(context).add(VerifyOtpRequested(arg["verificationCode"],_otp.text));
    }
            },title: "Validate",)
          ],
      ),
    );
        })));
  }
}
