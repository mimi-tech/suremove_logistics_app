import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Views/Admin/Widgets/header.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/earningConstructors.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
class BookingInTransit extends StatelessWidget {
  const BookingInTransit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kMargin2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacing(),
            const AdminHeader(title: "Driver's name",),
            Row(
              children: [
                const ProfilePicture(),
                const  SizedBox(width: 5.0,),
                Text("Ugo\nZenith",style: Theme.of(context).textTheme.headline1,)
              ],
            ),
            const AdminHeader(title: "Customer's name",),
            Text("Ugo Zenith",style: Theme.of(context).textTheme.headline1,),

            spacing(),
            const AdminHeader(title: "Booking details",),
            EarningConstructor(
              dateString: "2022-10-24 11:48:43.399356",
              itemSize: "23",
              itemQuantity: "4",
              itemName: "Rice",
              company: "Sure move logistics",
              paymentMethod: "Card",
              deliveryFee: "4094",
              total: "43434",

            ),

            Divider()

          ],
        ),
      ),
    );
  }
}



