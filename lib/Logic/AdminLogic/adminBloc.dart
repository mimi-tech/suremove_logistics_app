import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sure_move/Logic/AdminLogic/adminEvent.dart';
import 'package:sure_move/Logic/AdminLogic/adminState.dart';
import 'package:sure_move/Models/DashboardModel/referralModel.dart';
import 'package:sure_move/Models/DashboardModel/totalEarningModel.dart';
import 'package:sure_move/Models/historyModels.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/dashboardServices.dart';
import 'package:sure_move/Services/userServices.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc(): super(AdminInitial()) {
    // handle Admin init
   // on<AdminPromotionalEarningsRequested>(_onPromotionalEarningRequested);
   
  }


  static Future<List<ReferralModel>> onPromotionalEarningRequested() async {

    try {
      var response = await DashboardServices.getAUserReferrals();
      if(response is Success){
        final List<dynamic> responseData = response.data!["data"];
         final referrals = responseData.map((json) => ReferralModel.fromJson(json)).toList();
         return referrals;
      }
      return [];
    }catch(e){
      return [];
    }
  }

  static Future<List<EarningModel>> getAllEarnings(NewUser user ,String driverId) async{
    var response = await DashboardServices.allEarnings(user,driverId);
    if(response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final earnings = responseData.map((json) => EarningModel.fromJson((json)))
          .toList();
      return earnings;
    }
    return [];
  }

  static Future<List<EarningModel>> getDailyEarnings(NewUser user ,String driverId) async{
    var response = await DashboardServices.allDailyEarnings(user,driverId);
    if(response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final earnings = responseData.map((json) => EarningModel.fromJson((json)))
          .toList();
      return earnings;
    }
    return [];
  }

  static Future<List<EarningModel>> getWeeklyEarnings(NewUser user ,String driverId) async{
    var response = await DashboardServices.allWeeklyEarnings(user,driverId);
    if(response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final earnings = responseData.map((json) => EarningModel.fromJson((json)))
          .toList();
      return earnings;
    }
    return [];
  }

  static Future<List<EarningModel>> getMonthlyEarnings(NewUser user ,String driverId) async{
    var response = await DashboardServices.allMonthlyEarnings(user,driverId);
    if(response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final earnings = responseData.map((json) => EarningModel.fromJson((json)))
          .toList();
      return earnings;
    }
    return [];
  }

  static Future<List<EarningModel>> getYearlyEarnings(NewUser user ,String driverId) async{
    var response = await DashboardServices.allYearlyEarnings(user,driverId);
    if(response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final earnings = responseData.map((json) => EarningModel.fromJson((json)))
          .toList();
      return earnings;
    }
    return [];
  }

  static Future<List<HistoryModel>> getWithdrawals(String type) async {
    var response = await DashboardServices.history(type);
    if(response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final history = responseData.map((json) => HistoryModel.fromJson((json)))
          .toList();
      return history;
    }

    return [];
  }
}