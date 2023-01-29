import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/DriverLogic/driverBloc.dart';
import 'package:sure_move/Logic/DriverLogic/driverEvent.dart';
import 'package:sure_move/Logic/DriverLogic/driverState.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
import 'package:sure_move/Providers/userProvider.dart';
class RatingDriver extends StatefulWidget {
  const RatingDriver({Key? key}) : super(key: key);

  @override
  State<RatingDriver> createState() => _RatingDriverState();
}

class _RatingDriverState extends State<RatingDriver> {
  final TextEditingController _feedback = TextEditingController();
  dynamic ratingNumber  = 1.0;
  @override
  Widget build(BuildContext context) {
    BookingModel booking = Provider.of<BookingProvider>(context).user;
    NewUser user = Provider.of<UserProvider>(context).user;
    dynamic driver = booking.driverInfo;
    dynamic company = booking.companyDetails;
    return Scaffold(
        appBar: AppBar(title:  Text(kRating.toUpperCase()),),
        body:BlocConsumer<DriversBloc, DriverState>(
        listener: (context, state) {

      if(state is DriverSuccess){
        Navigator.pushReplacementNamed(context, homePage);
        ScaffoldMsg().successMsg(context, "Thank you for rating our driver",);
      }
      if(state is DriverDenied){
        ScaffoldMsg().errorMsg(context, state.errors[0]);
      }

    },
    builder: (context, state) {

    return  WillPopScope(
      onWillPop: ()=> Future.value(false),
      child: ModalProgressHUD(
        inAsyncCall: (state is DriverLoading)?true:false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                spacing(),
                const Text(kRating2),
                space(),
                ProfilePicture(image:driver["profilePicture"] ,),
                 Text(driver["name"].toString().toUpperCase(),style: Theme.of(context).textTheme.caption,),
                space(),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,),
              onRatingUpdate: (rating) {
                ratingNumber = rating;
              },
            ),

                space(),
                Text(kRating3,style: Theme.of(context).textTheme.subtitle1,),
                TextField(
                  controller: _feedback,
                  autocorrect: true,
                  autofocus: true,
                  cursorColor: (kOrangeColor),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  style: Theme.of(context).textTheme.bodyText1,

                  decoration: const InputDecoration(
                    hintText: "Feedback [optional]",

                  ),

                ),


                space(),
                GeneralButton(title: kRating, tapStudiesButton: (){
                  var customerInfo = {
                    "id": booking.customerAuthId,
                    "name": "${user.firstName} ${user.lastName}",
                    "profilePicture": user.profileImageUrl,
                    "phoneNumber": user.phoneNumber,
                    "gender": user.gender
                  };
                  var driverInfo = {
                    "id": booking.driverId,
                    "name": driver["name"],
                    "profilePicture": driver["profilePicture"],
                    "phoneNumber": driver["phoneNumber"],
                    "gender": driver["gender"],
                    "companyId": company["id"],
                    "companyName": company["name"],
                    "companyOwner": company["owner"]
                  };
                  var message = [{
                    "id": booking.driverId,
                    "name": driver["name"],
                    "profilePicture": driver["profilePicture"],
                    "phoneNumber": driver["phoneNumber"],
                    "message":_feedback.text.trim(),
                  }];
                 _feedback.text.isNotEmpty? BlocProvider.of<DriversBloc>(context).add(CustomerRatingDriverRequested(
                      message,
                      company["id"],
                      ratingNumber,
                      customerInfo,
                      driverInfo,
                      booking.driverId.toString()
                  )):
                 BlocProvider.of<DriversBloc>(context).add(CustomerRatingDriverRequested(
                     const [],
                     company["id"],
                     ratingNumber,
                     customerInfo,
                     driverInfo,
                     booking.driverId.toString()
                 ));

                })

              ],
            ),
          ),
        ),
      ),
    );
    }));
  }
}
