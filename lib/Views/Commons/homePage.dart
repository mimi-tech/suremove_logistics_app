import 'package:flutter/material.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Commons/constants.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Commons/drawer.dart';
import 'package:sure_move/Views/Widgets/drawerHandle.dart';
import 'package:sure_move/utils/generalButton.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerPage(),
        body: Column(
          children: [
            space(),
            DrawerHandle(),
            Center(
      child: GeneralButton(title: "Booking", tapStudiesButton: (){
            Navigator.pushNamed(context, deliveryScreen);
      }),
    ),
          ],
        ));
  }
}
