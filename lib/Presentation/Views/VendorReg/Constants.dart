import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';

class DriverRegConstants{
  DateTime selectedDate = DateTime.now();
  dynamic issuedDate;
  onDateSelector(context) async {
    try {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2100),
          helpText: 'Select Linence Issued date',
          errorFormatText: 'Enter valid date',
          errorInvalidText: 'Enter date in valid range',
          fieldLabelText: 'Issued date',
          fieldHintText: 'Month/Date/Year',

          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme:  const ColorScheme.dark(
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
        print(pickedDate);
        //String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        selectedDate = pickedDate;
        issuedDate = "${selectedDate.toLocal()}".split(' ')[0];
        return true;

      } else {
        ScaffoldMsg().errorMsg(context, "Error occurred");
      }
    }catch(e){
      ScaffoldMsg().errorMsg(context, e.toString());

    }
  }
}