import 'package:shared_preferences/shared_preferences.dart';
import 'package:sure_move/Models/userModel.dart';

class UserPreferences {


  Future<bool> saveUser(NewUser user) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email',user.email ?? "");
    prefs.setString('password',user.password ?? "");
    prefs.setString('token',user.token ?? "");


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
    String token = prefs.getString("token") ?? "";


    return NewUser(

      email: email,
      password: password,
      token:token,


    );

  }

  Future<String> getEmailCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String emailCode = prefs.getString("scripsEmailCode") ?? "";
    return emailCode;
  }


  void removeUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();


    prefs.remove('email');
    prefs.remove('password');
    prefs.remove('token');
    prefs.remove('scripsEmailCode');




  }





}