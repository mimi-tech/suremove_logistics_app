import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/dateFormat.dart';
class EarningConstructor extends StatelessWidget {
   EarningConstructor({Key? key,
  required this.dateString,
  required this.itemSize,
  required this.itemQuantity,
  required this.itemName,
  required this.paymentMethod,
  required this.deliveryFee,
  required this.total,
    this.company
  }) : super(key: key);

  final String dateString;
  final dynamic itemSize;
  final dynamic itemQuantity;
  final dynamic itemName;
  final dynamic paymentMethod;
  final dynamic deliveryFee;
  final dynamic total;
  final String? company;

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$itemSize kg",style: Theme.of(context).textTheme.headline1),
                Text("Qty",style: Theme.of(context).textTheme.headline2),
                Text("[$itemQuantity]",style: Theme.of(context).textTheme.headline1),
                Text("[$itemName]",style: Theme.of(context).textTheme.headline1),

              ],
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      text: "$kTotal: ",
                      style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: total,
                          style: Theme.of(context).textTheme.headline5,
                        ),


                      ]

                  ),
                ),

              ],
            )
          ],
        ),

        spacing(),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Company: ",
              style: Theme.of(context).textTheme.headline1!.copyWith(color: kYellow),
              children: <TextSpan>[
                TextSpan(
                  text: company,
                  style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: kFontSize16),
                ),


              ]

          ),
        ),

      ],
    );
  }
}
