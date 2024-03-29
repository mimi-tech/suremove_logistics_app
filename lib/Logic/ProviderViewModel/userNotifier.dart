import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Views/VendorReg/vendorRegCollections.dart';
import 'package:sure_move/Presentation/utils/secrets.dart';
import 'package:sure_move/Providers/driverProvider.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/driverService.dart';


class UserNotifier extends ChangeNotifier {
  bool _loading = false;
  List<int> selectedIndex = [];
  bool get loading => _loading;
  DateTime selectedDate = DateTime.now();
  DateTime selectedExpDate = DateTime.now();
  dynamic issuedDate;
  dynamic expiringDate;
  String? imagePath;
  String? userEmailAddress;
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }
  addCompany(index, companyId, companyName ){
    selectedIndex.clear();
    selectedIndex.add(index);
    //add the company name to the json date

    VendorRegData().driverRegDataJson(
        companyId: companyId,
        owner: companyName == "sureMove"?true:false
    );
    notifyListeners();
}

  removeCompany(index, companyName){
    selectedIndex.remove(index);
    notifyListeners();
  }

  onIssuedDateSelector(context) async {
    try {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2100),
        helpText: 'Select Licence Issued date',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
        fieldLabelText: 'Issued date',
        fieldHintText: 'Month/Date/Year',

      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: kSeaGreen,
              onPrimary: Colors.white,
              surface: kSeaGreen,
              onSurface: kBlackColor,


            ),
            dialogBackgroundColor: kWhiteColor,
          ),
          child: child!,
        );
      });
      if (pickedDate != null) {
        //String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        selectedDate = pickedDate;
        issuedDate = "${selectedDate.toLocal()}".split(' ')[0];
        notifyListeners();
         return true;

      } else {
        ScaffoldMsg().errorMsg(context, "Error occurred");
      }
    }catch(e){
      ScaffoldMsg().errorMsg(context, e.toString());

    }
  }

  onExpiringDateSelector(context) async {
    try {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2100),
          helpText: 'Select Licence Expiring date',
          errorFormatText: 'Enter valid date',
          errorInvalidText: 'Enter date in valid range',
          fieldLabelText: 'Expiring date',
          fieldHintText: 'Month/Date/Year',

          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: kSeaGreen,
                  onPrimary: Colors.white,
                  surface: kSeaGreen,
                  onSurface: kBlackColor,


                ),
                dialogBackgroundColor: kWhiteColor,
              ),
              child: child!,
            );
          });
      if (pickedDate != null) {
        //String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        selectedExpDate = pickedDate;
        expiringDate = "${selectedExpDate.toLocal()}".split(' ')[0];
        notifyListeners();
        return true;

      } else {
        ScaffoldMsg().errorMsg(context, "Error occurred");
      }
    }catch(e){
      ScaffoldMsg().errorMsg(context, e.toString());

    }
  }

  onPickLocation(context) async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacePicker(googleMapKey)));
    dynamic address = result.formattedAddress;
    dynamic address2 = result.name;
    VendorRegData().driverRegDataJson(
      homeAddress: address + address2,
      currentLocation: BookingCollections.bookingDetails[0].sourceAddress,
      currentLocationLat: BookingCollections.bookingDetails[0].sourceLatitude,
      currentLocationLog: BookingCollections.bookingDetails[0].sourceLogitude,
      country: result.country!.name,
      state: result.administrativeAreaLevel1!.name
    );

    notifyListeners();
    return address + address2;
  }

  openCamera() async {
    XFile? file;
    file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      imagePath = file.path;
      notifyListeners();
  }
}

createDriverAccount(context)async{
    setLoading(true);
    var response = await DriverServices.registerDriver(
      VendorRegData.driverRegData[0].companyId,
      VendorRegData.driverRegData[0].homeAddress,
      VendorRegData.driverRegData[0].currentLocation,
      VendorRegData.driverRegData[0].currentLocationLat,
      VendorRegData.driverRegData[0].currentLocationLog,
      VendorRegData.driverRegData[0].lincense,
      VendorRegData.driverRegData[0].owner,
      VendorRegData.driverRegData[0].country,
      VendorRegData.driverRegData[0].state,
      VendorRegData.driverRegData[0].driverEmail,);

    if(response is Success){
      await AuthBloc().onGettingUserRequested(context);
      setLoading(false);
      return "Success";
    }
    if(response is Failure){
      print("Failed ${ response.errorResponse}");
      setLoading(false);
      return response.errorResponse;
    }
}
}