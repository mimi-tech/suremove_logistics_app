import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Authentication/validation.dart';
import 'package:sure_move/utils/generalButton.dart';

class ItemDeliveryLocation extends StatefulWidget {
  const ItemDeliveryLocation({Key? key}) : super(key: key);

  @override
  State<ItemDeliveryLocation> createState() => _ItemDeliveryLocationState();
}

class _ItemDeliveryLocationState extends State<ItemDeliveryLocation> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _sourceLocation = TextEditingController();
  final TextEditingController _destinationLocation = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? sourceLocation;
  String? destinationLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(kItemDeliveryLocation.toUpperCase())),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: kMargin),
          child: Column(
            children: [
              spacing(),
              Center(child: Text(kLocation.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,)),
              spacing(),

              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    spacing(),
                    const Text(kSourceLocation),
                    TextFormField(
                      controller: _sourceLocation,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateField,
                      decoration: const InputDecoration(
                        hintText: "Picking point Address",

                      ),
                      onSaved: (String? value) {
                        sourceLocation = value!;
                      },
                    ),

                    spacing(),
                    const Text(kDestinationLocation),
                    TextFormField(
                      controller: _destinationLocation,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateField,

                      decoration: const InputDecoration(
                        hintText: "Destination address",

                      ),
                      onSaved: (String? value) {
                        destinationLocation = value!;
                      },
                    ),

                  ],
                ),
              ),
              space(),
              GeneralButton(title: kNextBtn, tapStudiesButton: (){
                Navigator.pushNamed(context, receiversInfo);
              }),
            ],
          ),
        ));
  }
}
