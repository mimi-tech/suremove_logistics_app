import 'package:flutter/material.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class ViewBookingDetails extends StatefulWidget {
  const ViewBookingDetails({Key? key}) : super(key: key);

  @override
  State<ViewBookingDetails> createState() => _ViewBookingDetailsState();
}

class _ViewBookingDetailsState extends State<ViewBookingDetails> {
  var result;
  var sender;
  var receiver;
  @override
  Widget build(BuildContext context) {
    result =  BookingCollections.bookingDetails[0].item;
    sender =  BookingCollections.bookingDetails[0].sender;
    receiver =  BookingCollections.bookingDetails[0].receiver;

    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
            backgroundColor: kWhiteColor,
            title: Text(kDeliveryDetails.toUpperCase(),style:TextStyle(color: kOrangeColor),),
            iconTheme: const IconThemeData(color: kBlackColor),
        ),
        bottomNavigationBar: GeneralButton(title: kDone, tapStudiesButton: (){Navigator.pop(context);}),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                spacing(),
                 Header(title: kItemName,subtitle: result["itemName"].toString()),
                spacing(),
                Header(title: kItemNumber,subtitle: result["itemCount"].toString(),),

                spacing(),
                Header(title: kItemSize,subtitle: result["itemSize"].toString(),),

                spacing(),
                Header(title: kSourceLocation,subtitle: BookingCollections.bookingDetails[0].sourceAddress.toString(),),

                spacing(),
                Header(title: kDestinationLocation,subtitle: BookingCollections.bookingDetails[0].destinationAddress.toString(),),

                spacing(),
                Header(title: kSendersName,subtitle: sender["name"],),

                spacing(),
                Header(title: kSendersPhoneNumber,subtitle: sender["phoneNumber"],),

                spacing(),
                Header(title: kReceiverName,subtitle: receiver["name"],),

                spacing(),
                Header(title: kReceiverPhoneNumber,subtitle: receiver["phoneNumber"],),

                spacing(),
                Header(title: kTotal,subtitle: "₦${BookingCollections.bookingDetails[0].amount.toString()}"),



              ],
            ),
    ),
        ));
  }
}


class Header extends StatelessWidget {
   Header({Key? key, required this.title,required this.subtitle}) : super(key: key);
final String title;
final String subtitle;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: "$title: ",
          style: Theme.of(context).textTheme.subtitle1,
          children: <TextSpan>[
            TextSpan(
              text: subtitle,
              style: Theme.of(context).textTheme.bodyText2,
            ),


          ]

      ),
    );
  }
}
