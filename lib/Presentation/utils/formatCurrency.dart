import 'package:intl/intl.dart';

 formatCurrency(price) {


  String formattedMoney = NumberFormat.currency(
    locale: 'en_US',
    symbol: '₦',
    decimalDigits: 2,
  ).format(price);

  return formattedMoney;// $1,234.56
}
