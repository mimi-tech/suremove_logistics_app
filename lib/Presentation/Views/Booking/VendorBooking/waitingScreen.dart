import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/DriverLogic/driverBloc.dart';
import 'package:sure_move/Logic/DriverLogic/driverEvent.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Providers/driverProvider.dart';
class VendorWaitingScreen extends StatefulWidget {
  const VendorWaitingScreen({Key? key}) : super(key: key);

  @override
  State<VendorWaitingScreen> createState() => _VendorWaitingScreenState();
}

class _VendorWaitingScreenState extends State<VendorWaitingScreen> {
  @override
  Widget build(BuildContext context) {
    DriverModel driver = Provider.of<DriverProvider>(context).driver;

    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: kWhiteColor,
          child: SizedBox(
            height: 56.0,
            child: Center(
              child: FlutterSwitch(
                width: 125.0,
                height: 55.0,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: true,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  var status = BlocProvider.of<DriversBloc>(context).add(DriverUpdateStatusRequested(driver.driverId,val?"offline":"online"));
                  setState(() {
                    val != val;
                  });
                },
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.h,
          decoration: BoxDecoration(
            color: kLightBlue,
            borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12.0.sp),
                  bottomLeft: Radius.circular(12.0.sp),
                )

          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.0.sp),
                                    bottomLeft: Radius.circular(12.0.sp),
                                ))),

                        backgroundColor: MaterialStateProperty.all<Color>(kOrangeColor)),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.arrow_back_ios,color: kBlackColor,),
                    )

                  ),
                ),
                Text("Ugo\nZenith",style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightDoneColor),),

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
                        const Text("2.8"),
                      ],
                    ),

                  ),
                ),
                SvgPicture.asset('assets/user.svg',height: 50,width: 50,),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
