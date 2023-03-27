import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/chart.dart';
import 'package:sure_move/Presentation/Views/Funds/Funding/amountScreen.dart';
import 'package:sure_move/Presentation/utils/dateFormat.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/formatCurrency.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
import 'package:sure_move/Providers/driverProvider.dart';
import 'package:sure_move/Providers/userProvider.dart';
class DashboardHome extends StatelessWidget {
  const DashboardHome({Key? key}) : super(key: key);
   Widget cardSpacing(){
     return SizedBox(height: 10.h,);
   }
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    DriverModel driver = Provider.of<DriverProvider>(context).driver;

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
                 ProfilePicture(image: user.profileImageUrl ),

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
                  Text(
                      day == driver.day && month == driver.month && year == driver.year?
                      "${formatCurrency(driver.dailyAmount)}":"0.00",

                      style: Theme.of(context).textTheme.bodyText2),
                  spacing(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            day == driver.day && month == driver.month && year == driver.year?
                            "${driver.dailyCount} order(s)".toUpperCase():"0",
                            style: Theme.of(context).textTheme.headline1),
                        Text(
                            day == driver.day && month == driver.month && year == driver.year?
                            "${driver.timeCovered} hr":"0 hr",

                            style: Theme.of(context).textTheme.headline1),

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
                      Text("${formatCurrency(user.walletBalance)}",style: Theme.of(context).textTheme.bodyText1,),
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
                        subTitle: "${formatCurrency(user.promoBalance)}",
                        onPressed: (){Navigator.pushNamed(context, promotionalEarning);}
                    ),
                    cardSpacing(),
                    user.accountType  != AccountType.customer.name ||user.accountType  != AccountType.admin.name ?HeaderText(
                        title: kMyEarnings,
                        subTitleColor: kSeaGreen,
                        subTitle: "${formatCurrency(user.totalEarning)}",
                        onPressed: (){Navigator.pushNamed(context, totalEarningsTab);}
                    ):Text(""),
                    cardSpacing(),
                    HeaderText(
                        title: kWithdrawal,
                        subTitleColor: kDarkRedColor,
                        subTitle: "${formatCurrency(user.totalWithdrawal)}",
                        onPressed: (){Navigator.pushNamed(context, withdrawalHistory);}
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
            user.accountType == AccountType.driver.name ?  Card(
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
            ):Text(""),

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
                        subTitle: user.isOngoingBooking == true? "(1)":"(0)",
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
    NewUser user = Provider.of<UserProvider>(context).user;
    DriverModel driver = Provider.of<DriverProvider>(context).driver;

    return Row(children: [
      ProfilePicture(image: user.profileImageUrl),
      SizedBox(width: 10.w,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("${user.firstName} ${user.lastName}",style: Theme.of(context).textTheme.headline1,),
        Row(children: [
          Icon(Icons.star,color: kOrangeColor,size: 10.0.sp,),
          Text("${driver.rating.toDouble()}",style: Theme.of(context).textTheme.headline1,),

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



