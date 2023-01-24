import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Views/Funds/CashTransfer/verifyUser.dart';
import 'package:sure_move/Presentation/Views/Funds/Funding/amountScreen.dart';
import 'package:sure_move/Presentation/utils/generalAppbar.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  double padding = 15.0.sp;
  Widget spaceLine()=>SizedBox(height: MediaQuery.of(context).size.height * 0.045,);
@override
  void initState() {
    // TODO: implement initState
  BlocProvider.of<BookingBloc>(context).add(PaymentMethodType());
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    BlocProvider.of<BookingBloc>(context).add(PaymentMethodType());
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    var paymentType;
    return Scaffold(
        appBar: const GeneralAppbar(title: kPaymentMethod,),
        body: SingleChildScrollView(
          child:  BlocConsumer<BookingBloc, BookingState>(
    listener: (context, state) {
    if (state is UserDenied) {
    ScaffoldMsg().errorMsg(context, state.errors[0]);
    }
    if(state is UserPaymentType){
      paymentType = state.paymentType[0];

    }
    },
    builder: (context, state) {
    return Column(
            children: [
              spaceLine(),
             Card(
               color: kOrangeColor,
               child: Padding(
                 padding:  EdgeInsets.symmetric(vertical: padding),
                 child: Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         IconButton(onPressed: (){
                           BookingBloc().onSettingUserPaymentMethod(kCard);
                           BlocProvider.of<BookingBloc>(context).add(PaymentMethodType());
                           }, icon: Icon(
                              paymentType == kCard
                               ?Icons.radio_button_checked
                               :Icons.circle_outlined,

                           color: kWhiteColor,),),
                         Row(
                           children: [
                             SvgPicture.asset('assets/card_logo.svg'),
                             SizedBox(width: 10.0.w,),
                             Text(kCard,style: Theme.of(context).textTheme.overline),

                           ],
                         ),
                         Row(
                           children: [
                             SvgPicture.asset('assets/visa2.svg'),
                             SvgPicture.asset('assets/master_card.svg'),

                           ],
                         )
                       ],
                     ),
                     spaceLine(),
                     FundsGeneralButton(title:kCard2 ,tapStudiesButton: (){},color: kWhiteColor,textColor: kBlackColor,)
                   ],
                 ),
               ),
             ),

              //Wallet design
              Card(
                color: kDarkBlue2,
                child:Padding(
                  padding:  EdgeInsets.symmetric(vertical: padding),
                  child: Column(children: [
                    Row(

                      children: [
                        SizedBox(width: 40.0.w,),
                        IconButton(onPressed: (){
                          BookingBloc().onSettingUserPaymentMethod(kWallet);
                          BlocProvider.of<BookingBloc>(context).add(PaymentMethodType());
                          }, icon: Icon(
                          paymentType == kWallet
                              ?Icons.radio_button_checked
                              :Icons.circle_outlined,

                          color: kWhiteColor,

                           ),),
                        SizedBox(width: 40.0.w,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            SvgPicture.asset('assets/wallet3.svg'),
                            SizedBox(width: 10.0.w,),
                            Text(kWallet,style: Theme.of(context).textTheme.overline),
                          ],
                        ),

                      ],
                    ),
                    spaceLine(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FundsGeneralButton(title:kWallet2 ,tapStudiesButton: (){
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => const AmountScreen()
                          );
                        },color: kLightDoneColor,textColor: kBlackColor,),

                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "Wallet ".toUpperCase(),
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kLightBlue),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "bal \n",
                                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kLightBlue,fontSize: kFontSize13),
                                ),
                                TextSpan(
                                  text: "NGN 34873",
                                  style: Theme.of(context).textTheme.overline,
                                ),

                              ]

                          ),
                        ),
                      ],
                    )

                  ],),
                ),
              ),

              Card(
                color: kGreen2,
                child:Padding(
                  padding:  EdgeInsets.symmetric(vertical: padding),
                  child: Column(children: [
                    Row(

                      children: [
                        SizedBox(width: 40.0.w,),
                        IconButton(onPressed: (){
                          BookingBloc().onSettingUserPaymentMethod(kCash);
                          BlocProvider.of<BookingBloc>(context).add(PaymentMethodType());
                          }, icon: Icon(
                          paymentType == kCash
                              ?Icons.radio_button_checked
                              :Icons.circle_outlined,

                          color: kWhiteColor,

                        ),),
                        SizedBox(width: 40.0.w,),
                        SvgPicture.asset('assets/naira.svg'),

                      ],
                    ),
                    spaceLine(),

                    FundsGeneralButton(title:kCash2 ,tapStudiesButton: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => const VerifyUserTxn());
                    },color: Colors.greenAccent,textColor: kBlackColor,),


                  ],),
                ),
              ),

              Card(
                color: kDullBlue,
                child:Padding(
                  padding:  EdgeInsets.symmetric(vertical: padding),
                  child: Column(children: [
                    Row(

                      children: [
                        SizedBox(width: 40.0.w,),
                        IconButton(onPressed: (){
                          BookingBloc().onSettingUserPaymentMethod(kPromo);
                          BlocProvider.of<BookingBloc>(context).add(PaymentMethodType());
                          }, icon: Icon(
                          paymentType == kPromo
                              ?Icons.radio_button_checked
                              :Icons.circle_outlined,
                          color: kWhiteColor,

                        ),),
                        SizedBox(width: 40.0.w,),
                        Text(kPromo,style: Theme.of(context).textTheme.overline),


                      ],
                    ),
                    spaceLine(),
                    Text(kPromo2,style: Theme.of(context).textTheme.caption),
                    Text("NGN 87384",style: Theme.of(context).textTheme.overline),



                  ],),
                ),
              )
            ],
          );
        })
          ));
  }
}
