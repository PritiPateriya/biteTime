import 'package:flutter/material.dart';

class AllMealChange extends ChangeNotifier {
  bool _value = false;

  bool get value {
    return _value;
  }

  void change(value) {
    _value = value;
    notifyListeners();
  }
}
