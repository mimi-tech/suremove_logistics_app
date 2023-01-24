import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sure_move/Logic/DriverLogic/driverEvent.dart';
import 'package:sure_move/Logic/DriverLogic/driverState.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/driverService.dart';



class DriversBloc extends Bloc<DriverEvent, DriverState> {
  DriversBloc(): super(DriverInitial()) {
    // handle auth init
    on<DriverUpdateStatusRequested>(_onUpdatingDriverStatusRequested);

  }




  _onUpdatingDriverStatusRequested(DriverUpdateStatusRequested event, Emitter<DriverState> emit) async {
    try{
      var response = await DriverServices.updateDriverStatus(event.driverId,event.type);
      if (response is Success) {
        return true;
      }
     
      if(response is Failure){
        return response.errorResponse.toString();
      }
    } catch (e) {
      return e;
    }
  }




}