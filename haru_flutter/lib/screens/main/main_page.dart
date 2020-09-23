import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/screens/main/main_body.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: MainBody(),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          alignment: Alignment.bottomRight,
          ringColor: kPink,
          ringDiameter: 350.0,
          ringWidth: 100.0,
          fabSize: getProportionateScreenWidth(52),
          fabElevation: 8.0,
          fabColor: kRed,
          fabOpenColor: kPink,
          fabOpenIcon: Icon(Icons.add, color: kWhite),
          fabCloseIcon: Icon(Icons.close, color: kWhite),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) {},
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(context, "You pressed 1");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.looks_one, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(context, "You pressed 2");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.looks_two, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(context, "You pressed 3");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.looks_3, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(
                    context, "You pressed 4. This one closes the menu on tap");
                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.looks_4, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
    ));
  }
}
