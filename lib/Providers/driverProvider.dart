import 'package:flutter/foundation.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Models/userModel.dart';

class DriverProvider with ChangeNotifier {
  DriverModel _driver =  DriverModel();
  DriverModel get driver => _driver;

  void setDriver(DriverModel driver) {
    _driver = driver;
    notifyListeners();
  }



}