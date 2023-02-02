import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Models/bookingModel.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? itemName;
  String? itemSize;
  String? itemNumber;
  @override
  Widget build(BuildContext context) {
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    dynamic item =  booking.item;
    _itemName.text = item["name"];
    _itemSize.text = item["size"].toString();
    _itemNumber.text = item["number"].toString();
    return Scaffold(
        appBar: AppBar(title: Text("Edit Booking".toUpperCase())),
        body: SingleChildScrollView(
          child:  BlocConsumer<BookingBloc, BookingState>(
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

    return Container(
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
                         "size": _itemSize.text.trim(),
                          "number":_itemNumber.text.trim(),
                         "name": _itemName.text.trim(),
                        };
                        BlocProvider.of<BookingBloc>(context).add(UpdateBookingRequested(
                          item,
                          _itemSize.text.trim(),
                         _itemNumber.text.trim(),
                          _itemName.text.trim(),
                          false,
                          booking.bookingId,
                          context

                        ));
                      });

                }),
              ],
            ),
          );
        })
    ));
  }
}
