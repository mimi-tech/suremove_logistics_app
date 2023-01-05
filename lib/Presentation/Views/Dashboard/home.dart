import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/chart.dart';
import 'package:sure_move/Presentation/Views/Funds/Funding/amountScreen.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
class DashboardHome extends StatelessWidget {
  const DashboardHome({Key? key}) : super(key: key);
   Widget cardSpacing(){
     return SizedBox(height: 10.h,);
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kOrangeColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin2),
      child: Column(
          children: [
           space(),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: kWhiteColor,)),
                 Text(kDashBoard.toUpperCase(),style: Theme.of(context).textTheme.overline,),
                 ProfilePicture(image: "" ),

               ],
             ),
            spacing(),
            Card(
              color: kWhiteColor,
              child: Column(
                children: [
                  cardSpacing(),
                  Text(kToday.toUpperCase(),style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: kFontSize16),),
                 spacing(),
                  Text("0.00".toUpperCase(),style: Theme.of(context).textTheme.bodyText2),
                  spacing(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("0 order(s)".toUpperCase(),style: Theme.of(context).textTheme.headline1),
                        Text("0 hr".toUpperCase(),style: Theme.of(context).textTheme.headline1),

                      ],
                    ),
                  ),
                  cardSpacing(),
                ],
              ),
            ),
            spacing(),
            Card(
              color: kWhiteColor,
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  cardSpacing(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    GestureDetector(
                      onTap:(){ showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => const AmountScreen());

                      },
                      child: Material(
                        color: kOrangeColor.withOpacity(0.2),
                        child: Text(kWallet2.toUpperCase(),style: Theme.of(context).textTheme.headline4,),
                      ),
                    ),
                    Material(
                      color: kOrangeColor.withOpacity(0.2),
                      child: Text(kWithdrawls,style: Theme.of(context).textTheme.headline4,),
                    )
                  ],
                  ),
                  spacing(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(kWalletBal,style: Theme.of(context).textTheme.headline2,),
                      Text("NGN 438934",style: Theme.of(context).textTheme.bodyText1,),

                    ],
                  ),
                  spacing(),
                  const BarChartSample1()
                ],),
              ),
            ),
            spacing(),
            Card(
              color: kWhiteColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Header(),
                    spacing(),

                    HeaderText(
                        title: kReferrialEarnings,
                        subTitleColor: kOrangeColor,
                        subTitle: "(NGN 4343)",
                        onPressed: (){Navigator.pushNamed(context, promotionalEarning);}
                    ),
                    cardSpacing(),
                    HeaderText(
                        title: kMyEarnings,
                        subTitleColor: kSeaGreen,
                        subTitle: "(NGN 4343)",
                        onPressed: (){Navigator.pushNamed(context, totalEarningsTab);}
                    ),
                    cardSpacing(),
                    HeaderText(
                        title: kWithdrawal,
                        subTitleColor: kDarkRedColor,
                        subTitle: "(NGN 4343)",
                        onPressed: (){}
                    ),
                    cardSpacing(),
                    HeaderText(
                        title: kAllTrans,
                        subTitleColor: kWhiteColor,
                        subTitle: "",
                        onPressed: (){Navigator.pushNamed(context, transactionTab);}
                    ),

                    cardSpacing(),
                    HeaderText(
                        title: kAllPayments.toUpperCase(),
                        subTitleColor: kWhiteColor,
                        subTitle: "",
                        onPressed: (){Navigator.pushNamed(context, allPaymentTab);}
                    ),
                  ],
                ),
              ),
            ),
            spacing(),
            Card(
              color: kWhiteColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$kVendor orders".toUpperCase(),style: Theme.of(context).textTheme.headline2),
                    const Header(),
                    cardSpacing(),
                    HeaderText(
                        title: kOrderHistory,
                        subTitleColor: kWhiteColor,
                        subTitle: "",
                        onPressed: (){Navigator.pushNamed(context, orderHistory);}
                    ),

                  ],
                ),
              ),
            ),

            spacing(),
            Card(
              color: kWhiteColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("my order(s)".toUpperCase(),style: Theme.of(context).textTheme.headline2),
                    const Header(),
                    cardSpacing(),
                    HeaderText(
                        title: kOngoingOrder,
                        subTitleColor: kBlackColor,
                        subTitle: "(3)",
                        onPressed: (){Navigator.pushNamed(context, connectedVendorPage);}
                    ),
                  ],
                ),
              ),
            )
          ],
      ),
    ),
        ));
  }
}


class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ProfilePicture(image: ""),
      SizedBox(width: 10.w,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Ugo Zenith",style: Theme.of(context).textTheme.headline1,),
        Row(children: [
          Icon(Icons.star,color: kOrangeColor,size: 10.0.sp,),
          Text("2.5",style: Theme.of(context).textTheme.headline1,),

        ],)
      ],)
    ],);
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key,
    required this.title,
    required this.subTitleColor,
    required this.subTitle,
    required this.onPressed
  }) : super(key: key);
  final String title;
  final String subTitle;
  final Color subTitleColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "$title ",
              style: Theme.of(context).textTheme.headline1,
              children: <TextSpan>[
                TextSpan(
                  text: subTitle,
                  style: TextStyle(
                    color: subTitleColor,
                    fontSize: kFontSize13,
                    fontWeight: FontWeight.bold
                  ),
                ),


              ]

          ),
        ),
        IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_forward_ios))
      ],
    );
  }
}



