import 'package:flutter/material.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/utils/generalButton.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: GeneralButton(title: "Booking", tapStudiesButton: (){
        Navigator.pushNamed(context, itemDetails);
      }),
    ));
  }
}
