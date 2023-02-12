import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Models/bookingRequirmentsModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
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
  final TextEditingController _itemWeight = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? itemName;
  String? itemSize;
  String? itemNumber;
  String? itemWeight;

  @override

  @override
  Widget build(BuildContext context) {
    BookingRequirementsModel requirements = Provider.of<BookingProvider>(context).requirements;

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
                  const Text(kItemName),
                TextFormField(
                  controller: _itemName,
                  autocorrect: true,
                  autofocus: true,
                  cursorColor: (kOrangeColor),
                  maxLength: 50,
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
                const Text(kItemNumber),
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
                const Text(kItemSize),
                GestureDetector(
                  onTap: (){showSizeDialog(requirements);},
                  child: AbsorbPointer(
                    child: TextFormField(
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
                        hintText: "Size (inches)",

                      ),
                      onSaved: (String? value) {
                        itemSize = value!;
                      },
                    ),
                  ),
                ),
                spacing(),
                const Text(kItemWeight),
                GestureDetector(
                  onTap: (){showWeightDialog(requirements);},
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _itemWeight,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateItemWeight,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],

                      decoration: const InputDecoration(
                        hintText: "Weight (kg)",
                      ),
                      onSaved: (String? value) {
                        itemSize = value!;
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          space(),
          GeneralButton(title: kNextBtn, tapStudiesButton: () {
    final form = _formKey.currentState;

    if (form!.validate()) {
    form.save();
    
    var items = {
      "itemName":_itemName.text,
      "itemCount":_itemNumber.text,
      "itemSize":_itemSize.text,
      "weight":_itemWeight.text
    };
    BookingCollections().customerBookingDetailsJson(item: items);

    Navigator.pushNamed(context, itemDeliveryLocation);

    }



          }),
        ],
      ),
    ));
  }

  void showSizeDialog(BookingRequirementsModel requirements) {

    showDialog(
        context: context,
        builder: (context) =>

            SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                title: Text(kItemSize2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,),
                children: <Widget>[
                 Column(
                      children: [
                        for(int i = 0; i < requirements.sizeRange!.length; i++)
                          i + 1 == requirements.sizeRange!.length?Text(""):   ListTile(
                leading: Icon(Icons.ac_unit),
                title: Text("${requirements.sizeRange![i].toString()}: ${requirements.sizeRange![i + 1].toString()}",
                style: Theme.of(context).textTheme.subtitle1,),
                onTap: (){setState(() {
                  _itemSize.text = "${requirements.sizeRange![i].toString()}";
                  Navigator.pop(context);
                });},
                ),
                        YesOrNo(title: kCancel,tapStudiesButton: (){Navigator.pop(context);},)
                      ],
                    )

                ]

            ));
  }
  void showWeightDialog(BookingRequirementsModel requirements) {

    showDialog(
        context: context,
        builder: (context) =>

            SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                title: Text(kItemWeight2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,),
                children: <Widget>[
                  Column(
                    children: [
                      for(int i = 0; i < requirements.weightRange!.length; i++)
                        i + 1 == requirements.weightRange!.length?Text(""):   ListTile(
                          leading: Icon(Icons.ac_unit),
                          title: Text("${requirements.weightRange![i].toString()}: ${requirements.weightRange![i + 1].toString()}",
                            style: Theme.of(context).textTheme.subtitle1,),
                          onTap: (){setState(() {
                            _itemWeight.text = "${requirements.weightRange![i].toString()}";
                            Navigator.pop(context);
                          });},
                        ),
                      YesOrNo(title: kCancel,tapStudiesButton: (){Navigator.pop(context);},)
                    ],
                  )

                ]

            ));
  }
}
