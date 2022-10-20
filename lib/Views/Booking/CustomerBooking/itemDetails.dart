import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Authentication/validation.dart';
import 'package:sure_move/utils/generalButton.dart';
class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
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
        appBar: AppBar(title: Text(kItemTitle.toUpperCase())),
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          spacing(),
          Center(child: Text(kItemDetails.toUpperCase(),
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
          GeneralButton(title: kNextBtn, tapStudiesButton: (){
            Navigator.pushNamed(context, itemDeliveryLocation);
          }),
        ],
      ),
    ));
  }
}
