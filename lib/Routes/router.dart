import 'package:flutter/material.dart';
import 'package:sure_move/Routes/strings.dart';
import 'package:sure_move/Views/Authentication/Registration/phoneNumber.dart';
import 'package:sure_move/Views/Authentication/Registration/screen_1.dart';
import 'package:sure_move/Views/Authentication/Registration/screen_2.dart';
import 'package:sure_move/Views/Authentication/Registration/screen_3.dart';
import 'package:sure_move/Views/Authentication/Registration/verifyMobileNumber.dart';
import 'package:sure_move/Views/Authentication/forgotPassword/newPassword.dart';
import 'package:sure_move/Views/Authentication/forgotPassword/verifyEmail.dart';
import 'package:sure_move/Views/Authentication/login.dart';
import 'package:sure_move/Views/splashScreen.dart';

class AppRouter {

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {


      case "/":
        return MaterialPageRoute( builder: (_) => const SplashScreen());

      case loginPage:
        return MaterialPageRoute( builder: (_) => const LoginPage());

       case registrationScreen1:
        return MaterialPageRoute( builder: (_) => const RegistrationScreen1());

        case phoneNumberPage:
        return MaterialPageRoute( builder: (_) => const PhoneNumberPage());


        case verifyMobileNumber:
        return MaterialPageRoute( builder: (_) => const VerifyMobileNumber());

      case registrationScreen2:
        return MaterialPageRoute( builder: (_) => const RegistrationScreen2());

        case registrationScreen3:
        return MaterialPageRoute( builder: (_) => const RegistrationScreen3());

        case verifyEmail:
        return MaterialPageRoute( builder: (_) => const VerifyEmail());

        case updatePassword:
        return MaterialPageRoute( builder: (_) => const UpdatePassword());



      default:
        throw "No route found";
    }
  }
}
