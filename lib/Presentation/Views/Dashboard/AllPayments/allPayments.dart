import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/utils/dateFormat.dart';
class AllPayments extends StatelessWidget {
  const AllPayments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Text("salesgirl@gmail.com",style: Theme.of(context).textTheme.headline6,),
                            Text("Card",style: Theme.of(context).textTheme.headline4,),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          Text("Successful",style: Theme.of(context).textTheme.headline2,),
                          Text("Transaction",style: Theme.of(context).textTheme.headline4!.copyWith(color: kYellow),),
                        ],
                      ),
                      Text("78373",style: Theme.of(context).textTheme.headline5,),

                    ],
                  ),
                  spacing(),
                  DateFormatFunction(),
                  Text("Amaka love",style: Theme.of(context).textTheme.headline1,),
                  Text("+8378273823",style: Theme.of(context).textTheme.headline2,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
