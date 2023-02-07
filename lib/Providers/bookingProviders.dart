import 'package:flutter/material.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Models/bookingRequirmentsModel.dart';

class BookingProvider with ChangeNotifier {
  BookingModel _user =  BookingModel();
  BookingModel get user => _user;

  void setUser(BookingModel user) {
    _user = user;
    notifyListeners();
  }


  BookingRequirementsModel _requirements =  BookingRequirementsModel();
  BookingRequirementsModel get requirements => _requirements;

  void setRequirements(BookingRequirementsModel requirements) {
    _requirements = requirements;
    notifyListeners();
  }



}