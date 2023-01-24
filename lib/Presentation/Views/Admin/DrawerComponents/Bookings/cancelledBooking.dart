import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Views/Admin/Widgets/header.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
import 'package:sure_move/Presentation/utils/dateFormat.dart';
class CancelledBooking extends StatelessWidget {
  const CancelledBooking({Key? key}) : super(key: key);

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ugo\nZenith",style: Theme.of(context).textTheme.headline1,),
                    DateFormatFunction()

                  ],
                ),
              ],
            ),
            const AdminHeader(title: "Customer's name",),
            Text("Ugo Zenith",style: Theme.of(context).textTheme.headline1,),

            const AdminHeader(title: "Company name",),
            Text("Ugo Zenith",style: Theme.of(context).textTheme.headline1,),

          ],
        ),
      ),
    );
  }
}
