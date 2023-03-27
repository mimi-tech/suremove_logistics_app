import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:sure_move/Presentation/Views/Profile/confirmMobileNumber.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';
class UpdatePhoneNumber extends StatefulWidget {
  const UpdatePhoneNumber({Key? key}) : super(key: key);

  @override
  State<UpdatePhoneNumber> createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phoneNumber;
  String _countryCode = '';

  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
 String oldPhoneNumber = user.phoneNumber.toString();
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthDenied) {
                ScaffoldMsg().errorMsg(context, state.errors[0]);
              }

              if(state is AuthSuccess){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerifyUpdatedMobileNumber(verificationCode:phoneNumberCode, phoneNumber:_countryCode + _phoneNumber.text)),
                );
              }

            },
            builder: (context, state) {
              return  ModalProgressHUD(
                inAsyncCall: (state is AuthLoading)?true:false,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: kMargin),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/mobile.svg'),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "$kMobile2 ",
                              style: Theme.of(context).textTheme.bodyText1,
                              children: <TextSpan>[
                                TextSpan(
                                  text: oldPhoneNumber.toString(),
                                  style: Theme.of(context).textTheme.headline5!.copyWith(color: kDarkRedColor),
                                ),


                              ]

                          ),
                        ),
                        spacing(),
                        const Text(kMobile),

                        Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [


                                  TextFormField(
                                    controller: _phoneNumber,
                                    autocorrect: true,
                                    autofocus: true,
                                    cursorColor: (kOrangeColor),
                                    keyboardType: TextInputType.phone,
                                    style: Theme.of(context).textTheme.bodyText1,
                                    validator: Validator.validatePhoneNumber,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],

                                    decoration:  InputDecoration(
                                      hintText: kMobileHint,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CountryCodePicker(
                                          textStyle:  GoogleFonts.oxanium(
                                            fontWeight: FontWeight.bold,

                                            color: kTextColor,
                                          ),
                                          onInit: (code) {
                                            _countryCode = code.toString();
                                          },
                                          onChanged: (code){
                                            _countryCode = code.toString();
                                          },
                                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                          initialSelection: 'NG',
                                          favorite: ['+234','NG'],
                                          // optional. Shows only country name and flag
                                          showCountryOnly: false,
                                          // optional. Shows only country name and flag when popup is closed.
                                          showOnlyCountryWhenClosed: false,
                                          // optional. aligns the flag and the Text left
                                          alignLeft: false,
                                        ),
                                      ),

                                    ),
                                    onSaved: (String? value) {
                                      phoneNumber = value!;
                                      phoneNumber = _countryCode + phoneNumber!;
                                    },
                                  ),

                                  spacing(),
                                ])),

                        spacing(),
                         GeneralButton(tapStudiesButton: (){

                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            BlocProvider.of<AuthBloc>(context).add(AuthSendPhoneNumberCodeRequested(_countryCode + _phoneNumber.text));
                          }},title: kVerify,)

                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
