import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/forgotPassword/verifyEmailCode.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/awaitingScreen.dart';
import 'package:sure_move/Presentation/Views/Rejections/permissionDenied.dart';
import 'package:sure_move/Presentation/Views/VendorReg/screen1.dart';
import 'package:sure_move/Presentation/Views/Admin/DrawerComponents/Bookings/adminBookingTab.dart';
import 'package:sure_move/Presentation/Views/Admin/DrawerComponents/Bookings/cancelledBooking.dart';
import 'package:sure_move/Presentation/Views/Admin/DrawerComponents/Company/addNewCompany.dart';
import 'package:sure_move/Presentation/Views/Admin/DrawerComponents/Company/companyTab.dart';
import 'package:sure_move/Presentation/Views/Admin/DrawerComponents/Drivers/driversTab.dart';
import 'package:sure_move/Presentation/Views/Admin/adminTabBar.dart';
import 'package:sure_move/Presentation/Views/Authentication/Registration/phoneNumber.dart';
import 'package:sure_move/Presentation/Views/Authentication/Registration/screen_1.dart';
import 'package:sure_move/Presentation/Views/Authentication/Registration/screen_2.dart';
import 'package:sure_move/Presentation/Views/Authentication/Registration/screen_3.dart';
import 'package:sure_move/Presentation/Views/Authentication/Registration/verifyMobileNumber.dart';
import 'package:sure_move/Presentation/Views/Authentication/forgotPassword/newPassword.dart';
import 'package:sure_move/Presentation/Views/Authentication/forgotPassword/verifyEmail.dart';
import 'package:sure_move/Presentation/Views/Authentication/login.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/connectVendorPage.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/editBooking.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/matchDriver.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/itemDetails.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/location.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/recieverInfo.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/ringingScreen.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/viewBookingDetails.dart';
import 'package:sure_move/Presentation/Views/Booking/VendorBooking/decisionScreen.dart';
import 'package:sure_move/Presentation/Views/Booking/VendorBooking/deliveryScreen.dart';
import 'package:sure_move/Presentation/Views/Booking/VendorBooking/waitingScreen.dart';
import 'package:sure_move/Presentation/Views/Commons/homePage.dart';
import 'package:sure_move/Presentation/Views/Commons/splashScreen.dart';
import 'package:sure_move/Presentation/Views/Commons/support.dart';
import 'package:sure_move/Presentation/Views/Dashboard/AllPayments/allPaymentTab.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Earnings/earngsTab.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Orders/orderHistory.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Transactions/transactionsTab.dart';
import 'package:sure_move/Presentation/Views/Dashboard/home.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Earnings/promotionalEarnings.dart';
import 'package:sure_move/Presentation/Views/Funds/CashTransfer/transferCash.dart';
import 'package:sure_move/Presentation/Views/Funds/Funding/fundAccount.dart';
import 'package:sure_move/Presentation/Views/Funds/PaymentMethod.dart';
import 'package:sure_move/Presentation/Views/VendorReg/screen1.dart';
import 'package:sure_move/Presentation/Views/VendorReg/screen2.dart';
import 'package:sure_move/Presentation/Views/VendorReg/screen3.dart';

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

        case supportScreen:
        return MaterialPageRoute( builder: (_) => const SupportScreen());

        case dashboardHome:
        return MaterialPageRoute( builder: (_) => const DashboardHome());

        case promotionalEarning:
        return MaterialPageRoute( builder: (_) => const PromotionalEarning());

        case totalEarningsTab:
        return MaterialPageRoute( builder: (_) => const TotalEarningsTab());

        case transactionTab:
        return MaterialPageRoute( builder: (_) => const TransactionTab());

        case allPaymentTab:
        return MaterialPageRoute( builder: (_) => const AllPaymentTab());

        case orderHistory:
        return MaterialPageRoute( builder: (_) => const OrderHistory());

        case adminHome:
        return MaterialPageRoute( builder: (_) => const AdminTab());

        case onlineDrivers:
        return MaterialPageRoute( builder: (_) => const DriversTab());

        case companyTab:
        return MaterialPageRoute( builder: (_) => const CompanyTab());

        case addNewCompany:
        return MaterialPageRoute( builder: (_) =>  AddNewCompany());

        case adminBookingTab:
        return MaterialPageRoute( builder: (_) =>  AdminBookingTab());

       case cancelledBooking:
        return MaterialPageRoute( builder: (_) =>  CancelledBooking());

        case pickCompany:
        return MaterialPageRoute( builder: (_) =>  PickCompany());

        case licenceScreen:
        return MaterialPageRoute( builder: (_) =>  LicenceScreen());

        case vendorRegScreen3:
        return MaterialPageRoute( builder: (_) =>  VendorRegScreen3());

        case verifyEmailCode:
        return MaterialPageRoute( builder: (_) =>  VerifyEmailCode());

        case permissionDeniedScreen:
        return MaterialPageRoute( builder: (_) =>  PermissionDeniedScreen());

        case customerAwaitingScreen:
        return MaterialPageRoute( builder: (_) =>  CustomerAwaitingScreen());



      default:
        throw "No route found";
    }
  }
}
