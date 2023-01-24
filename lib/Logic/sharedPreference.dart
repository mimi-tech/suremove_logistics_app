import 'package:shared_preferences/shared_preferences.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';

class UserPreferences {


  Future<bool> saveUser(NewUser user) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email',user.email ?? "");
    prefs.setString('password',user.password ?? "");
    prefs.setString('userId',user.userId ?? "");
    prefs.setBool('isEmailVerified',user.isEmailVerified ?? false);
    prefs.setString('phoneNumber',user.phoneNumber ?? "");
    prefs.setString('username',user.username ?? "");
    prefs.setString('firstName',user.firstName ?? "");
    prefs.setString('lastName',user.lastName ?? "");
    prefs.setString('profileImageUrl',user.profileImageUrl ?? "");
    prefs.setString('gender',user.gender ?? "");
    prefs.setInt('walletBalance',user.walletBalance ?? 0);
    prefs.setInt('referralCount',user.referralCount ?? 0);
    prefs.setString('accountType',user.accountType ?? "");
    prefs.setString('txnPin',user.txnPin ?? "");
    prefs.setBool('isOngoingBooking',user.isOngoingBooking ?? false);
    prefs.setBool('isActive',user.isActive ?? true);



    return prefs.commit();

  }
  void saveEmailCode(String emailCode)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('scripsEmailCode',emailCode);
  }


  Future<NewUser> getUser ()  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();


    String email = prefs.getString("email") ?? "";
    String password = prefs.getString("password") ?? "";
    String userId = prefs.getString("userId") ?? "";
    bool isEmailVerified = prefs.getBool("isEmailVerified") ?? false;
    String phoneNumber = prefs.getString("phoneNumber") ?? "";
    String username = prefs.getString("username") ?? "";
    String profileImageUrl = prefs.getString("profileImageUrl") ?? "";
    String firstName = prefs.getString("firstName") ?? "";
    String lastName = prefs.getString("lastName") ?? "";
    String gender = prefs.getString("gender") ?? "";
    int walletBalance = prefs.getInt("walletBalance") ?? 0;
    int referralCount = prefs.getInt("referralCount") ?? 0;
    String accountType = prefs.getString("accountType") ?? "";
    String txnPin = prefs.getString("txnPin") ?? "";
    bool isOngoingBooking = prefs.getBool("isOngoingBooking") ?? false;
    bool isActive = prefs.getBool("isActive") ?? true;



    return NewUser(

      email: email,
      password: password,
      userId:userId,
      isEmailVerified:isEmailVerified,
      phoneNumber:phoneNumber,
      username:username,
      profileImageUrl:profileImageUrl,
      firstName:firstName,
      lastName:lastName,
      gender:gender,
      walletBalance:walletBalance,
      referralCount:referralCount,
      accountType:accountType,
      txnPin: txnPin,
        isOngoingBooking:isOngoingBooking,
        isActive:isActive


    );

  }
  void savePaymentType(String paymentType)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('paymentType',paymentType);
  }

  Future<String> getPaymentType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String paymentType = prefs.getString("paymentType") ?? kCard;
    return paymentType;
  }
  Future<String> getEmailCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String emailCode = prefs.getString("scripsEmailCode") ?? "";
    return emailCode;
  }

  void saveToken(String token)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token',token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }
  void saveAuthId(String userId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId',userId);
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId") ?? "";
    return userId;
  }


  void removeUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();


    prefs.remove('email');
    prefs.remove('password');
    prefs.remove('token');
    prefs.remove('userId');
    prefs.remove('isEmailVerified');
    prefs.remove('phoneNumber');
    prefs.remove('username');
    prefs.remove('profileImageUrl');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('gender');
    prefs.remove('walletBalance');
    prefs.remove('referralCount');
    prefs.remove('accountType');
    prefs.remove('txnPin');
    prefs.remove('isOngoingBooking');
    prefs.remove('isActive');




  }





}