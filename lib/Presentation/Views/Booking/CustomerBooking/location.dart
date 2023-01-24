import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:place_picker/place_picker.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/secrets.dart';

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
    for(var values in BookingCollections.bookingDetails){
      _sourceLocation.text = values.sourceAddress??"";
      BookingConstants().customerSourceAddress = _sourceLocation.text;
    }
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
                      maxLines: null,
                      controller: _sourceLocation,
                      readOnly: true,
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
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () async {
                          LocationResult result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacePicker(googleMapKey)));
                          dynamic address = result.formattedAddress;
                          dynamic address2 = result.name;
                          setState(() {
                            _sourceLocation.text = address + address2;
                            BookingCollections().customerBookingDetailsJson(
                              sourceLatitude: result.latLng!.latitude,
                              sourceLogitude: result.latLng!.longitude,
                              sourceAddress: address + address2,
                              country: result.country!.name,
                              state: result.locality,
                            );
                          });
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "Not this location? ",
                              style: Theme.of(context).textTheme.subtitle2,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Change",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),


                              ]

                          ),
                        ),
                      ),
                    ),

                    spacing(),
                    const Text(kDestinationLocation),
                    GestureDetector(
                      onTap:() async {
                        LocationResult result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacePicker(googleMapKey)));
                        dynamic address = result.formattedAddress;
                        dynamic address2 = result.name;
                        setState(() {
                          _destinationLocation.text = address + address2;
                          BookingCollections().customerBookingDetailsJson(
                            destinationLatitude: result.latLng!.latitude,
                            destinationLogitude: result.latLng!.longitude,
                            destinationAddress: address + address2,
                          );
                        });
                    },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _destinationLocation,
                          autocorrect: true,
                          autofocus: true,
                          maxLines: null,
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
                      ),
                    ),

                  ],
                ),
              ),
              space(),
              GeneralButton(title: kNextBtn, tapStudiesButton: (){
              final form = _formKey.currentState;
              if (form!.validate()) {
              form.save();
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
                Navigator.pushNamed(context, receiversInfo);
              }}

              }
              ),

            ],
          ),
        ));
  }
}
