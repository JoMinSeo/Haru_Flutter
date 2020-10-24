import 'package:flutter/cupertino.dart';

class SelectDateProvider extends ChangeNotifier{
  DateTime _selectedValue = DateTime.now().toUtc();

  DateTime get selectedValue => _selectedValue;

  set selectedValue(DateTime dateTime){
    _selectedValue = dateTime;
    print("date: $_selectedValue");
    notifyListeners();
  }
}