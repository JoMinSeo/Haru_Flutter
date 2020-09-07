import 'package:flutter/material.dart';
import 'package:haru_flutter/screens/main/main_body.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: MainBody(),
    );
  }
}
