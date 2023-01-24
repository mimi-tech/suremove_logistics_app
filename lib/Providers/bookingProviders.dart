import 'package:flutter/material.dart';
import 'package:sure_move/Models/bookingModel.dart';

class BookingProvider with ChangeNotifier {
  BookingModel _user =  BookingModel();
  BookingModel get user => _user;

  void setUser(BookingModel user) {
    _user = user;
    notifyListeners();
  }



}