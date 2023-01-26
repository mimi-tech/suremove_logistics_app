import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/DriverLogic/driverEvent.dart';
import 'package:sure_move/Logic/DriverLogic/driverState.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
import 'package:sure_move/Providers/driverProvider.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/bookingServices.dart';
import 'package:sure_move/Services/driverService.dart';



class DriversBloc extends Bloc<DriverEvent, DriverState> {
  DriversBloc(): super(DriverInitial()) {
    // handle auth init
    on<DriverBookingDecisionRequested>(_onDriverBookingDecision);

  }




  onUpdatingDriverStatusRequested(driverId,type,context) async {
    try{
      var response = await DriverServices.updateDriverStatus(driverId,type);
      if (response is Success) {
        DriverModel driver = DriverModel.fromJson(response.data!["data"]);
        Provider.of<DriverProvider>(context,listen: false).setDriver(driver);
        return true;
      }
     
      if(response is Failure){
        ScaffoldMsg().errorMsg(context, response.errorResponse.toString());
      }
    } catch (e) {
      ScaffoldMsg().errorMsg(context, e.toString());

    }
  }

  onStreamingDriverLocation(driversId,context)  async {
    try{
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
          List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

          // this is all you need
          var first = placemarks.first;
          String? subLocality = first.subLocality;
          String? locality = first.locality;//Owerri
          String? administrativeArea = first.administrativeArea;//Imo
          String? country = first.country;//country
          String? hdh= first.subThoroughfare;//no
          String? ns = first.thoroughfare;//egbu Road
          String address = "$subLocality $ns $hdh $locality $administrativeArea state, $country";

          var response = await DriverServices.updateDriverLocation(driversId,position.latitude,position.longitude,address);
          if (response is Success) {

            DriverModel driver = DriverModel.fromJson(response.data!["data"]);
            Provider.of<DriverProvider>(context,listen: false).setDriver(driver);
            return true;
          }
          if(response is Failure){
            return response.errorResponse.toString();
          }


    } catch (e) {

      return e;

    }

  }


    Stream<dynamic> connectionStream(driversId) async* {
      while (true) {
        await Future.delayed(const Duration(milliseconds: 500));
        var response = await DriverServices.getADriverBookingConnection(driversId);

        if(response is Success){
        print("uuu");
          var bookingResponse = await BookingServices.getABooking(response.data!["data"]["customerId"]);
          if(bookingResponse is Success){
            print("rrrr");
            BookingModel booking = BookingModel.fromJson(bookingResponse.data!["data"]);

            yield booking;

          }


        }


      }
    }

    _onDriverBookingDecision(DriverBookingDecisionRequested event, Emitter<DriverState> emit) async {
    emit(DriverLoading());
      var response = await DriverServices.getADriverBookingDecision(event.driverId,event.customerId,event.type);
      if(response is Success){
        if(event.type == DecisionType.accept.name){
          emit(DriverSuccess());
        }else{
          emit(NotFound());
        }

      }
      if(response is Failure){
        print(event.type);
        emit(DriverDenied([response.errorResponse.toString()]));
      }
    }


}