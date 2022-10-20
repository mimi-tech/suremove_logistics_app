import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/dimens.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/utils/generalButton.dart';
class DisplayAmount extends StatefulWidget {
  const DisplayAmount({Key? key}) : super(key: key);

  @override
  State<DisplayAmount> createState() => _DisplayAmountState();
}

class _DisplayAmountState extends State<DisplayAmount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: kOrangeColor,
          ),

          Expanded(child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/pick_up.svg'),
               Text(kPickUp,style: Theme.of(context).textTheme.caption,)
                ],
              ),
            spacing(),
              const Divider(),

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
                                style: Theme.of(context).textTheme.bodyText1,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Card",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),


                                ]

                            ),
                          ),
                          spacing(),

                          GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, viewBookingDetails);
                              },
                              child: Text(kOrderDetails, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue)))
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


            ],
          )),
          GeneralButton(title: kBook,tapStudiesButton: (){Navigator.pushNamed(context, connectedVendorPage);},),
          space()
        ],
      ),
    ));
  }
}
