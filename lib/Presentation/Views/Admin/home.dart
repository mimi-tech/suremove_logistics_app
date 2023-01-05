import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Views/Admin/Widgets/phoneNumber.dart';
import 'package:sure_move/Presentation/Views/Widgets/drawerHandle.dart';
import 'package:sure_move/Presentation/utils/dateFormat.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kMargin2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
           children: [
             const ProfilePicture(image: ""),
            const  SizedBox(width: 5.0,),
             Text("Ugo\nZenith",style: Theme.of(context).textTheme.headline1,)
           ],
         ),
          Text("Company name",style: Theme.of(context).textTheme.headline6,),
          const PhoneNumber(title: "+233322424324324",),
          const DateFormatFunction()
        ],
      ),
      ),
    ));
  }
}
