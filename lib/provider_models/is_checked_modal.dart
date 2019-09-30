import 'package:flutter/material.dart';

class IsCheckedIn with ChangeNotifier {
  bool _isCheckedIn;

  IsCheckedIn(this._isCheckedIn);

  getIsCheckedIn() => _isCheckedIn;

  setIsCheckedIn(bool dummy) {
    _isCheckedIn = dummy;
    notifyListeners();
  }
}
