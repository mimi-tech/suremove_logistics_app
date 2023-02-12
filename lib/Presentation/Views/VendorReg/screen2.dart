import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/ProviderViewModel/userNotifier.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/Views/VendorReg/vendorRegCollections.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

class LicenceScreen extends StatefulWidget {
  const LicenceScreen({Key? key}) : super(key: key);

  @override
  State<LicenceScreen> createState() => _LicenceScreenState();
}

class _LicenceScreenState extends State<LicenceScreen> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _licenceNumber = TextEditingController();
  final TextEditingController _issuedDate = TextEditingController();
  final TextEditingController _expiringDate = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? licenceNumber;
  String? issuedDate;
  String? expiringDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:  Text(kVendorReg.toUpperCase()),),
        body: Consumer<UserNotifier>(
        builder: (context, modal, child) {
      return  SingleChildScrollView(
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
                      const Text(kLicenceNumber),
                      TextFormField(
                        controller: _licenceNumber,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateField,
                        decoration: const InputDecoration(
                          hintText: "",

                        ),
                        onSaved: (String? value) {
                          licenceNumber = value!;
                        },
                      ),

                      spacing(),
                      const Text(kIssuedDate),
                      GestureDetector(
                        onTap: () async {
                          var result = await modal.onIssuedDateSelector(context);
                          if(result == true){
                            _issuedDate.text = modal.issuedDate;
                          }
                          },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _issuedDate,
                            autocorrect: true,
                            autofocus: true,
                            cursorColor: (kOrangeColor),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: Validator.validateField,
                            decoration: const InputDecoration(
                              hintText: "",

                            ),
                            onSaved: (String? value) {
                              issuedDate = value!;
                            },
                          ),
                        ),
                      ),

                      spacing(),
                      const Text(kExpiringDate),
                      GestureDetector(
                        onTap: () async {
                          var result = await modal.onExpiringDateSelector(context);
                          if(result == true){
                            _expiringDate.text = modal.expiringDate;
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _expiringDate,
                            autocorrect: true,
                            autofocus: true,
                            cursorColor: (kOrangeColor),
                            keyboardType: TextInputType.text,
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: Validator.validateExpiringDate,
                            decoration: const InputDecoration(
                              hintText: "",

                            ),
                            onSaved: (String? value) {
                              expiringDate = value!;
                            },
                          ),
                        ),
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
                    var license = {
                      "number":licenceNumber,
                      "issuedDate":issuedDate,
                      "expringDate":expiringDate
                    };
                    VendorRegData().driverRegDataJson(lincense: license);

                  }
                  Navigator.pushNamed(context, vendorRegScreen3);

                },title: kNextBtn,)

              ],
            ),
          ),
        );}));
  }
}
