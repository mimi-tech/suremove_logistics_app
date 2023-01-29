import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/DriverLogic/driverBloc.dart';
import 'package:sure_move/Logic/DriverLogic/driverEvent.dart';
import 'package:sure_move/Logic/DriverLogic/driverState.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
class LegalBookingConfirmation extends StatelessWidget {
  const LegalBookingConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    dynamic item = booking.item;
    return SingleChildScrollView(
      child:  BlocConsumer<DriversBloc, DriverState>(
        listener: (context, state) {

      if(state is DriverIsLegal){
      Navigator.pop(context);
      }
      if(state is DriverDenied){
        ScaffoldMsg().errorMsg(context, state.errors[0]);
      }

    },
    builder: (context, state) {

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            spacing(),
             Text("Is this item a legal item?",style: Theme.of(context).textTheme.bodyText1),
            spacing(),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Note: ",
              style: Theme.of(context).textTheme.headline6,
              children: <TextSpan>[
                TextSpan(
                  text: "Selecting Yes while this item is not legal calls for a penalty",
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
                ),


              ]

          ),),
           spacing(),
            (state is IsBookingLegalLoading)?const CircularProgressIndicator(): Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                YesOrNo(title: kNo,tapStudiesButton: (){
                  BlocProvider.of<DriversBloc>(context).add(DriverUpdateBookingRequested(
                      item["number"],
                      item["size"],
                      item["name"],
                      false,
                      booking.bookingId,
                      booking.totalAmount,
                      booking.amount
                  ));
                },color: kRadioColor ,),
                YesOrNo(title: kYes,tapStudiesButton: (){
                  BlocProvider.of<DriversBloc>(context).add(DriverUpdateBookingRequested(
                      item["number"],
                      item["size"],
                      item["name"],
                      true,
                      booking.bookingId,
                      booking.totalAmount,
                      booking.amount
                  ));

                } ,),
              ],
            )

          ],
        ),
      );
    }));
  }
}
