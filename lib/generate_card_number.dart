import 'dart:math';

String generateCardNumber() {
  var rnd = Random();
  String randomFourDigitString = "";
  for (int i = 0; i < 4; i++) {
    randomFourDigitString += rnd.nextInt(10).toString();
  }
  return ("1234 3249 5567 " + randomFourDigitString);
}
