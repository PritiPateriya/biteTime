import 'package:flutter/material.dart';

class DashBordSelect extends ChangeNotifier {
  int _value;

  int get value {
    return _value;
  }

  void change(value) {
    _value = value;
    notifyListeners();
  }
}

class DashBordSelectString extends ChangeNotifier {
  String _value;
  String get value {
    return _value;
  }

  void changes(newValue) {
    _value = value;
    notifyListeners();
  }
}
