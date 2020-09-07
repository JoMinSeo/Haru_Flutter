import 'package:flutter/material.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';

class CirCleButton extends StatelessWidget {
  const CirCleButton({
    Key key,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final Icon icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Colors.grey[300],
              spreadRadius: 1,
              offset: Offset(
                0.0, // Move to right 10  horizontally
                1.0, // Move to bottom 5 Vertically
              ),
            )
          ]),
      child: GestureDetector(
        onTap: press,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: icon,
          radius: getProportionateScreenHeight(30),
        ),
      ),
    );
  }
}