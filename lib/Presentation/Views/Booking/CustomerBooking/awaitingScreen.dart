import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/googlemapScreen.dart';
import 'package:sure_move/Providers/userProvider.dart';

class CustomerAwaitingScreen extends StatefulWidget {
  const CustomerAwaitingScreen({Key? key}) : super(key: key);

  @override
  State<CustomerAwaitingScreen> createState() => _CustomerAwaitingScreenState();
}

class _CustomerAwaitingScreenState extends State<CustomerAwaitingScreen> {
  double _progressValue = 0.0;
  var oneSec = const Duration(seconds: 1);
  Timer? timer;
  Timer? timers;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _progressValue =  _progressValue + 0.002;
      });
      if (_progressValue.toStringAsFixed(1) == '1.0') {
        Navigator.pushNamed(context, homePage);
        ScaffoldMsg().errorMsg(context, "Sorry we didn't get a driver for you");
      }
    });
    getADriver();
  }
  getADriver(){
    timers = Timer.periodic(const Duration(minutes: 5), (timers) {
    NewUser user = Provider.of<UserProvider>(context).user;
    String fullName = "${user.firstName} ${user.lastName}";
    BlocProvider.of<BookingBloc>(context).add(MatchADriverRequested(fullName,user.phoneNumber,context));
  });
  }


 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
    timers!.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WillPopScope(
      onWillPop: () => Future.value(false),
      child: BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {

    if(state is UserSuccess){
    Navigator.pushNamed(context, connectedVendorPage);
    }
    if(state is UserDenied){
    Navigator.pushNamed(context, displayAmount);

    ScaffoldMsg().errorMsg(context, state.errors[0]);
    }

    },
    builder: (context, state) {
      return Column(

        children: [
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.5,
            child: GoogleMapScreen(
                latitude: BookingCollections.bookingDetails[0].sourceLatitude,
                longitude: BookingCollections.bookingDetails[0].sourceLogitude),
          ),
          spacing(),
          Text(kWaitingText, style: Theme
              .of(context)
              .textTheme
              .subtitle1),
          space(),
          Expanded(child: Column(
            children: [
              SizedBox(
                height: 150.h,
                width: 150.w,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: kDarkBlue,
                  valueColor: const AlwaysStoppedAnimation<Color>(kOrangeColor),
                  value: _progressValue,
                ),
              ),
              Text('${(_progressValue * 100).round()}%'),

            ],
          )),


          Container(
              color: kRadioColor,
              child: IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.close))),


          spacing(),
        ],
      );
    }))
    );
  }
}
