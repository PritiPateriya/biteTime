// ignore: unused_import
import 'package:bitetime/common_files/logger_print.dart';
import 'package:flutter/material.dart';

class Count extends ChangeNotifier {
  var _value;

  dynamic get value {
    return _value;
  }

  void change(value) {
    _value = value;
    notifyListeners();
  }
}

class Quantity extends ChangeNotifier {
  int _quantity;
  int get quantity {
    return _quantity;
  }

  void changeQuantity(quantity) {
    _quantity = quantity;
    notifyListeners();
  }
}

class AddMoreItems extends ChangeNotifier {
  List _itemss = [];
  dynamic get itemss {
    return _itemss;
  }

  void addMoreItems(dynamic dataItems) {
    _itemss.add(dataItems);
    notifyListeners();
  }
}
