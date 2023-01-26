import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/DriverLogic/driverBloc.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/googlemapScreen.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
import 'package:sure_move/Providers/driverProvider.dart';

class VendorWaitingScreen extends StatefulWidget {
  const VendorWaitingScreen({Key? key}) : super(key: key);

  @override
  State<VendorWaitingScreen> createState() => _VendorWaitingScreenState();
}

class _VendorWaitingScreenState extends State<VendorWaitingScreen> {

  Timer? timer;
 @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
   getLocation();
  }

  getLocation(){
    DriverModel driver = Provider.of<DriverProvider>(context).driver;
     if(driver.onlineStatus!){
    timer = Timer.periodic(const Duration(minutes: 15), (timer) async {
      var result = await DriversBloc().onStreamingDriverLocation(driver.driverId,context);
      if (result == true) {
        setState(() {});
      } else {
        ScaffoldMsg().errorMsg(context, result.toString());
        //timer.cancel();
      }
    });
  }else{
       if(timer != null){
         timer!.cancel();
       }

     }
 }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(timer != null){
      timer!.cancel();
    }
  }
  @override
  Widget build(BuildContext context) {
    DriverModel driver = Provider.of<DriverProvider>(context).driver;
    bool showOnOff = driver.onlineStatus!;
    //print(driver.driverId);
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 25.0,
          shape: const CircularNotchedRectangle(),
          color: kWhiteColor,
          child: SizedBox(
            height: 56.0,
            child: Center(
              child: FlutterSwitch(
                width: 125.0,
                height: 35.0,
                activeText: "Online",
                inactiveText: "Offline",
                activeColor: kGreen,
                inactiveColor: kRadioColor,
                valueFontSize: 16.0,
                toggleSize: 45.0,
                value: showOnOff,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) async {
                  var status = await DriversBloc().onUpdatingDriverStatusRequested(driver.driverId,"online",context);
                  if(status){
                    setState(() {
                      showOnOff = val;
                    });
                  }

                },
              ),
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () => Future.value(false),
          child: SingleChildScrollView(

      child: StreamBuilder<dynamic>(
        stream: DriversBloc().connectionStream(driver.driverId),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
         if (snapshot.hasData) {
    Future.delayed(Duration.zero, () {
      Provider.of<BookingProvider>(context,listen: false).setUser(snapshot.data);
      Navigator.pushNamedAndRemoveUntil(
          context, decisionScreen, (route) => false);
    });

           print("hhhhhhhhhh${snapshot.data}");
         }
          return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 220.h,
                decoration: BoxDecoration(
                  color: kVendorBg,
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
                          onPressed: (){Navigator.pop(context);},
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
                      Text("${driver.firstName}\n${driver.lastName}",style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightDoneColor),),

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
                               Text("${driver.rating}"),
                            ],
                          ),

                        ),
                      ),
                      ProfilePicture(image: driver.profileImageUrl,)

                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMapScreen(latitude: driver.currentLocationLat, longitude: driver.currentLocationLog))


                //VendorMap()
              ],
          );
        }
      ),
    ),
        ));
  }
}
