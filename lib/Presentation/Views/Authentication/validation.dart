class Validator {

  static String? validateField(String? value) {
    if(value!.isEmpty) {
      return "Field can't be empty";
    }
    if(value.length < 6) {
      return "First name is too short";
    }

    return null;
  }


  static String? validateFirstName(String? value) {
    if(value!.isEmpty) {
      return "First name can't be empty";
    }
    if(value.length < 6) {
      return "First name is too short";
    }

    return null;
  }

  static String? validateLastName(String? value) {
    if(value!.isEmpty) {
      return "Last name can't be empty";
    }
    if(value.length < 6) {
      return "Last name is too short";
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if(value!.isEmpty) {
      return "user name can't be empty";
    }
    if(value.length < 6) {
      return "user name is too short";
    }

    return null;
  }


  static String? validateItemName(String? value) {
    if(value!.isEmpty) {
      return "Item name can't be empty";
    }
    if(value.length < 2) {
      return "Item name is too short";
    }

    return null;
  }

  static String? validateItemSize(String? value) {
    if(value!.isEmpty) {
      return "Item number can't be empty";
    }
    if(int.parse(value) > 50) {
      return "Item size can't be more than 50kg";
    }

    return null;
  }

  static String? validateItemNumber(String? value) {
    if(value!.isEmpty) {
      return "Item number can't be empty";
    }

    return null;
  }


  static String? validateMessage(String? value) {
    if(value!.isEmpty) {
      return "Message can't be empty";
    }
    if(value.length < 4) {
      return "Message is too short";
    }

    return null;
  }


  static String? validateContactTitle(String? value) {
    if(value!.isEmpty) {
      return "Contact title can't be empty";
    }
    if(value.length < 3) {
      return "Contact title is too short";
    }

    return null;
  }



  static String? validatePhoneNumber(String? value) {
    if(value!.isEmpty) {
      return "Phone Number can't be empty";
    }
    if(value.length < 10) {
      return "Phone Number is too short";
    }

    return null;
  }

  static String? validateEmail(String? value) {

    RegExp regex = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(value!.isEmpty) {
      return "Email address can't be empty";
    }
    if(value.length < 2) {
      return "Email address is too short";
    }
    if(!regex.hasMatch(value)){
      return "Please provide a valid email address";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if(value!.isEmpty) {
      return "password can't be empty";
    }
    if(value.length < 6) {
      return "Password is too short";
    }

    return null;
  }

  static String? validateAmount(String? value) {
    if(value!.isEmpty) {
      return "Amount can't be empty";
    }
    if(int.parse(value) < 1000) {
      return "Amount should be less than 100 NGN";
    }

    return null;
  }

  static String? validateTransferAmount(String? value) {
    if(value!.isEmpty) {
      return "Amount can't be empty";
    }
    if(int.parse(value) < 1) {
      return "Transfer amount should be less than 10";
    }

    return null;
  }


  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }


  //validate card expiring date
  static String? validateDate(String? value) {
    if (value!.isEmpty) {
      return Strings.fieldReq;
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(new RegExp(r'(\/)'))) {
      var split = value.split(new RegExp(r'(\/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);

    } else { // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }





}

class Strings {
  static const String fieldReq = 'This field is required';

}
