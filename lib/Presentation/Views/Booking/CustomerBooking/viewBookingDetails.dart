import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class ViewBookingDetails extends StatefulWidget {
  const ViewBookingDetails({Key? key}) : super(key: key);

  @override
  State<ViewBookingDetails> createState() => _ViewBookingDetailsState();
}

class _ViewBookingDetailsState extends State<ViewBookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
            backgroundColor: kWhiteColor,
            title: Text(kDeliveryDetails.toUpperCase(),style:TextStyle(color: kOrangeColor),),
            iconTheme: const IconThemeData(color: kBlackColor),
        ),
        bottomNavigationBar: GeneralButton(title: kDone, tapStudiesButton: (){Navigator.pop(context);}),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacing(),
                 Header(title: kItemName,subtitle: "sjdjshks",),
                spacing(),
                Header(title: kItemNumber,subtitle: "sjdjshks",),

                spacing(),
                Header(title: kItemSize,subtitle: "sjdjshks",),

                spacing(),
                Header(title: kSourceLocation,subtitle: "sjdjshks",),

                spacing(),
                Header(title: kDestinationLocation,subtitle: "sjdjshks",),

                spacing(),
                Header(title: kSendersName,subtitle: "sjdjshks",),

                spacing(),
                Header(title: kSendersPhoneNumber,subtitle: "sjdjshks",),

                spacing(),
                Header(title: kReceiverName,subtitle: "sjdjshks",),

                spacing(),
                Header(title: kReceiverPhoneNumber,subtitle: "sjdjshks",),

                spacing(),
                Header(title: kTotal,subtitle: "sjdjshks",),



              ],
            ),
    ),
        ));
  }
}


class Header extends StatelessWidget {
   Header({Key? key, required this.title,required this.subtitle}) : super(key: key);
final String title;
final String subtitle;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: "$title: ",
          style: Theme.of(context).textTheme.subtitle1,
          children: <TextSpan>[
            TextSpan(
              text: subtitle,
              style: Theme.of(context).textTheme.bodyText2,
            ),


          ]

      ),
    );
  }
}
