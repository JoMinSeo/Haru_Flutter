import 'package:flutter/cupertino.dart';

class ListProvider extends ChangeNotifier{
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();
  final scrollController = ScrollController();

  String _date = "Not set";
  String _time = "Not set";
  int _categoryIdx = 0;

  String get date => _date;

  set date(String date){
    _date = date;
    notifyListeners();
  }

  String get time => _time;

  set time(String time){
    _time = time;
    notifyListeners();
  }

  int get categoryIdx => _categoryIdx;

  set categoryIdx(int idx){
    _categoryIdx = idx;
    print(categoryIdx);
    notifyListeners();
  }
}