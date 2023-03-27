
class NewUser {
  String? email;
  String? password;
  String? userId;
  bool? isEmailVerified;
  String? phoneNumber;
  String? username;
  String? profileImageUrl;
  String? firstName;
  String? lastName;
  String? gender;
  dynamic walletBalance;
  dynamic referralCount;
  String? accountType;
  dynamic txnPin;
  bool? isOngoingBooking;
  bool? isActive;
  bool? blocked;
  dynamic promoBalance;
  dynamic totalEarning;
  dynamic totalWithdrawal;

  NewUser({

    this.email,
    this.password,
    this.userId,
    this.isEmailVerified,
    this.phoneNumber,
    this.username,
    this.profileImageUrl,
    this.firstName,
    this.lastName,
    this.gender,
    this.walletBalance,
    this.referralCount,
    this.accountType,
    this.txnPin,
    this.isOngoingBooking,
    this.isActive,
    this.blocked,
    this.promoBalance,
    this.totalEarning,
    this.totalWithdrawal

  });
  // now create converter

  factory NewUser.fromJson(Map<String,dynamic> responseData){
    return NewUser(
      email : responseData['email'] ?? "",
      password: responseData['password'] ?? "",
      userId: responseData['id'] ?? "",
      isEmailVerified: responseData['isEmailVerified'] ?? false,
      phoneNumber: responseData['phoneNumber'] ?? "",
      username: responseData['username'] ?? "",
      profileImageUrl: responseData['profileImageUrl'] ?? "",
      firstName: responseData['firstName'] ?? "",
      lastName: responseData['lastName'] ?? "",
      gender: responseData['gender'] ?? "",
      walletBalance: responseData['walletBalance'] ?? "",
      referralCount: responseData['referralCount'] ?? "",
      accountType: responseData['whoAreYou'] ?? "",
      txnPin: responseData['txnPin'] ?? "",
      isOngoingBooking: responseData['isOngoingBooking'] ?? false,
      isActive: responseData['inActive'] ?? true,
      blocked: responseData['blocked'] ?? false,
      promoBalance: responseData['promoBalance'] ?? 0,
      totalEarning: responseData['totalEarning'] ?? 0,
      totalWithdrawal: responseData['totalWithdrawal'] ?? 0,

    );
  }
  Map<String, dynamic> toJson() {
    return {

      "email": email,
      "password": password,
      "userId":userId,
      "isEmailVerified":isEmailVerified,
      "phoneNumber":phoneNumber,
      "username":username,
      "profileImageUrl":profileImageUrl,
      "firstName":firstName,
      "lastName":lastName,
      "gender":gender,
      "walletBalance":walletBalance,
      "referralCount":referralCount,
      "accountType":accountType,
      "txnPin":txnPin,
      "isOngoingBooking":isOngoingBooking,
      "isActive":isActive,
      "blocked":blocked,
      "promoBalance":promoBalance,
      "totalEarning":totalEarning,
      "totalWithdrawal":totalWithdrawal,
    };
  }}