import 'package:sure_move/Models/driversModel.dart';

class VendorRegData{
  static List<DriverModel>driverRegData = <DriverModel>[];

  driverRegDataJson({
    companyId,
    homeAddress,
    currentLocation,
    currentLocationLat,
    currentLocationLog,
    lincense,
    owner,
    country,
    state,
    driverEmail
}){
    DriverModel dataJson  =DriverModel(
      companyId: companyId,
      homeAddress: homeAddress,
      currentLocation: currentLocation,
      currentLocationLat: currentLocationLat,
      currentLocationLog: currentLocationLat,
      lincense: lincense,
      owner: owner,
      country: country,
      state: state,
      driverEmail: driverEmail
    );

    if(driverRegData.isNotEmpty){
      for(var value in driverRegData){
        value.companyId = companyId??value.companyId;
        value.homeAddress = homeAddress??value.homeAddress;
        value.currentLocation = currentLocation??value.currentLocation;
        value.currentLocationLat = currentLocationLat??value.currentLocationLat;
        value.lincense = lincense??value.lincense;
        value.owner = owner??value.owner;
        value.country = country??value.country;
        value.state = state??value.state;
        value.driverEmail = driverEmail??value.driverEmail;

    }
    }else{
      driverRegData.add(dataJson);
    }
  }

}