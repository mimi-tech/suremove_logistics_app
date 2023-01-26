import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/DriverLogic/driverBloc.dart';
import 'package:sure_move/Logic/DriverLogic/driverEvent.dart';
import 'package:sure_move/Logic/DriverLogic/driverState.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/naira.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
import 'package:sure_move/Providers/driverProvider.dart';
class DecisionScreen extends StatefulWidget {
  const DecisionScreen({Key? key}) : super(key: key);

  @override
  State<DecisionScreen> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends State<DecisionScreen> {
  Widget space(){return SizedBox(height: 8.0.h,);}

  @override
  Widget build(BuildContext context) {
    DriverModel driver = Provider.of<DriverProvider>(context).driver;
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    dynamic sender = booking.sender!;
    return Scaffold(body: BlocConsumer<DriversBloc, DriverState>(
        listener: (context, state) {

          if(state is DriverSuccess){
            Navigator.pushNamed(context, deliveryScreen);
          }
          if(state is NotFound){
            Navigator.pushReplacementNamed(context, vendorWaitingScreen);
          }

          if(state is DriverDenied){
            ScaffoldMsg().errorMsg(context, state.errors[0]);
          }

        },
        builder: (context, state) {

          return ModalProgressHUD(
      inAsyncCall: ( state is DriverLoading)?true:false,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: SingleChildScrollView(
          child:   Column(
            children: [
              Stack(
                //alignment: Alignment.bottomLeft,
                children: [
                  SvgPicture.asset('assets/call_bg.svg',width: MediaQuery.of(context).size.width,),

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
                                    text: "Delivery ".toUpperCase(),
                                    style: Theme.of(context).textTheme.caption,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: kVendor.toUpperCase(),
                                        style: Theme.of(context).textTheme.caption,
                                      ),


                                    ]

                                ),
                              ),
                            ],
                          ),

                        ),
                        space(),
                        Text(booking.sourceAddress.toString(),style: Theme.of(context).textTheme.overline!.copyWith(fontSize: kFontSize13),),
                        Text(booking.destinationAddress.toString(),style: Theme.of(context).textTheme.overline!.copyWith(fontSize: kFontSize13),),

                        space(),
                         Text("${booking.timeTaken} (${booking.distance}Km)",style: const TextStyle(color: kYellow,fontWeight: FontWeight.bold),),
                        space(),
                        Text("${driver.firstName}\n${driver.lastName}",style: Theme.of(context).textTheme.overline,),

                      ],
                    ),
                  ),

                ],
              ),

              SizedBox(height: 200.h,
              child:  CachedNetworkImage(

                imageUrl:sender["profilePicture"],
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => SvgPicture.asset('assets/user.svg'),
                fit: BoxFit.cover,


              ),
              ),
              spacing(),
              Text(kPickUp.toUpperCase(),style: Theme.of(context).textTheme.caption,),
              const Divider(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: kMargin,vertical: 20.0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "$kPayType: ",
                                style: Theme.of(context).textTheme.headline1,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: booking.methodOfPayment.toString(),
                                    style: Theme.of(context).textTheme.headline1,
                                  ),


                                ]

                            ),
                          ),
                          spacing(),
                          Text("Delivery: Now", style: Theme.of(context).textTheme.headline1)
                        ],
                      ),
                      const VerticalDivider(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "$kDeliveryFee: ",
                                style: Theme.of(context).textTheme.headline1,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "$nairaSign${booking.amount}",
                                    style: Theme.of(context).textTheme.headline4,
                                  ),


                                ]

                            ),
                          ),
                          spacing(),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "$kTotal ",
                                style: Theme.of(context).textTheme.headline1,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "$nairaSign${booking.totalAmount}",
                                    style: Theme.of(context).textTheme.headline5,
                                  ),


                                ]

                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(kTotal, style: Theme.of(context).textTheme.bodyText1),
                  Text("$nairaSign${booking.totalAmount}", style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: kFontSize16))

                ],
              ),
            ),
              const Divider(),

              spacing(),
              spacing(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GeneralButton(title: "Decline", tapStudiesButton: (){
                    BlocProvider.of<DriversBloc>(context).add(DriverBookingDecisionRequested(driver.driverId,booking.customerAuthId.toString(),DecisionType.decline.name));

                  },color: kRedColor,),
                  GeneralButton(title: "Accept", tapStudiesButton: (){
                    BlocProvider.of<DriversBloc>(context).add(DriverBookingDecisionRequested(driver.driverId,booking.customerAuthId.toString(),DecisionType.accept.name));

                  },color: kGreen,),
                ],
              )

            ],
          )
          )
            ),
      );
  }));
  }
}
