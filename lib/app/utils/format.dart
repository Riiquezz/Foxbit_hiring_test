import 'package:intl/intl.dart';

class Format {
  static String currency(double value) {
    if (value != 0.0) {
      final formatter =
          NumberFormat.simpleCurrency(decimalDigits: 2, locale: 'pt_BR');
      return formatter.format(value);
    }
    return '';
  }

  static String change(double value) {
    if (value != 0.0) {
      final formatter = NumberFormat("+0.00;-0.00");
      return formatter.format(value);
    }
    return '';
  }
}
