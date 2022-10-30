import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Commons/strings.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Admin/verifyUser.dart';
import 'package:sure_move/Views/Authentication/blockAccount.dart';
class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [

          Row(
            children: [
              SizedBox(width: 10.w,),
      SvgPicture.asset('assets/user.svg'),
           SizedBox(width: 30.w,),
              Column(
                children: [
                  Text("Ugo",style: Theme.of(context).textTheme.bodyText1),
                  Text(kViewProfile,style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kRadioColor),),

                ],
              )
            ],
          ),
          space(),

          ListTile(
            onTap: (){Navigator.pushNamed(context, dashboardHome);},

            leading:SvgPicture.asset('assets/dashBoard.svg'),
           title:  Text(kDashBoard,style: Theme.of(context).textTheme.bodyText2),
          ),
           spacing(),
           ListTile(
            leading:Icon(Icons.mail,color: kBlackColor,size: 20.0.sp,),
            title: Text(kMessage,style: Theme.of(context).textTheme.bodyText2),
          ),
          spacing(),
          ListTile(
            onTap: (){
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const VerifyAdminLoginDetails()
              );
            },
            leading:SvgPicture.asset('assets/password.svg'),
            title:  Text(kAdmin,style: Theme.of(context).textTheme.bodyText2),
          ),
          spacing(),
          ListTile(
            onTap: (){Navigator.pushNamed(context, vendorWaitingScreen);},
            leading:SvgPicture.asset('assets/vendor_icon.svg'),
            title:  Text(kWork,style: Theme.of(context).textTheme.bodyText2),
          ),
          spacing(),
          ListTile(
            onTap: (){Navigator.pushNamed(context, pickCompany);},
            leading:SvgPicture.asset('assets/pick_up.svg'),
            title:  Text("Become a vendor",style: Theme.of(context).textTheme.bodyText2),
          ),
          spacing(),

          ListTile(
            onTap: ()=>Navigator.pushNamed(context, paymentMethods),
            leading:SvgPicture.asset('assets/credit_card.svg'),
            title:  Text(kPaymentMethod,style: Theme.of(context).textTheme.bodyText2),
          ),
          spacing(),
          ListTile(
            onTap: (){Navigator.pushNamed(context, supportScreen);},
            leading:SvgPicture.asset('assets/speaker.svg'),
            title: Text(kSupport,style: Theme.of(context).textTheme.bodyText2),
          ),
          spacing(),
           ListTile(
             onTap: (){
               showModalBottomSheet(
                   isScrollControlled: true,
                   context: context,
                   builder: (context) => const BlockAccount());
             },
            leading: Icon(Icons.block,color: kBlackColor,size: 20.0.sp,),
            title: Text(kBlockUser, style: Theme.of(context).textTheme.bodyText2),
          ),
          spacing(),
           ListTile(
            leading: Icon(Icons.logout,color: kBlackColor,size: 20.0.sp,),
            title: Text(kLogOut,style: Theme.of(context).textTheme.bodyText2),
          )
        ],
      ),
    );
  }
}
