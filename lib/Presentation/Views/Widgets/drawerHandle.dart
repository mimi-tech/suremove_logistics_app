import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
class DrawerHandle extends StatelessWidget {
  const DrawerHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(onPressed: (){
      Scaffold.of(context).openDrawer();
    }, icon: Icon(Icons.line_weight,color: kBlackColor,));
  }
}
