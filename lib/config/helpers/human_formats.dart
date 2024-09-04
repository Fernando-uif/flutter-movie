import 'package:intl/intl.dart';

class HumanFormats {
  static String humanReadbleNumber(double formatNumber, [int decimals = 0]) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en',
    ).format(formatNumber);
    return formatterNumber;
  }
}
