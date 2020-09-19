import 'package:flutter/material.dart';
import 'package:haru_flutter/components/circle_button.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(20),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'September',
                      style: kBook.copyWith(fontSize: 36),
                    ),
                    Text(
                      'Today',
                      style: kBold.copyWith(fontSize: 32),
                    ),
                  ],
                ),
                CirCleButton(icon: Icon(Icons.search), press: () {
                  print('minseo');
                }),
                CirCleButton(icon: Icon(Icons.tune), press: (){
                  print('minseo');
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}


