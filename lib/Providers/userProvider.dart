import 'package:flutter/foundation.dart';
import 'package:sure_move/Models/userModel.dart';

class UserProvider with ChangeNotifier {
  NewUser _user =  NewUser();
  NewUser get user => _user;

  void setUser(NewUser user) {
    _user = user;
    notifyListeners();
  }



}