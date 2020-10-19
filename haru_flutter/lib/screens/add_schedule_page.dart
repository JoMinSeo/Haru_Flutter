import 'package:flutter/material.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        height: getProportionateScreenHeight(400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(80),
              decoration: BoxDecoration(
                  color: kPink,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)
                  )
              ),
              child: Center(
                child: Text(
                  "Create a new Task",
                  style: kMedium.copyWith(fontSize: 24, color: kWhite),
                ),
              ),
            ),
            TextField(

            )
          ],
        )
      ),
    );
  }
}
