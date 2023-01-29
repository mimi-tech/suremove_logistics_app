import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/DriverLogic/driverBloc.dart';
import 'package:sure_move/Logic/DriverLogic/driverEvent.dart';
import 'package:sure_move/Logic/DriverLogic/driverState.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        isDismissible: false,
        builder: (context) => const LegalBookingConfirmation()
    );
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    BlocProvider.of<DriversBloc>(context).add(DriverGetABookingRequested(booking.customerAuthId.toString(),context));

  }
  @override
  Widget build(BuildContext context) {
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    dynamic sender = booking.sender;
    dynamic receivers = booking.receiver;
    dynamic item = booking.item;
    return Scaffold(
        backgroundColor: kBlackColor,
        body: BlocConsumer<DriversBloc, DriverState>(
        listener: (context, state) {

      if(state is DriverSuccess){
       Navigator.pushNamedAndRemoveUntil(context, vendorWaitingScreen, (route) => false);
       ScaffoldMsg().successMsg(context, "Successful",);
      }
      if(state is DriverDenied){
        ScaffoldMsg().errorMsg(context, state.errors[0]);
      }

    },
    builder: (context, state) {

    return ModalProgressHUD(
      inAsyncCall: (state is DriverLoading)?true:false,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: SingleChildScrollView(
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

            (state is DeliveryConfirmed)? GeneralButton(tapStudiesButton: (){
             dynamic company = booking.companyDetails;
             BlocProvider.of<DriversBloc>(context).add(DriverConfirmBookingRequested(
                 booking.driverId.toString(),
                 company["id"]
             ));
            },title: "Package delivered".toUpperCase(),):const Text(""),
            spacing(),
          ],
        ),
            ),
      ),
    );
        }));
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

