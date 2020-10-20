import 'package:flutter/cupertino.dart';

class ListProvider extends ChangeNotifier{
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();
  final scrollController = ScrollController();

  String _title = "비었습니다.";
  String _content = "비었습니다.";

  String _date = "Not set";
  String _time = "Not set";
  DateTime _fullTime;
  int _categoryIdx = 0;

  String get date => _date;

  set date(String date){
    _date = date;
    print("date : $_date");
    notifyListeners();
  }

  String get time => _time;

  set time(String time){
    _time = time;
    print("time : $_time");
    notifyListeners();
  }

  int get categoryIdx => _categoryIdx;

  set categoryIdx(int idx){
    _categoryIdx = idx;
    print("categoryIdx : $_categoryIdx");
    notifyListeners();
  }

  String get title => _title;

  set title(String title){
    _title = title;
    print("title : $_title");
    notifyListeners();
  }

  String get content => _content;

  set content(String content){
    _content = content;
    print("content : $_content");
    notifyListeners();
  }

  DateTime get fullTime => _fullTime;

  set fullTime(DateTime fullTime){
    _fullTime = fullTime;
    print("fullTime : $_fullTime");
    notifyListeners();
  }

  init(){
    titleTextController.clear();
    contentTextController.clear();
    title = "비었습니다.";
    content = "비었습니다.";
    categoryIdx = 0;
    date = "Not set";
    time = "Not set";
  }
}