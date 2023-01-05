
class NewUser {
  // id: userExist._id,
  // email: userExist.email,
  // isEmailVerified: userExist.isEmailVerified,
  // phoneNumber: userExist.phoneNumber,
  // username: userExist.username,
  // profileImageUrl: userExist.profileImageUrl,
  // firstName: userExist.firstName,
  // lastName: userExist.lastName,
  // gender: userExist.gender,
  // walletBalance: userExist.walletBalance,
  // referralCount: userExist.referralCount,
  // whoAreYou: userExist.whoAreYou,

  String? email;
  String? password;
  String? token;

  NewUser({

    this.email,
    this.password,
    this.token



  });
  // now create converter

  factory NewUser.fromJson(Map<String,dynamic> responseData){
    return NewUser(
      email : responseData['email'],
      password: responseData['password'],
      token: responseData['token'],

    );
  }
  Map<String, dynamic> toJson() {
    return {

      "email": email,
      "password": password,
      "token": token,

    };
  }}