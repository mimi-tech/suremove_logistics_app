import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/DriverLogic/driverEvent.dart';
import 'package:sure_move/Logic/DriverLogic/driverState.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Models/companyModel.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
import 'package:sure_move/Providers/driverProvider.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/bookingServices.dart';
import 'package:sure_move/Services/companyServices.dart';
import 'package:sure_move/Services/driverService.dart';



class DriversBloc extends Bloc<DriverEvent, DriverState> {
  DriversBloc(): super(DriverInitial()) {
    // handle auth init
    on<DriverBookingDecisionRequested>(_onDriverBookingDecision);
    on<DriverUpdateBookingRequested>(_onUpdateBooking);
    on<DriverConfirmBookingRequested>(_onDriverConfirmBooking);
    on<DriverGetABookingRequested>(_onGetABookingStream);
    on<CustomerRatingDriverRequested>(_onCustomerRatingDriver);
    on<DriverBookingRejectionRequested>(_onDriverBookingRejectionRequested);

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

            return driver;
          }
          if(response is Failure){
            return false;
          }


    } catch (e) {

      return false;

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
          //TODO:call the endpoint for rejected booking
          emit(NotFound());
        }

      }
      if(response is Failure){
        emit(DriverDenied([response.errorResponse.toString()]));
      }
    }

  _onUpdateBooking(DriverUpdateBookingRequested event, Emitter<DriverState> emit) async {
    emit(IsBookingLegalLoading());
    var response = await BookingServices.updateBooking(event.item,event.isLegal,event.bookingId,event.totalAmount,event.amount);
    if(response is Success){
      emit(DriverIsLegal());

    }
    if(response is Failure){
      emit(DriverDenied([response.errorResponse.toString()]));
    }
  }

  _onDriverConfirmBooking(DriverConfirmBookingRequested event, Emitter<DriverState> emit) async {
    emit(DriverLoading());
    var response = await DriverServices.driverConfirmBooking(event.driverId,event.companyId);
    if(response is Success){
      emit(DriverSuccess());

    }
    if(response is Failure){
      emit(DriverDenied([response.errorResponse.toString()]));
    }
  }

   _onGetABookingStream(DriverGetABookingRequested event , Emitter<DriverState> emit) async {
    emit(DriverLoading());
      var response = await BookingServices.getABooking(event.customerAuthId);
      if(response is Success){
        BookingModel booking = BookingModel.fromJson(response.data!["data"]);
          if(booking.confirmDelivery == true){
            emit(DeliveryConfirmed([booking]));

          }

        }
    }

  _onCustomerRatingDriver(CustomerRatingDriverRequested event, Emitter<DriverState> emit) async {
    emit(DriverLoading());
    var response = await DriverServices.ratingDriver(event.message,event.companyID,event.rate,event.customerInfo,event.driverInfo,event.driverId);
    if(response is Success){
      emit(DriverSuccess());

    }
    if(response is Failure){
      emit(DriverDenied([response.errorResponse.toString()]));
    }
  }

  _onDriverBookingRejectionRequested(DriverBookingRejectionRequested event, Emitter<DriverState> emit) async {
    try{
    emit(DriverLoading());
    var response = await DriverServices.driverBookingRejections(
      event.driverId,
      event.firstName,
      event.lastName,
      event.email,
      event.companyId,
      event.customerInfo,
      event.phoneNumber,
      event.profilePicture,
      event.amount,
      event.companyInfo,
      event.bookingDetails
    );
    if(response is Success){
      emit(DriverRejectedBooking());

    }
    if(response is Failure){
      emit(DriverDenied([response.errorResponse.toString()]));
    }
  }catch(e){
      emit(DriverDenied([e.toString()]));
    }
  }
//---Driver registration section---

  Future<List<CompanyModel>> getCompanyList()async{

    try{
      var response = await CompanyServices.companyList();
      if(response is Success){
        final List<dynamic> responseData = response.data!["data"];
        final result = responseData.map((json) => CompanyModel.fromJson(json)).toList();
        return result;
      }
      if(response is Failure){
        throw response.errorResponse!;
      }
      throw [];
    }catch(e){
      throw e;
    }
  }}


