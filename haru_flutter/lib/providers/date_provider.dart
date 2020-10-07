import 'package:flutter/cupertino.dart';

class DateProvider extends ChangeNotifier{
  String _finalMonth = "";
  String get finalMonth => _finalMonth;

  set finalMonth(String val){

    _finalMonth = val;
    notifyListeners();
  }
}
