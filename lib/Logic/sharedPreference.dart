import 'package:shared_preferences/shared_preferences.dart';
import 'package:sure_move/Models/cardDetailsModel.dart';
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
  void saveCustomerCard(List<String> customerCard)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('customerCard',customerCard);
  }
  void saveCustomerId(int customerId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('customerId',customerId);
  }
  void saveCustomerActiveCard(String customerActiveCard)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customerActiveCard',customerActiveCard);
  }

  void saveCustomerCode(String customerCode)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customerCode',customerCode);
  }

  Future<int> getCustomerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int customerId = prefs.getInt("customerId") ?? 0;
    return customerId;
  }
  Future<String> getCustomerCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String customerCode = prefs.getString("customerCode") ?? "";
    return customerCode;
  }

  Future<List> getCustomerCard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List customerCard = prefs.getStringList("customerCard") ?? [];
    return customerCard;
  }

  Future<String> getCustomerActiveCard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String customerActiveCard = prefs.getString("customerActiveCard") ?? "";
    return customerActiveCard;
  }

  //Save users card details
  Future<bool> cardDetails(CardDetailsModal cardDetailsModal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('cardFirstFourDigit',cardDetailsModal.cardFirstFourDigit ?? '');
    prefs.setString('cardLastFourDigit',cardDetailsModal.cardFirstFourDigit ?? '');
    prefs.setString('authorizationCode',cardDetailsModal.authorizationCode ?? '');
    prefs.setString('cardType',cardDetailsModal.cardType ?? '');
    prefs.setString('cardBrand',cardDetailsModal.cardBrand ?? '');
    prefs.setString('cardBank',cardDetailsModal.cardBank ?? '');
    prefs.setString('expiringMonth',cardDetailsModal.expiringMonth ?? '');
    prefs.setString('expiringYear',cardDetailsModal.expiringYear ?? '');
    prefs.setString('cardNumber',cardDetailsModal.cardNumber ?? '');
    prefs.setString('cvv',cardDetailsModal.cvv ?? '');

    return prefs.commit();

  }



  //fetching the users card details
  Future<CardDetailsModal> getCardDetailsNew ()  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String cardFirstFourDigit = prefs.getString("cardFirstFourDigit") ?? "";
    String cardLastFourDigit = prefs.getString("cardLastFourDigit") ?? "";
    String authorizationCode = prefs.getString("authorizationCode") ?? "";
    String cardType = prefs.getString("cardType") ?? "";
    String cardBrand = prefs.getString("cardBrand") ?? '';
    String cardBank = prefs.getString("cardBank") ?? '';
    String expiringMonth = prefs.getString("expiringMonth") ?? '';
    String expiringYear = prefs.getString("expiringYear") ?? '';
    String cardNumber = prefs.getString("cardNumber") ?? '';
    String cvv = prefs.getString("cvv") ?? '';
    return CardDetailsModal(
        cardFirstFourDigit: cardFirstFourDigit,
        cardLastFourDigit: cardLastFourDigit,
        authorizationCode: authorizationCode,
        cardType: cardType,
        cardBrand: cardBrand,
        cardBank:cardBank,
        expiringMonth:expiringMonth,
        expiringYear:expiringYear,
        cardNumber:cardNumber,
        cvv:cvv
    );

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
    // prefs.remove('customerCard');
    // prefs.remove('customerId');
    // prefs.remove('customerActiveCard');
    // prefs.remove('customerCode');
    // prefs.remove('cardFirstFourDigit');
    // prefs.remove('cardLastFourDigit');
    // prefs.remove('authorizationCode');
    // prefs.remove('cardType');
    // prefs.remove('cardBrand');
    // prefs.remove('cardBank');
    // prefs.remove('expiringMonth');
    // prefs.remove('expiringYear');
    // prefs.remove('cardNumber');
    // prefs.remove('cvv');




  }

  void removeCard() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('customerCard');
    prefs.remove('customerId');
    prefs.remove('customerActiveCard');
    prefs.remove('customerCode');
    prefs.remove('cardFirstFourDigit');
    prefs.remove('cardLastFourDigit');
    prefs.remove('authorizationCode');
    prefs.remove('cardType');
    prefs.remove('cardBrand');
    prefs.remove('cardBank');
    prefs.remove('expiringMonth');
    prefs.remove('expiringYear');
    prefs.remove('cardNumber');
    prefs.remove('cvv');




  }





}