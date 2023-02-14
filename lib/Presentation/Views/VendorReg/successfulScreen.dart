import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Models/bookingRequirmentsModel.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
import 'package:sure_move/Providers/driverProvider.dart';
class SuccessfulScreen extends StatefulWidget {
  const SuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<SuccessfulScreen> createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    DriverModel driver = Provider.of<DriverProvider>(context).driver;
    BookingRequirementsModel requirements = Provider.of<BookingProvider>(context).requirements;

    return Scaffold(
        appBar: AppBar(title:  Text(kVendorReg.toUpperCase()),),
        body: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kGreen2
              ),
              child: Icon(Icons.check,color: kWhiteColor,size: 40.sp,)),
    Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(


          children: [

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "$kThanks ",
                  style: Theme.of(context).textTheme.bodyText1,
                  children: <TextSpan>[
                    TextSpan(
                      text: " ${driver.firstName} ${driver.lastName} ",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),

                    TextSpan(
                      text: kThanks2,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextSpan(
                      text: requirements.companyAddress.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),

                    TextSpan(
                      text: " ${kThanks3}",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),


                  ]

              ),
            ),
          ],
        ),
      ),
    ),
    space(),
          GeneralButton(title: kDone, tapStudiesButton: (){
          Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
          })
      ],),
    ),
        ));
  }
}
