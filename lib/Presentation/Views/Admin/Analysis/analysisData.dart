import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';

class AnalysisData extends StatelessWidget {
  AnalysisData({Key? key,
    required this.dateString,
    required this.companyFee,
    required this.itemQuantity,
    required this.partnerFee,
    required this.paymentMethod,
    required this.deliveryFee,
    required this.total,
    required this.ownerFee
  }) : super(key: key);

  final String dateString;
  final dynamic companyFee;
  final dynamic itemQuantity;
  final dynamic partnerFee;
  final dynamic paymentMethod;
  final dynamic deliveryFee;
  final dynamic total;
  final String? ownerFee;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat("EE, d MMM, yyyy \nh:mm a").format(DateTime.parse(dateString)),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(itemQuantity,style: Theme.of(context).textTheme.headline6,),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "$kTotal: ",
                      style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w500,),
                      children: <TextSpan>[
                        TextSpan(
                          text: total,
                          style: Theme.of(context).textTheme.headline5!.copyWith(color: kDarkRedColor),
                        ),


                      ]

                  ),
                ),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "PM: ",
                      style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: deliveryFee,
                          style: Theme.of(context).textTheme.headline2,
                        ),


                      ]

                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "DF: ",
                      style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: deliveryFee,
                          style: Theme.of(context).textTheme.headline4,
                        ),


                      ]

                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Bz: ",
                      style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w500,),
                      children: <TextSpan>[
                        TextSpan(
                          text: companyFee,
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: kYellow),
                        ),


                      ]

                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Pa: ",
                      style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: partnerFee,
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: kLightDoneColor),
                        ),


                      ]

                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Own: ",
                      style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: ownerFee,
                          style: Theme.of(context).textTheme.headline5,
                        ),


                      ]

                  ),
                ),

              ],
            )
          ],
        ),



      ],
    );
  }
}
