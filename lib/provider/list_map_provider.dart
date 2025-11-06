import 'package:flutter/material.dart';

class ListMapProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _values = [];

  void addData(Map<String, dynamic> data) {
    _values.add(data);
    notifyListeners();
  }

  List<Map<String, dynamic>> getValues() => _values;

  void deleteData(int index) {
    _values.removeAt(index);
    notifyListeners();
  }

  void clearAll() {
    _values.clear();
    notifyListeners();
  }

  void updateData(Map<String, dynamic> updatedData) {
    final index = _values.indexWhere((item) => item["name"] == updatedData["name"]);

    if (index != -1) {
      _values[index] = updatedData;
      notifyListeners();
    }
  }
}
