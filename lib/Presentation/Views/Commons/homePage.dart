import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Commons/drawer.dart';
import 'package:sure_move/Presentation/Views/Widgets/drawerHandle.dart';
import 'package:sure_move/Presentation/utils/logo.dart';
import 'package:sure_move/Providers/userProvider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {


    NewUser user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      floatingActionButton: Container(

        height: 60.h,
        width: 60.h,
        decoration: BoxDecoration(
            color: kOrangeColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            onPressed: (){
              if(user == null && !user.isOngoingBooking! ){
                ScaffoldMsg().errorMsg(context, kOnGoingError);
              }else{

                Navigator.pushNamed(context, itemDetails);
              }
              },
            child: Center(child: Text("Book".toUpperCase(),style: Theme.of(context).textTheme.overline,))),
      ),
        drawer: const DrawerPage(),
        body: Container(
          decoration: const BoxDecoration(
              image:  DecorationImage(
                image:  AssetImage('assets/home_bg.png'),
                fit: BoxFit.cover,)),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              spacing(),
              spacing(),
               Column(
                 children: const [
                   LogoDesign(),

                   Align(
                       alignment: Alignment.topLeft,
                       child: DrawerHandle()),
                 ],
               ),

                  spacing(),

             Column(
               children: [
                 Text("Home services".toUpperCase(),style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 25.sp),),
                 Text("Home Delivery".toUpperCase(),style: Theme.of(context).textTheme.bodyText2,),

               ],
             ),
              space(),
          spacing(),
          SvgPicture.asset('assets/pick_up.svg',height: 200.h,width: 200.h,),
           space(),
              spacing(),
              Container(
                width: double.infinity,
                height: 80,
                color: kBlackColor.withOpacity(0.85),
                child: Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "FAST ",
                        style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 20.sp),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Delivery".toUpperCase(),
                            style: Theme.of(context).textTheme.overline!.copyWith(fontWeight: FontWeight.normal,fontSize: 20.sp),
                          ),


                        ]

                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
