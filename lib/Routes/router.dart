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
import 'package:sure_move/Views/Booking/CustomerBooking/connectVendorPage.dart';
import 'package:sure_move/Views/Booking/CustomerBooking/editBooking.dart';
import 'package:sure_move/Views/Booking/CustomerBooking/matchDriver.dart';
import 'package:sure_move/Views/Booking/CustomerBooking/itemDetails.dart';
import 'package:sure_move/Views/Booking/CustomerBooking/location.dart';
import 'package:sure_move/Views/Booking/CustomerBooking/recieverInfo.dart';
import 'package:sure_move/Views/Booking/CustomerBooking/ringingScreen.dart';
import 'package:sure_move/Views/Booking/CustomerBooking/viewBookingDetails.dart';
import 'package:sure_move/Views/Booking/VendorBooking/decisionScreen.dart';
import 'package:sure_move/Views/Booking/VendorBooking/deliveryScreen.dart';
import 'package:sure_move/Views/Booking/VendorBooking/waitingScreen.dart';
import 'package:sure_move/Views/Commons/homePage.dart';
import 'package:sure_move/Views/Commons/splashScreen.dart';
import 'package:sure_move/Views/Funds/CashTransfer/transferCash.dart';
import 'package:sure_move/Views/Funds/Funding/fundAccount.dart';
import 'package:sure_move/Views/Funds/PaymentMethod.dart';

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

        case homePage:
        return MaterialPageRoute( builder: (_) => const HomePage());

        case itemDetails:
        return MaterialPageRoute( builder: (_) => const ItemDetails());

        case itemDeliveryLocation:
        return MaterialPageRoute( builder: (_) => const ItemDeliveryLocation());

        case receiversInfo:
        return MaterialPageRoute( builder: (_) => const ReceiversInfo());

        case displayAmount:
        return MaterialPageRoute( builder: (_) => const DisplayAmount());

        case viewBookingDetails:
        return MaterialPageRoute( builder: (_) => const ViewBookingDetails());

        case ripplesAnimation:
        return MaterialPageRoute( builder: (_) => const RipplesAnimation());

        case connectedVendorPage:
        return MaterialPageRoute( builder: (_) => const ConnectedVendorPage());

        case customerEditBooking:
        return MaterialPageRoute( builder: (_) => const CustomerEditBooking());

        case vendorWaitingScreen:
        return MaterialPageRoute( builder: (_) => const VendorWaitingScreen());

        case decisionScreen:
        return MaterialPageRoute( builder: (_) => const DecisionScreen());

        case deliveryScreen:
        return MaterialPageRoute( builder: (_) => const DeliveryScreen());

        case paymentMethods:
        return MaterialPageRoute( builder: (_) => const PaymentMethods());

        case fundAccount:
        return MaterialPageRoute( builder: (_) => const FundAccount());

        case transferCash:
        return MaterialPageRoute( builder: (_) => const TransferCash());



      default:
        throw "No route found";
    }
  }
}
