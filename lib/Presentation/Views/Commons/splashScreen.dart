import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Commons/homePage.dart';
import 'package:sure_move/Presentation/utils/logo.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,value: 0.1,duration:  const Duration(seconds: 4));
    animation = CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => setState(() {}));
    animationController!.forward();

    setState(() {
    _visible = !_visible;
    });
    startTime();
  }
  void startTime() {

    BlocProvider.of<AuthBloc>(context).add(AuthInit());

  }
  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrangeColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
      if (state is AuthAuthenticated) {
        Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);

      }
      if (state is AuthNotAuthenticated) {

        Navigator.pushNamedAndRemoveUntil(context, loginPage, (route) => false);
      }
      if (state is AuthDeniedForever) {
        Navigator.pushNamedAndRemoveUntil(context, permissionDeniedScreen, (route) => false);
      }
      if (state is AuthDenied) {
        ScaffoldMsg().errorMsg(context, state.errors[0]);
        Navigator.pushNamedAndRemoveUntil(context, loginPage, (route) => false);

      }
    },
    builder: (context, state) {
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[

              Padding(
                padding: EdgeInsets.only(bottom: 30.0), child: LogoDesign(),)

            ],),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/splash.svg',
                width: animation!.value * 250,
                height: animation!.value * 250,
              ),
            ],
          ),
        ],
      );
    }));
  }


}
