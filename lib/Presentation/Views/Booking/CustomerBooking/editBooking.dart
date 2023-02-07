import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Models/bookingRequirmentsModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/generalDialog.dart';
import 'package:sure_move/Providers/bookingProviders.dart';

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
  final TextEditingController _itemWeight = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? itemName;
  String? itemSize;
  String? itemNumber;
  dynamic size;
  dynamic weight;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    dynamic item =  booking.item;
    _itemName.text = item["name"];
    _itemSize.text = item["size"].toString();
    _itemNumber.text = item["number"].toString();
    _itemWeight.text = item["weight"].toString();
    size = item["size"].toString();
    weight = item["weight"].toString();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    BookingRequirementsModel requirements = Provider.of<BookingProvider>(context).requirements;
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    return Scaffold(
        appBar: AppBar(title: Text("Edit Booking".toUpperCase())),
        body: BlocConsumer<BookingBloc, BookingState>(
    listener: (context, state) {

    if(state is BookingSuccess){
    Navigator.pushNamed(context, connectedVendorPage);
    ScaffoldMsg().successMsg(context, "Booking edited successfully");
    }
    if(state is BookingDenied){
   // Navigator.pushNamed(context, connectedVendorPage);

    ScaffoldMsg().errorMsg(context, state.errors[0]);
    }

    },
    builder: (context, state) {

    return ModalProgressHUD(
      inAsyncCall: (state is BookingLoading)?true:false,
      child: SingleChildScrollView(
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

                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Text(kUpdatingNote,style: TextStyle(color: kRedColor),),
                  space(),

                  GeneralButton(title: "Update booking", tapStudiesButton: (){
                    GeneralDialog.showGeneralDialog(
                        content: kUpdateBookingWaring,
                        context: context,
                        header: "Update booking".toUpperCase(),
                        tapFunction: (){

                          Navigator.pop(context);
                          var item = {
                           "size": size.toString(),
                            "number": _itemNumber.text.trim(),
                           "name": _itemName.text.trim(),
                            "weight":weight,
                          };
                          BlocProvider.of<BookingBloc>(context).add(UpdateBookingRequested(
                            item,
                              _itemNumber.text.trim(),
                              size.toString(),

                            _itemName.text.trim(),
                              weight,
                            false,
                            booking.bookingId,
                            context

                          ));
                        });

                  }),
                ],
              ),
            ),
      ),
    );
        }));
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
                        i + 1 == requirements.sizeRange!.length?const Text(""):   ListTile(
                          leading: const Icon(Icons.ac_unit),
                          title: Text("${requirements.sizeRange![i].toString()}: ${requirements.sizeRange![i + 1].toString()}",
                            style: Theme.of(context).textTheme.subtitle1,),
                          onTap: (){setState(() {
                            _itemSize.text = "${requirements.sizeRange![i].toString()} inches";
                            size = requirements.sizeRange![i];
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
                        i + 1 == requirements.weightRange!.length?const Text(""):   ListTile(
                          leading: const Icon(Icons.ac_unit),
                          title: Text("${requirements.weightRange![i].toString()}: ${requirements.weightRange![i + 1].toString()}",
                            style: Theme.of(context).textTheme.subtitle1,),
                          onTap: (){setState(() {
                            _itemWeight.text = "${requirements.weightRange![i].toString()} Kg";
                            weight = requirements.weightRange![i];
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
