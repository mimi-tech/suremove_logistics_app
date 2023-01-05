import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
class AdminDrawer extends StatelessWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(
      children: [
        Row(
          children: [
            SizedBox(width: 10.w,),
            SvgPicture.asset('assets/user.svg'),
            SizedBox(width: 30.w,),
            Column(
              children: [
                Text("Ugo",style: Theme.of(context).textTheme.bodyText1),
                Text(kLogOut,style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kRadioColor),),

              ],
            )
          ],
        ),
        space(),

        ListTile(
          onTap: (){Navigator.pushNamed(context, companyTab);},
          leading:Icon(Icons.compare),
          title:  Text(kCompany,style: Theme.of(context).textTheme.bodyText2),
        ),

        ListTile(
          onTap: (){Navigator.pushNamed(context, onlineDrivers);},
          leading:Icon(Icons.car_crash_rounded),
          title:  Text("Drivers",style: Theme.of(context).textTheme.bodyText2),
        ),

        ListTile(
          onTap: (){Navigator.pushNamed(context, adminBookingTab);},
          leading:Icon(Icons.compare),
          title:  Text("Bookings",style: Theme.of(context).textTheme.bodyText2),
        ),


      ],
    ));
  }
}
