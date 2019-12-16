import 'package:credify/utils/get_month_string_by_month_int.dart';

String isoStringToDashboardDate(String isoDate) {
  String date = isoDate.substring(8, 10);
  String month =
      monthIntToMonthString(int.parse(isoDate.substring(5, 7))).substring(0, 3);
  return "$date $month";
}
