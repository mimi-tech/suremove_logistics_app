import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Views/Booking/VendorBooking/legalBookingConfirmation.dart';
import 'package:sure_move/Presentation/Views/Booking/VendorBooking/routingMap.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/naira.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    dynamic sender = booking.sender;
    dynamic receivers = booking.receiver;
    dynamic item = booking.item;
    return Scaffold(
        backgroundColor: kBlackColor,
        body: SingleChildScrollView(
          child: Column(
      children: [
          const RoutingMap(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: (){AuthBloc().launchTel(sender["phoneNumber"]);},
                  child: SvgPicture.asset('assets/call.svg')),
              SvgPicture.asset('assets/direction.svg'),
            ],
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView(
              children: [
                 Header(title: kSendersName,subtitle: sender["name"].toString(),),
                 Header(title: kSendersPhoneNumber,subtitle: sender["phoneNumber"].toString(),),
                 Header(title: kReceiverName,subtitle: receivers["name"].toString(),),
                 Header(title: kReceiverPhoneNumber,subtitle: receivers["phoneNumber"].toString(),),
                 Header(title: kSourceLocation,subtitle: booking.sourceAddress.toString(),),
                 Header(title: kDestinationLocation,subtitle: booking.destinationAddress.toString(),),
                 Header(title: kItemSize,subtitle: item["size"].toString(),),
                 Header(title: kItemNumber,subtitle: item["number"].toString(),),
                 Header(title: kItemName,subtitle: item["name"].toString(),),

                spacing(),
                const Divider(color: kWhiteColor,thickness: 1.5,),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Payment type", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kCartoonColor)),
                Text(booking.methodOfPayment.toString(), style: Theme.of(context).textTheme.caption),

              ],
            ),

          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(kDeliveryFee, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kCartoonColor)),
                  Text("$nairaSign${booking.amount}", style: Theme.of(context).textTheme.caption),

                ],
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(kTotal, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kCartoonColor)),
                  Text("$nairaSign${booking.totalAmount}", style: Theme.of(context).textTheme.headline5),

                ],
              )),
          const Divider(color: kWhiteColor,thickness: 1.5,),
          spacing(),

        GeneralButton(tapStudiesButton: (){
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              isDismissible: false,
              builder: (context) => const LegalBookingConfirmation()
          );
        },title: "Package delivered".toUpperCase(),),
        spacing(),
      ],
    ),
        ));
  }
}

class Header extends StatelessWidget {
  const Header({Key? key,required this.title,required this.subtitle}) : super(key: key);
 final String title;
 final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spacing(),
        Text(title, style: Theme.of(context).textTheme.headline2,),
        Text(subtitle, style: Theme.of(context).textTheme.headline6,)
      ],
    );
  }
}

