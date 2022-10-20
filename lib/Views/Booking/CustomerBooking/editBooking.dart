import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Authentication/validation.dart';
import 'package:sure_move/utils/generalButton.dart';

class CustomerEditBooking extends StatefulWidget {
  const CustomerEditBooking({Key? key}) : super(key: key);

  @override
  State<CustomerEditBooking> createState() => _CustomerEditBookingState();
}

class _CustomerEditBookingState extends State<CustomerEditBooking> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemSize = TextEditingController();
  final TextEditingController _itemNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? itemName;
  String? itemSize;
  String? itemNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Edit Booking".toUpperCase())),
        body: Container(
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
                    Text(kItemName),
                    TextFormField(
                      controller: _itemName,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      maxLength: 15,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateItemName,
                      decoration: const InputDecoration(
                        hintText: "Name",

                      ),
                      onSaved: (String? value) {
                        itemName = value!;
                      },
                    ),

                    spacing(),
                    Text(kItemNumber),
                    TextFormField(
                      controller: _itemNumber,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateItemNumber,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        hintText: "Number",

                      ),
                      onSaved: (String? value) {
                        itemNumber = value!;
                      },
                    ),

                    spacing(),
                    Text(kItemSize),
                    TextFormField(
                      controller: _itemSize,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateItemSize,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        hintText: "Size (kg)",

                      ),
                      onSaved: (String? value) {
                        itemSize = value!;
                      },
                    ),

                  ],
                ),
              ),
              space(),
              GeneralButton(title: "Update booking", tapStudiesButton: (){
                Navigator.pushNamed(context, itemDeliveryLocation);
              }),
            ],
          ),
        ));
  }
}
