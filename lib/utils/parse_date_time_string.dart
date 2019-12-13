DateTime getDateTimeObject(String date) {
  String year = date.substring(6, 10);
  String month = date.substring(3, 5);
  String day = date.substring(0, 2);
  String toBeParsedDateTime = '$year-$month-$day 00:00:00.000';
  DateTime parsedDateTime = DateTime.parse(toBeParsedDateTime);
  return parsedDateTime;
}
