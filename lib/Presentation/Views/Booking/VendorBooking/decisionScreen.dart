import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/generalDialog.dart';
class DecisionScreen extends StatefulWidget {
  const DecisionScreen({Key? key}) : super(key: key);

  @override
  State<DecisionScreen> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends State<DecisionScreen> {
  Widget space(){return SizedBox(height: 8.0.h,);}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            //alignment: Alignment.bottomLeft,
            children: [
              SvgPicture.asset('assets/call_bg.svg',width: MediaQuery.of(context).size.width,),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Row(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Delivery ".toUpperCase(),
                                style: Theme.of(context).textTheme.caption,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: kVendor.toUpperCase(),
                                    style: Theme.of(context).textTheme.caption,
                                  ),


                                ]

                            ),
                          ),
                        ],
                      ),

                    ),
                    space(),
                    Text("783b nwjhewj wjhehj",style: Theme.of(context).textTheme.overline!.copyWith(fontSize: kFontSize13),),

                    space(),
                    const Text("34:32 (4km)",style: TextStyle(color: kYellow,fontWeight: FontWeight.bold),),
                    space(),
                    Text("Ugo\nZenith",style: Theme.of(context).textTheme.overline,),

                  ],
                ),
              ),

            ],
          ),

          Container(height: 200.h,color: kOrangeColor,),
          spacing(),
          Text(kPickUp.toUpperCase(),style: Theme.of(context).textTheme.caption,),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin,vertical: 20.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "$kPayType: ",
                            style: Theme.of(context).textTheme.headline1,
                            children: <TextSpan>[
                              TextSpan(
                                text: "Card",
                                style: Theme.of(context).textTheme.headline1,
                              ),


                            ]

                        ),
                      ),
                      spacing(),
                      Text("Delivery: Now", style: Theme.of(context).textTheme.headline1)
                    ],
                  ),
                  const VerticalDivider(),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "$kDeliveryFee: ",
                            style: Theme.of(context).textTheme.headline1,
                            children: <TextSpan>[
                              TextSpan(
                                text: "3874 NGN",
                                style: Theme.of(context).textTheme.headline4,
                              ),


                            ]

                        ),
                      ),
                      spacing(),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "$kTotal ",
                            style: Theme.of(context).textTheme.headline1,
                            children: <TextSpan>[
                              TextSpan(
                                text: "3874 NGN",
                                style: Theme.of(context).textTheme.headline5,
                              ),


                            ]

                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(kTotal, style: Theme.of(context).textTheme.bodyText1),
              Text("982393 NGN", style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: kFontSize16))

            ],
          ),
        ),
          const Divider(),

          spacing(),
          spacing(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GeneralButton(title: "Decline", tapStudiesButton: (){},color: kRedColor,),
              GeneralButton(title: "Accept", tapStudiesButton: (){},color: kGreen,),
            ],
          )

        ],
      ),
    ));
  }
}
