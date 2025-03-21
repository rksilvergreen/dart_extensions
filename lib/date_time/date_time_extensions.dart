import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DateTimeExtension on DateTime {
  int get secondsSinceEpoch => (this.millisecondsSinceEpoch / 1000).floor();

  operator > (DateTime other) => millisecondsSinceEpoch > other.millisecondsSinceEpoch;
  operator >= (DateTime other) => millisecondsSinceEpoch >= other.millisecondsSinceEpoch;
  operator < (DateTime other) => millisecondsSinceEpoch < other.millisecondsSinceEpoch;
  operator <= (DateTime other) => millisecondsSinceEpoch <= other.millisecondsSinceEpoch;

  String format([String pattern = 'dd/MM/yyyy', String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}