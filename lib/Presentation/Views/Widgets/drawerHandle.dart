import 'package:flutter/material.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
class DrawerHandle extends StatelessWidget {
  const DrawerHandle({Key? key, this.user}) : super(key: key);
final NewUser? user;
  @override
  Widget build(BuildContext context) {
    return  IconButton(onPressed: (){
      if(user!.blocked == false && user!.isActive == true){
        Scaffold.of(context).openDrawer();
      }else{
        Navigator.pushNamed(context, penaltyScreen);
      }

    }, icon: Icon(Icons.line_weight,color: kBlackColor,));
  }
}
