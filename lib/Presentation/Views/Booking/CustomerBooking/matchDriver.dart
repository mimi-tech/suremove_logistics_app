import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/googlemapScreen.dart';
import 'package:sure_move/Providers/userProvider.dart';
class DisplayAmount extends StatefulWidget {
  const DisplayAmount({Key? key}) : super(key: key);

  @override
  State<DisplayAmount> createState() => _DisplayAmountState();
}

class _DisplayAmountState extends State<DisplayAmount> {
  dynamic lat;
  dynamic lng;
  dynamic userPaymentType;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getPaymentType();
    super.didChangeDependencies();
  }
  getPaymentType() async{

       var result =  await UserPreferences().getPaymentType();
     setState(() {
       userPaymentType = result;
     });
  }
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    getPaymentType();
    for(var values in BookingCollections.bookingDetails){
      lat = values.sourceLatitude;
      lng = values.sourceLogitude;
    }
    return Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: GoogleMapScreen(latitude: lat,longitude: lng),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    color: kOrangeColor,
                      child: IconButton(onPressed: (){

                        Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios))),
                ),

              ],
            ),

            Expanded(child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/pick_up.svg'),
                   Text(kPickUp,style: Theme.of(context).textTheme.caption,)
                    ],
                  ),
                ),
              spacing(),
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
                            InkWell(
                              onTap:()=>Navigator.pushNamed(context, paymentMethods),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "$kPayType: ",
                                    style: Theme.of(context).textTheme.bodyText1,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: userPaymentType,
                                        style: Theme.of(context).textTheme.headline6,
                                      ),


                                    ]

                                ),
                              ),
                            ),
                            spacing(),

                            GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, viewBookingDetails);
                                },
                                child: Text(kOrderDetails, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue)))
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
                                      text: BookingCollections.bookingDetails[0].amount.toString(),
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
                                      text: "₦${BookingCollections.bookingDetails[0].amount.toString()}",
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


              ],
            )),
            GeneralButton(title: kBook,tapStudiesButton: () async {
              String fullName = "${user.firstName} ${user.lastName}";
               UserPreferences().getPaymentType().then((value) => {
                if(value != kCard){
                  BlocProvider.of<BookingBloc>(context).add(MatchADriverRequested(fullName,user.phoneNumber,context))

                }else{
                   BlocProvider.of<BookingBloc>(context).add(CustomerTransactionRequested(
                   user.email!,
                   user.firstName!,
                   user.lastName!,
                   user.phoneNumber!,
                   BookingCollections.bookingDetails[0].amount,
                   context,
                   "fund",
                   user.userId,
                   user.email
               ))

                },
               Navigator.pushNamed(context, ripplesAnimation)
              });




             },),
            space()
          ],
        )
    );
  }
}
