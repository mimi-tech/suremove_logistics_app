import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlackColor,
        body: Column(
      children: [
        Container(
          color: kOrangeColor,
          height: 200.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/call.svg'),
            SvgPicture.asset('assets/direction.svg'),
          ],
        ),

        Expanded(
          child: ListView(
            children: [
              const Header(title: kSendersName,subtitle: "kerjfn kjfnjk",),
              const Header(title: kSendersPhoneNumber,subtitle: "kerjfn kjfnjk",),
              const Header(title: kReceiverName,subtitle: "kerjfn kjfnjk",),
              const Header(title: kReceiverPhoneNumber,subtitle: "kerjfn kjfnjk",),
              const Header(title: kSourceLocation,subtitle: "kerjfn kjfnjk",),
              const Header(title: kDestinationLocation,subtitle: "kerjfn kjfnjk",),
              const Header(title: kItemSize,subtitle: "kerjfn kjfnjk",),
              const Header(title: kItemNumber,subtitle: "kerjfn kjfnjk",),
              const Header(title: kItemName,subtitle: "kerjfn kjfnjk",),

              spacing(),
              const Divider(color: kWhiteColor,thickness: 1.5,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Payment type", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kCartoonColor)),
                    Text("Card", style: Theme.of(context).textTheme.caption),

                  ],
                ),

              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(kDeliveryFee, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kCartoonColor)),
                      Text("83747 NGN", style: Theme.of(context).textTheme.caption),

                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(kTotal, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kCartoonColor)),
                      Text("83747 NGN", style: Theme.of(context).textTheme.headline5),

                    ],
                  )),
              const Divider(color: kWhiteColor,thickness: 1.5,),
              space(),

            ],
          ),
        )
      ],
    ));
  }
}

class Header extends StatelessWidget {
  const Header({Key? key,required this.title,required this.subtitle}) : super(key: key);
 final String title;
 final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spacing(),
        Text(title, style: Theme.of(context).textTheme.headline2,),
        Text(subtitle, style: Theme.of(context).textTheme.headline6,)
      ],
    );
  }
}

