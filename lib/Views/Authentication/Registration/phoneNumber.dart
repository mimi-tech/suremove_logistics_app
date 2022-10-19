import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Authentication/validation.dart';
import 'package:sure_move/utils/generalButton.dart';
class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phoneNumber;
  String _countryCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),

        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          SvgPicture.asset('assets/mobile.svg'),

          spacing(),
          const Text(kMobileError),
          spacing(),
    Form(
    key: _formKey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: Column(
    crossAxisAlignment:CrossAxisAlignment.start,
    children: [
    spacing(),

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
    },
    ),

    spacing(),
    ])),

          spacing(),
          GeneralButton(tapStudiesButton: (){
            Navigator.pushNamed(context, verifyMobileNumber);
          },title: kVerify,)

        ],
      ),
      ),
    ));
  }
}
