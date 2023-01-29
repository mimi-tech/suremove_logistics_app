import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
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
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/Widgets/reasonToCancelBooking.dart';
import 'package:sure_move/Presentation/Views/Booking/VendorBooking/routingMap.dart';
import 'package:sure_move/Presentation/utils/generalDialog.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
class ConnectedVendorPage extends StatefulWidget {
  const ConnectedVendorPage({Key? key}) : super(key: key);

  @override
  State<ConnectedVendorPage> createState() => _ConnectedVendorPageState();
}

class _ConnectedVendorPageState extends State<ConnectedVendorPage> {
 Widget space(){return SizedBox(height: 8.0.h,);}
  @override
  Widget build(BuildContext context) {
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    dynamic driver = booking.driverInfo;

    return Scaffold(
        body: WillPopScope(
          onWillPop: () => Future.value(false),
          child: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {

    if(state is BookingSuccess){
    Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
    }
    if(state is BookingDenied){
    ScaffoldMsg().errorMsg(context, state.errors[0]);
    }

    },
    builder: (context, state) {
    return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  //alignment: Alignment.bottomLeft,
                  children: [
                    InkWell(
                        onTap: (){AuthBloc().launchTel(driver["phoneNumber"]);},
                        child: SvgPicture.asset('assets/call_bg.svg',width: MediaQuery.of(context).size.width,)),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 45),
                            child: Row(
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: "Delivery ",
                                      style: Theme.of(context).textTheme.overline,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: kVendor,
                                          style: Theme.of(context).textTheme.caption,
                                        ),


                                      ]

                                  ),
                                ),
                              ],
                            ),

                          ),
                          space(),
                           Text("${booking.timeTaken} (${booking.distance}Km)",style: TextStyle(color: kYellow,fontWeight: FontWeight.bold),),
                          space(),
                          Text("${driver["name"]}",style: Theme.of(context).textTheme.overline,),
                          space(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100.w,
                                child: ElevatedButton(
                                    onPressed: (){},
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(kContainerRadius),
                                                  bottomLeft: Radius.circular(kContainerRadius),
                                                  /*topLeft: Radius.circular(10),*/
                                                  bottomRight: Radius.circular(kContainerRadius)
                                      ))),

                                      backgroundColor: MaterialStateProperty.all<Color>(kOrangeColor)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,size: 20.0.sp,),
                                         Text(driver["rating"].toString()),
                                      ],
                                    ),

                                ),
                              ),
                             booking.isLegal == true?
                             PopupMenuButton(

                                 child: const Icon(Icons.more_vert,color: kWhiteColor,),
                                 itemBuilder: (context) =>
                                 [
                                   PopupMenuItem(child:  GestureDetector(
                                       onTap: (){GeneralDialog.showGeneralDialog(
                                           content: kConfirmBooking,
                                           context:context,
                                           header: kConfirmBooking2.toUpperCase(),
                                           tapFunction: () async {
                                         Navigator.pop(context);
                                         BlocProvider.of<BookingBloc>(context).add(CustomerConfirmBookingRequested(booking.bookingId,booking.customerAuthId.toString()));

                                       }

                                       );},
                                       child: const Text(kConfirmBooking2)),)
                                 ]

                             )
                                 : PopupMenuButton(

                                  child: const Icon(Icons.more_vert,color: kWhiteColor,),
                                itemBuilder: (context) =>
                                [

                                  PopupMenuItem(child: GestureDetector(
                                      onTap: ()=>Navigator.pushNamed(context, customerEditBooking),
                                      child: const Text("Edit booking")),),
                                   PopupMenuItem(child:  GestureDetector(
                                      onTap: (){GeneralDialog.showGeneralDialog(content: kCancelBooking,context:context,header: "Cancel booking".toUpperCase(), tapFunction: () async {
                                        Navigator.pop(context);
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            isDismissible: false,
                                            builder: (context) => const ReasonToCancelBooking()
                                        );
                                        }

                                      );},
                                      child: const Text("Cancel booking")),)
                             ]

                              )
                            ],
                          )

                        ],
                      ),
                    ),

                  ],
                ),
                const RoutingMap(),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     InkWell(
                         onTap: (){AuthBloc().launchTel(driver["phoneNumber"]);},
                         child: SvgPicture.asset('assets/call.svg')),
                     SvgPicture.asset('assets/direction.svg'),
                   ],
                 ),
                SvgPicture.asset('assets/pick_up.svg',height: 150.h,width: 150.w,),
                spacing(),
                Text("Total Amount to be paid".toUpperCase(),style: Theme.of(context).textTheme.bodyText1,),
                Text(booking.totalAmount.toString().toUpperCase(),style: Theme.of(context).textTheme.subtitle1,),
                Text("$kVendor arrives in ${booking.timeTaken}".toUpperCase(),style:TextStyle(color: kDarkRedColor,fontWeight: FontWeight.bold,fontSize: kFontSize13)),
               spacing(),
                Text("All our vendors are screened".toUpperCase(),style: Theme.of(context).textTheme.headline6,),

              ],
            ),
          );
        })));
  }
}
