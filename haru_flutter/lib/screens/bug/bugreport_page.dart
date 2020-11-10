import 'package:flutter/material.dart';
import 'package:haru_flutter/constants/constants.dart';

class BugReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("minseocho0309@gmail.com으로\n 버그를 제보하여 주세요", style: kMedium.copyWith(fontSize: 24)),
        ),
      ),
    );
  }
}
