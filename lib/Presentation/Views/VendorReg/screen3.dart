import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:place_picker/place_picker.dart';
import 'package:sure_move/Logic/ProviderViewModel/userNotifier.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/secrets.dart';
class VendorRegScreen3 extends StatefulWidget {
  const VendorRegScreen3({Key? key}) : super(key: key);

  @override
  State<VendorRegScreen3> createState() => _VendorRegScreen3State();
}

class _VendorRegScreen3State extends State<VendorRegScreen3> {
  final TextEditingController _address = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:  Text(kVendorReg.toUpperCase()),),

        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kMargin),
        child: Column(
          children: [
            spacing(),
            SvgPicture.asset('assets/user.svg'),
            Text("Add Photo [Optional]",style: Theme.of(context).textTheme.headline6,),

            spacing(),
            const Text("Please enter your home address"),
            Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: GestureDetector(
              onTap: () async {
                var result = await UserNotifier().onPickLocation(context);
                _address.text = result;
              },
              child: AbsorbPointer(
                child: TextFormField(
                      controller: _address,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateField,
                      decoration: const InputDecoration(
                        hintText: "",

                      ),
                      onSaved: (String? value) {
                        address = value!;
                      },
                    ),
              ),
            ),
        ),

            space(),
            GeneralButton(title: "Register", tapStudiesButton: (){})
          ],
        ),
      ),
    ));
  }
}
